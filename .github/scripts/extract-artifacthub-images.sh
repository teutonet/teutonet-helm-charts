#!/usr/bin/env bash

set -eu
set -o pipefail

function templateGitHelmRelease() {
  local gitUrl="$1"
  local gitRef="$2"
  local gitPath="$3"
  local namespace="$4"
  local releaseName="$5"
  local values="$6"
  local tmpDir
  tmpDir=$(mktemp -d)

  (
    git clone "$gitUrl" "$tmpDir"
    cd "$tmpDir"
    git checkout "$gitRef"
  ) >/dev/null

  helm dependency build "$tmpDir/$gitPath" >/dev/null
  helm <<<"$values" template --namespace "$namespace" "$releaseName" "$tmpDir/$gitPath" --values -
  rm -rf "$tmpDir"
}

function templateHelmRelease() {
  local yaml
  local helmReleaseYaml
  local namespace
  local releaseName
  local values
  local sourceNamespace
  local sourceName
  local sourceKind
  local sourceYaml
  local sourceResource
  local chartName
  yaml=$(cat -)
  helmReleaseYaml=$(yq <<<"$yaml" -erys '.[] | select(.kind == "HelmRelease")')

  namespace=$(yq <<<"$helmReleaseYaml" -er '.spec.targetNamespace // .metadata.namespace')
  releaseName=$(yq <<<"$helmReleaseYaml" -er '.spec.releaseName // .metadata.name')
  values=$(yq <<<"$helmReleaseYaml" -y -r .spec.values)
  echo "Templating '$namespace/$releaseName'" >/dev/stderr

  sourceNamespace=$(yq <<<"$helmReleaseYaml" -er ".spec.chart.spec.sourceRef.namespace // \"$namespace\"")
  sourceName=$(yq <<<"$helmReleaseYaml" -er .spec.chart.spec.sourceRef.name)
  sourceKind=$(yq <<<"$helmReleaseYaml" -er .spec.chart.spec.sourceRef.kind)
  sourceYaml=$(yq <<<"$yaml" -erys '[.[] | select(.kind == "'"$sourceKind"'")][]')
  set +e
  sourceResource=$(yq <<<"$sourceYaml" -erys "[.[] | select( (.metadata.namespace == \"$sourceNamespace\") and (.metadata.name == \"$sourceName\") )][0]")
  set -e
  # I can't check it directly as I need it's stdout 🤷
  # shellcheck disable=SC2181
  if [[ "$?" != 0 ]]; then
    echo "Failed to get source '$sourceNamespace/$sourceKind/$sourceName'" >/dev/stderr
    return 0
  fi
  chartName="$(yq <<<"$helmReleaseYaml" -er .spec.chart.spec.chart)"
  case "$sourceKind" in
  GitRepository)
    local gitUrl
    local gitRef
    gitUrl="$(yq <<<"$sourceResource" -er .spec.url)"
    gitRef="$(yq <<<"$sourceResource" -er '.spec.ref | if .branch then .branch elif .tag then .tag elif .semver then .semver elif .commit then .commit else "master" end')"
    templateGitHelmRelease "$gitUrl" "$gitRef" "$chartName" "$namespace" "$releaseName" "$values"
    ;;
  HelmRepository)
    local helmRepositoryUrl
    local chartVersion
    helmRepositoryUrl="$(yq <<<"$sourceResource" -er .spec.url)"
    chartVersion="$(yq <<<"$helmReleaseYaml" -er .spec.chart.spec.version)"
    helm <<<"$values" template --namespace "$namespace" --repo "$helmRepositoryUrl" "$releaseName" "$chartName" --version "$chartVersion" --values -
    ;;
  *)
    echo "'$sourceKind' is not implemented" >/dev/stderr
    ;;
  esac
}

function templateHelmChart() {
  local chart="$1"
  local yaml
  local numberOfHelmReleases
  echo "Templating '$chart'" >/dev/stderr
  helm dependency update "$chart"
  yaml=$(helm template "$(basename "$chart")" "$chart" --values "$chart/ci/artifacthub-values.yaml")
  numberOfHelmReleases=$(yq <<<"$yaml" -ers '[.[] | select(.kind == "HelmRelease")] | length')
  yq <<<"$yaml" -erys '.[] | select(.kind != "HelmRelease") | select(.)'
  if [[ "$numberOfHelmReleases" -gt 0 ]]; then
    for index in $(seq 0 $((numberOfHelmReleases - 1))); do
      echo ---
      yq <<<"$yaml" -erys '([.[] | select(.kind == "HelmRelease")]['"$index"']),(.[] | select(.kind | IN(["GitRepository", "HelmRepository"][])))' | templateHelmRelease
    done
  fi
}

function getImages() {
  local chart="$1"
  templateHelmChart "$chart" |
    grep -E '\s+image: \S+' |
    awk '{print $NF}' |
    tr -d '"' |
    sort -u |
    jq -Rn '[[inputs][] | {image: .}]' | yq -y
}

function updateChartYaml() {
  local chart="$1"
  local tmpFile
  tmpFile="$(mktemp)"
  echo "Working on '$chart'" >/dev/stderr
  getImages "$chart" > "$tmpFile"
  # I don't want the $ to be shell-interpreted
  # shellcheck disable=SC2016
  yq -y --rawfile annotations "$tmpFile" '. | .annotations["artifacthub.io/images"] = $annotations' "$chart/Chart.yaml" | tee >(sponge "$chart/Chart.yaml")
  rm -f "$tmpFile"
}

if [[ "$#" == 1 ]] && [[ -d "$1" ]]; then
  if ! [[ -f "charts/$1/ci/artifacthub-values.yaml" ]]; then
    echo "There is no 'artifacthub-values.yaml' in 'charts/$1/ci', exiting" >/dev/stderr
    exit 1
  fi
  updateChartYaml "charts/$1"
else
  for chart in charts/*; do
    [[ "$chart" == "charts/*" ]] && continue
    [[ -f "$chart/ci/artifacthub-values.yaml" ]] || continue

    updateChartYaml "$chart"
  done
fi
