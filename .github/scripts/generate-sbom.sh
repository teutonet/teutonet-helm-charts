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
}
export -f generateImageSbom

function generateChartSbom() {
  local chart="${1?}"
  local outFile="${2?}"
  local tmpDir
  tmpDir="$(mktemp -d)"
  trap 'rm -rf "$tmpDir"' RETURN

  local name version chartRef
  name="$(yq -r '.name' "$chart/Chart.yaml")"
  version="$(yq -r '.version' "$chart/Chart.yaml")"
  chartRef="SPDXRef-Package-Chart-${name}"

  # syft has no Helm cataloger, so the chart itself is authored by hand here as a
  # proper root package (pkg:helm purl) instead of using syft's generic directory
  # scan, which only produces a placeholder "FILE"-purpose package for the dir.
  jq -n --arg name "$name" --arg version "$version" --arg chartRef "$chartRef" \
    --arg namespace "https://spdx.org/spdxdocs/${name}-${version}-$(cat /proc/sys/kernel/random/uuid)" \
    --arg created "$(date -u +%Y-%m-%dT%H:%M:%SZ)" '
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
      }],
      files: [],
      relationships: [{
        spdxElementId: "SPDXRef-DOCUMENT",
        relatedSpdxElement: $chartRef,
        relationshipType: "DESCRIBES"
      }]
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
    $base
    | .packages = ($packages | unique_by(.SPDXID))
    | .files = ($files | unique_by(.SPDXID))
    | .relationships = ($relationships | unique)
  ' "$tmpDir/chart.spdx.json" "${imageFiles[@]}" >"$outFile"
}

if [[ "$#" == 2 ]]; then
  generateChartSbom "$1" "$2"
else
  echo "Usage: $0 <chart-dir> <output-file>" >&2
  exit 1
fi
