#!/usr/bin/env bash

set -eu
set -o pipefail

function templateRemoteHelmChart() {
  "$(dirname "$0")/templateRemoteHelmChart"
}

function templateLocalHelmChart() {
  "$(dirname "$0")/templateLocalHelmChart"
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
      yq <<<"$yaml" -erys '([.[] | select(.kind == "HelmRelease")]['"$index"']),(.[] | select(.kind | IN(["GitRepository", "HelmRepository"][])))' | templateRemoteHelmChart
    done
  fi
}

function getImages() {
  local chart="$1"
  templateLocalHelmChart "$chart" |
    grep -E '\s+image: \S+' |
    awk '{print $NF}' |
    tr -d '"' |
    sort -u |
    jq -Rn '[[inputs][] | {image: .}]' | yq -y
}

function updateChartYaml() {
  local chart="$1"
  local tmpDir
  tmpDir="$(mktemp -d)"
  echo "Working on '$chart'" >/dev/stderr
  echo "Images:" >/dev/stderr
  (
    echo "artifacthub.io/images: |"
    getImages "$chart" | awk '{print "  " $0}'
  ) | tee "$tmpDir/images.yaml"

  if yq -e .annotations "$chart/Chart.yaml" >/dev/null; then
    echo "Existing annotations:" >/dev/stderr
    yq -y '.annotations | del(.["artifacthub.io/images"])' "$chart/Chart.yaml" | tee "$tmpDir/annotations.yaml"
    echo "Cleaned Chart.yaml:" >/dev/stderr
    yq -y '. | del(.annotations)' "$chart/Chart.yaml" | tee >(sponge "$chart/Chart.yaml")
  else
    touch "$tmpDir/annotations.yaml"
  fi

  echo "New Chart.yaml:" >/dev/stderr
  (
    cat "$chart/Chart.yaml"
    echo "annotations:"
    (
      grep -v '{}' "$tmpDir/annotations.yaml" || true
      cat "$tmpDir/images.yaml"
    ) | awk '{print "  " $0}'
  ) | tee >(sponge "$chart/Chart.yaml")
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
