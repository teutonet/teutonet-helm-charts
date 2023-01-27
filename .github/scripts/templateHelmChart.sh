#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

function templateGitHelmRelease() {
  local gitUrl="$1"
  local gitRef="$2"
  local gitPath="$3"
  local namespace="$4"
  local releaseName="$5"
  local values="$6"
  local tmpDir
  tmpDir=$(mktemp -d -p "$TMP_DIR")

  (
    git clone -q "$gitUrl" "$tmpDir"
    cd "$tmpDir"
    git checkout -q "$gitRef"
  ) >/dev/null

  helm dependency update "$tmpDir/$gitPath" >/dev/null
  helm template ${namespace:+--namespace "$namespace"} "$releaseName" "$tmpDir/$gitPath" --values <(if [[ -f "$values" ]]; then cat "$values"; else echo "$values"; fi)
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
  sourceYaml=$(yq <<<"$yaml" -rys '[.[] | select(.kind == "'"$sourceKind"'")][]')
  sourceResource=$(yq <<<"$sourceYaml" -rys "[.[] | select( (.metadata.namespace == \"$sourceNamespace\") and (.metadata.name == \"$sourceName\") )][0]")
  if [[ "$sourceResource" =~ .*"null".* ]]; then
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

function templateLocalHelmChart() {
  local chart="${1?}"
  local values="${2:-$chart/ci/artifacthub-values.yaml}"
  echo "Templating '$chart' with '$values'" >/dev/stderr
  helm dependency update "$chart" >/dev/null
  helm template "$(basename "$chart")" "$chart" --values "$values"
}

function templateSubHelmCharts() {
  local yaml
  local numberOfHelmReleases

  yaml=$(cat -)
  numberOfHelmReleases=$(yq <<<"$yaml" -ers '[.[] | select(.kind == "HelmRelease")] | length')
  echo "$yaml"
  if [[ "$numberOfHelmReleases" -gt 0 ]]; then
    for index in $(seq 0 $((numberOfHelmReleases - 1))); do
      echo ---
      yq <<<"$yaml" -erys '([.[] | select(.kind == "HelmRelease")]['"$index"']),(.[] | select(.kind | IN(["GitRepository", "HelmRepository"][])))' | templateHelmRelease
    done
  fi
}

function templateRemoteHelmChart() {
  local repo="${1?}"
  local chart="${2?}"
  local values="${3:-charts/$chart/ci/artifacthub-values.yaml}"

  echo "Templating '$repo/$chart' with '$values'" >/dev/stderr

  helm template --repo "$repo" "$chart" "$chart" --values "$values"
}

function templateGitHelmChart() {
  local repo="${1?}"
  local path="${2?}"
  local branch="${3?}"
  local values="${4:-charts/$path/ci/artifacthub-values.yaml}"

  echo "Templating '$repo/$path' with '$values'" >/dev/stderr

  templateGitHelmRelease "$repo" "$branch" "$path" "" "$(basename "$path")" "$values"
}

script="$(basename -s .sh "$0")"

recursive=true
if [[ "${1:-}" == -1 ]]; then
  recursive=false
  shift
fi

case "$script" in
  templateHelmChart | templateLocalHelmChart)
    templateLocalHelmChart "$@"
    ;;
  templateRemoteHelmChart)
    templateRemoteHelmChart "$@"
    ;;
  templateGitHelmChart)
    templateGitHelmChart "$@"
    ;;
  templateHelmRelease)
    templateHelmRelease "$@"
    ;;
  *)
    echo "Wrong script: '$0'" >/dev/stderr
    exit 1
    ;;
esac | (if [[ "$recursive" == true ]]; then templateSubHelmCharts; else cat -; fi)
