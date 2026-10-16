#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

DOCKER_CONFIG="$(mktemp -d)"
export DOCKER_CONFIG
trap 'rm -rf "$DOCKER_CONFIG"' EXIT

source "$(dirname "$0")/grype-login-to-registries.sh"

function generateImageSbom() {
  set -e
  set -o pipefail
  [[ "$RUNNER_DEBUG" == 1 ]] && set -x
  local image="${1?}"
  local outFile="${2?}"
  syft "$image" -o "spdx-json=$outFile"

  # syft derives the image root's SPDXID from the repository name only, so two
  # tags of the same repo would collide when merged. Suffix it with the scanned
  # image digest, which also dedups refs that resolve to the same content.
  jq '
    (first(.packages[] | select(.primaryPackagePurpose == "CONTAINER")) // error("no image root in SBOM")) as $root |
    (first($root.checksums[]? | select(.algorithm == "SHA256") | .checksumValue) // error("no SHA256 checksum on image root \($root.SPDXID)")) as $digest |
    "\($root.SPDXID)-\($digest)" as $newId |
    .packages |= map(if .SPDXID == $root.SPDXID then .SPDXID = $newId else . end) |
    .relationships |= map(
      (if .spdxElementId == $root.SPDXID then .spdxElementId = $newId else . end) |
      (if .relatedSpdxElement == $root.SPDXID then .relatedSpdxElement = $newId else . end)
    )
  ' "$outFile" >"$outFile.tmp"
  mv "$outFile.tmp" "$outFile"
}
export -f generateImageSbom

function subchartDependencies() {
  local chart="${1?}"
  # Chart.lock holds the resolved versions, Chart.yaml may only contain ranges
  local source="$chart/Chart.yaml"
  [[ -f "$chart/Chart.lock" ]] && source="$chart/Chart.lock"
  yq -c '[(.dependencies // [])[] | {name, version, repository}]' "$source"
}

function helmReleaseDependencies() {
  local chart="${1?}"
  local tmpDir
  tmpDir="$(mktemp -d)"
  trap 'rm -rf "$tmpDir"' RETURN

  # prepare-values.sh overwrites values.yaml in place, so only ever run it on a copy
  local preparedChart
  preparedChart="$tmpDir/$(basename "$chart")"
  cp -r "$chart" "$preparedChart"
  "$(dirname "$0")/prepare-values.sh" "$preparedChart" 2>"$tmpDir/prepare-values.log" || {
    cat "$tmpDir/prepare-values.log" >&2
    return 1
  }

  local valuesFile
  for valuesFile in "$preparedChart"/ci/artifacthub-values*.yaml; do
    [[ -f "$valuesFile" ]] || continue
    # the HelmReleases are only rendered by the chart, so template it like the image extraction does
    # shellcheck disable=SC2016
    "$(dirname "$0")/templateLocalHelmChart" -1 "$preparedChart" "$valuesFile" |
      yq -sc '
        map(select(.kind | IN("HelmRepository", "GitRepository"))) as $sources |
        [
          # HelmReleases can also be nested in a flux ResourceSet instead of being top-level documents
          (.[] | select(.kind == "HelmRelease")), (.[] | select(.kind == "ResourceSet") | (.spec.resources // [])[] | select(.kind == "HelmRelease"))
          | . as $release | .spec.chart.spec as $spec |
          (
            first($sources[] | select(
              .kind == $spec.sourceRef.kind and
              .metadata.name == $spec.sourceRef.name and
              .metadata.namespace == ($spec.sourceRef.namespace // $release.metadata.namespace)
            )) // error("source \($spec.sourceRef.kind)/\($spec.sourceRef.name) of HelmRelease \($release.metadata.name) not found")
          ) as $source |
          {
            name: $spec.chart,
            version: ($spec.version // ($source.spec.ref | .tag // .semver // .commit // .branch) // error("no version for HelmRelease \($release.metadata.name)")),
            repository: $source.spec.url
          }
        ]'
  done | jq -sc 'add // [] | unique'
}

function generateChartSbom() {
  local chart="${1?}"
  local outFile="${2?}"
  local tmpDir
  tmpDir="$(mktemp -d)"
  trap 'rm -rf "$tmpDir"' RETURN

  local subcharts helmReleaseCharts
  subcharts="$(subchartDependencies "$chart")"
  helmReleaseCharts="$(helmReleaseDependencies "$chart")"

  local name version chartRef
  name="$(yq -r '.name' "$chart/Chart.yaml")"
  version="$(yq -r '.version' "$chart/Chart.yaml")"
  chartRef="SPDXRef-Package-Chart-${name}"

  # syft has no Helm cataloger, so the chart itself is authored by hand here as a
  # proper root package (pkg:helm purl) instead of using syft's generic directory
  # scan, which only produces a placeholder "FILE"-purpose package for the dir.
  jq -n --arg name "$name" --arg version "$version" --arg chartRef "$chartRef" \
    --arg namespace "https://spdx.org/spdxdocs/${name}-${version}-$(cat /proc/sys/kernel/random/uuid)" \
    --arg created "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    --argjson dependencies "$(jq -n --argjson a "$subcharts" --argjson b "$helmReleaseCharts" '$a + $b | unique')" '
    (
      $dependencies | map(
        . + {SPDXID: "SPDXRef-Package-Helm-\([.name, .version, .repository] | join("-") | gsub("[^A-Za-z0-9.-]+"; "-"))"}
      )
    ) as $dependencyCharts |
    {
      spdxVersion: "SPDX-2.3",
      dataLicense: "CC0-1.0",
      SPDXID: "SPDXRef-DOCUMENT",
      name: $name,
      documentNamespace: $namespace,
      creationInfo: {
        created: $created,
        creators: ["Tool: teutonet-helm-charts/generate-sbom.sh"]
      },
      packages: [{
        name: $name,
        SPDXID: $chartRef,
        versionInfo: $version,
        supplier: "NOASSERTION",
        downloadLocation: "NOASSERTION",
        filesAnalyzed: false,
        licenseConcluded: "NOASSERTION",
        licenseDeclared: "NOASSERTION",
        copyrightText: "NOASSERTION",
        externalRefs: [{
          referenceCategory: "PACKAGE-MANAGER",
          referenceType: "purl",
          referenceLocator: "pkg:helm/\($name)@\($version)"
        }],
        primaryPackagePurpose: "APPLICATION"
      }] + [
        # charts pulled in as subchart dependency or deployed through a templated HelmRelease
        $dependencyCharts | unique_by(.SPDXID)[] | {
          name: .name,
          SPDXID: .SPDXID,
          versionInfo: .version,
          supplier: "NOASSERTION",
          downloadLocation: "NOASSERTION",
          filesAnalyzed: false,
          licenseConcluded: "NOASSERTION",
          licenseDeclared: "NOASSERTION",
          copyrightText: "NOASSERTION",
          externalRefs: [{
            referenceCategory: "PACKAGE-MANAGER",
            referenceType: "purl",
            referenceLocator: "pkg:helm/\(.name)@\(.version)?repository_url=\(.repository | @uri)"
          }],
          primaryPackagePurpose: "APPLICATION"
        }
      ],
      files: [],
      relationships: [{
        spdxElementId: "SPDXRef-DOCUMENT",
        relatedSpdxElement: $chartRef,
        relationshipType: "DESCRIBES"
      }] + [
        $dependencyCharts | unique_by(.SPDXID)[] | {
          spdxElementId: $chartRef,
          relatedSpdxElement: .SPDXID,
          relationshipType: "DEPENDS_ON"
        }
      ]
    }
  ' >"$tmpDir/chart.spdx.json"

  # shellcheck disable=SC2046
  yq -r '.annotations["artifacthub.io/images"] // []' "$chart/Chart.yaml" |
    yq -r '.[] | .image' |
    sort -u |
    parallel $([[ -v GITHUB_JOB ]] || printf -- --bar) --retries 10 -P 0 -k generateImageSbom {} "$tmpDir/image-{#}.spdx.json"

  local imageFiles=()
  while IFS= read -r imageFile; do
    imageFiles+=("$imageFile")
  done < <(find "$tmpDir" -maxdepth 1 -type f -name 'image-*.spdx.json' | sort)

  jq -s --arg chartRef "$chartRef" '
    (.[0]) as $base |
    ($base.packages + ([.[1:][] | .packages] | add // [])) as $packages |
    ([.[1:][] | .files] | add // []) as $files |
    ([.[1:][] | .packages[] | select(.primaryPackagePurpose == "CONTAINER") |
      {spdxElementId: $chartRef, relatedSpdxElement: .SPDXID, relationshipType: "CONTAINS"}
    ]) as $containsRelationships |
    ([.[1:][] | .relationships[] | select(.relationshipType != "DESCRIBES")]) as $imageRelationships |
    ($base.relationships + $containsRelationships + $imageRelationships) as $relationships |
    ([.[1:][] | .hasExtractedLicensingInfos // []] | add // []) as $licenseInfos |
    $base
    | .packages = ($packages | unique_by(.SPDXID))
    | .files = ($files | unique_by(.SPDXID))
    | .relationships = ($relationships | unique)
    | if ($licenseInfos | length) > 0 then .hasExtractedLicensingInfos = ($licenseInfos | unique_by(.licenseId)) else . end
  ' "$tmpDir/chart.spdx.json" "${imageFiles[@]}" >"$outFile"
}

if [[ "$#" == 2 ]]; then
  generateChartSbom "$1" "$2"
else
  echo "Usage: $0 <chart-dir> <output-file>" >&2
  exit 1
fi
