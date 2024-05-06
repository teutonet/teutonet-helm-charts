#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

[[ ! -v TMP_DIR ]] && trap 'rm -rf "$TMP_DIR"' EXIT
TMP_DIR="${TMP_DIR:-$(mktemp -d)}"

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
      yq <<<"$yaml" -erys '([.[] | select(.kind == "HelmRelease")]['"$index"']),(.[] | select(.kind | IN(["GitRepository", "HelmRepository"][])))' | "$(dirname "$0")/templateRemoteHelmChart"
    done
  fi
}

function getImages() {
  local chart="$1"
  local tmpDir
  tmpDir="$(mktemp -d -p "$TMP_DIR")"
  "$(dirname "$0")/templateLocalHelmChart" -1 "$chart" >"$tmpDir/helmRelease.yaml"
  "$(dirname "$0")/splitYamlIntoDir" "$tmpDir/helmRelease.yaml" "$tmpDir/helmRelease"

  (
    cd "$tmpDir/helmRelease"
    rm -f -- */HelmRelease/*.yaml
    grep -Er '\s+image: \S+$' |
      grep -v 'artifacthub-ignore' |
      awk '{print $3 " # " $1}' |
      tr -d '"' |
      sed 's#:$##' |
      sort -k1 -k2 |
      uniq |
      column -t |
      jq -Rn '[[inputs][] | {image: .}]' |
      yq -y |
      tr -d "'"
  )
}

function updateChartYaml() {
  local chart="$1"
  local tmpDir
  tmpDir="$(mktemp -d -p "$TMP_DIR")"
  echo "Working on '$chart'" >/dev/stderr
  echo "Images:" >/dev/stderr
  (
    echo "artifacthub.io/images: |"
    getImages "$chart" | awk '{print "  " $0}'
  ) | tee "$tmpDir/images.yaml" >/dev/stderr

  if yq -e .annotations "$chart/Chart.yaml" >/dev/null; then
    echo "Existing annotations:" >/dev/stderr
    yq -y '.annotations | del(.["artifacthub.io/images"])' "$chart/Chart.yaml" | tee "$tmpDir/annotations.yaml" >/dev/stderr
    echo "Cleaned Chart.yaml:" >/dev/stderr
    yq -y '. | del(.annotations)' "$chart/Chart.yaml" | tee >(sponge "$chart/Chart.yaml") >/dev/stderr
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
  if yq -e '.type == "library"' "$1/Chart.yaml" >/dev/null; then
    echo "Skipping library chart '$1'" >/dev/stderr
    exit 0
  fi
  if ! [[ -f "$1/ci/artifacthub-values.yaml" ]]; then
    echo "There is no 'artifacthub-values.yaml' in 'charts/$1/ci', exiting" >/dev/stderr
    exit 1
  fi
  updateChartYaml "$1"
else
  for chart in charts/*; do
    [[ "$chart" == "charts/*" ]] && continue
    [[ -f "$chart/ci/artifacthub-values.yaml" ]] || continue

    if yq -e '.type == "library"' "$chart/Chart.yaml" >/dev/null; then
      echo "Skipping library chart '$chart'" >/dev/stderr
      exit 0
    fi
    updateChartYaml "$chart"
  done
fi
