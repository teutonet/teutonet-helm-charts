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
  helm template ${namespace:+--namespace "$namespace"} "$releaseName" "$tmpDir/$gitPath" --values <([[ -f "$values" ]] && cat "$values" || echo "$values")
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
  helmReleaseYaml=$(yq -erys '.[] | select(.kind == "HelmRelease")' <<<"$yaml")

  namespace=$(yq -er '.spec.targetNamespace // .metadata.namespace' <<<"$helmReleaseYaml")
  releaseName=$(yq -er '.spec.releaseName // .metadata.name' <<<"$helmReleaseYaml")
  values=$(yq -y -r .spec.values <<<"$helmReleaseYaml")
  echo "Templating '$namespace/$releaseName'" >/dev/stderr

  sourceNamespace=$(yq -er ".spec.chart.spec.sourceRef.namespace // \"$namespace\"" <<<"$helmReleaseYaml")
  sourceName=$(yq -er .spec.chart.spec.sourceRef.name <<<"$helmReleaseYaml")
  sourceKind=$(yq -er .spec.chart.spec.sourceRef.kind <<<"$helmReleaseYaml")
  sourceYaml=$(yq -erys '[.[] | select(.kind == "'"$sourceKind"'")][]' <<<"$yaml")
  set +e
  sourceResource=$(yq -erys "[.[] | select( (.metadata.namespace == \"$sourceNamespace\") and (.metadata.name == \"$sourceName\") )][0]" <<<"$sourceYaml")
  set -e
  # I can't check it directly as I need it's stdout 🤷
  # shellcheck disable=SC2181
  if [[ "$?" != 0 ]]; then
    echo "Failed to get source '$sourceNamespace/$sourceKind/$sourceName'" >/dev/stderr
    return 0
  fi
  chartName="$(yq -er .spec.chart.spec.chart <<<"$helmReleaseYaml")"
  case "$sourceKind" in
    GitRepository)
      local gitUrl
      local gitRef
      gitUrl="$(yq -er .spec.url <<<"$sourceResource")"
      gitRef="$(yq -er '.spec.ref | if .branch then .branch elif .tag then .tag elif .semver then .semver elif .commit then .commit else "master" end' <<<"$sourceResource")"
      templateGitHelmRelease "$gitUrl" "$gitRef" "$chartName" "$namespace" "$releaseName" "$values"
      ;;
    HelmRepository)
      local helmRepositoryUrl
      local chartVersion
      helmRepositoryUrl="$(yq -er .spec.url <<<"$sourceResource")"
      chartVersion="$(yq -er .spec.chart.spec.version <<<"$helmReleaseYaml")"
      helm template --namespace "$namespace" --repo "$helmRepositoryUrl" "$releaseName" "$chartName" --version "$chartVersion" --values - <<<"$values"
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
  numberOfHelmReleases=$(yq -ers '[.[] | select(.kind == "HelmRelease")] | length' <<<"$yaml")
  echo "$yaml"
  if [[ "$numberOfHelmReleases" -gt 0 ]]; then
    for index in $(seq 0 $((numberOfHelmReleases - 1))); do
      echo ---
      yq -erys '([.[] | select(.kind == "HelmRelease")]['"$index"']),(.[] | select(.kind | IN(["GitRepository", "HelmRepository"][])))' <<<"$yaml" | templateHelmRelease
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

case "$script" in
  templateHelmChart | templateLocalHelmChart)
    templateLocalHelmChart "$@" | templateSubHelmCharts
    ;;
  templateRemoteHelmChart)
    templateRemoteHelmChart "$@" | templateSubHelmCharts
    ;;
  templateGitHelmChart)
    templateGitHelmChart "$@" | templateSubHelmCharts
    ;;
  *)
    echo "Wrong script: '$0'" >/dev/stderr
    exit 1
    ;;
esac
