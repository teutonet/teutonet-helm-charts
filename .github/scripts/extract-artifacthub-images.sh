#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

[[ ! -v TMP_DIR ]] && trap 'rm -rf "$TMP_DIR"' EXIT
TMP_DIR="${TMP_DIR:-$(mktemp -d)}"

function getImages() {
  local chart="$1"
  local tmpDir
  tmpDir="$(mktemp -d -p "$TMP_DIR")"
  if [[ -v 2 ]] && [[ -n "$2" ]]; then
    cp -r "$2/artifacthub-values" "$tmpDir/helmRelease"
  else
    "$(dirname "$0")/templateLocalHelmChart" -1 "$chart" >"$tmpDir/helmRelease.yaml"
    "$(dirname "$0")/splitYamlIntoDir" "$tmpDir/helmRelease.yaml" "$tmpDir/helmRelease"
  fi

  (
    cd "$tmpDir/helmRelease"
    rm -f -- */HelmRelease/*.yaml
    grep -Er '\s+image: \S+$' |
      grep -v 'artifacthub-ignore' |
      awk '{print ($2 == "-" ? $4 : $3) " # " $1}' |
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
  local existingDir="${2:-}"
  local tmpDir
  tmpDir="$(mktemp -d -p "$TMP_DIR")"
  (
    echo "artifacthub.io/images: |"
    getImages "$chart" "$existingDir" | awk '{print "  " $0}'
  ) | tee "$tmpDir/images.yaml" >&2

  if yq -e .annotations "$chart/Chart.yaml" >/dev/null; then
    yq -y '.annotations | del(.["artifacthub.io/images"])' "$chart/Chart.yaml" >"$tmpDir/annotations.yaml"
    yq -y '. | del(.annotations)' "$chart/Chart.yaml" | sponge "$chart/Chart.yaml"
  else
    touch "$tmpDir/annotations.yaml"
  fi

  (
    cat "$chart/Chart.yaml"
    echo "annotations:"
    (
      grep -v '{}' "$tmpDir/annotations.yaml" || true
      cat "$tmpDir/images.yaml"
    ) | awk '{print "  " $0}'
  ) | sponge "$chart/Chart.yaml"
}

if [[ "$#" -ge 1 ]]; then
  if ! [[ -d "$1" ]]; then
    echo "Invalid chart directory '$1', exiting" >&2
    exit 1
  fi
  if yq -e '.type == "library"' "$1/Chart.yaml" >/dev/null; then
    echo "Skipping library chart '$1'" >&2
    exit 0
  fi
  if ! [[ -f "$1/ci/artifacthub-values.yaml" ]]; then
    echo "There is no 'artifacthub-values.yaml' in 'charts/$1/ci', exiting" >&2
    exit 1
  fi
  if [[ -v 2 ]] && ! [[ -d "$2/artifacthub-values" ]]; then
    echo "Missing artifacthub-values directory '$2', exiting" >&2
    exit 1
  fi
  updateChartYaml "$1" "${2:-}"
else
  for chart in charts/*; do
    [[ "$chart" == "charts/*" ]] && continue
    [[ -f "$chart/ci/artifacthub-values.yaml" ]] || continue

    if yq -e '.type == "library"' "$chart/Chart.yaml" >/dev/null; then
      echo "Skipping library chart '$chart'" >&2
      exit 0
    fi
    updateChartYaml "$chart"
  done
fi
