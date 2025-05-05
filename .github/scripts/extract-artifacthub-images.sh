#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

[[ ! -v TMP_DIR ]] && trap 'rm -rf "$TMP_DIR"' EXIT
TMP_DIR="${TMP_DIR:-$(mktemp -d)}"

function getImages() {
  local chart="$1"
  local existingDir="${2:-}"
  local valuesFile="${3:-}"
  local existingValuesDir
  existingValuesDir="$2/$(basename --suffix=.yaml "$valuesFile")"
  local tmpDir
  tmpDir="$(mktemp -d -p "$TMP_DIR")"
  if [[ -n "$2" && -d "$existingValuesDir" ]]; then
    cp -r "$existingValuesDir" "$tmpDir/helmRelease"
  else
    "$(dirname "$0")/templateLocalHelmChart" -1 "$chart" "$valuesFile" >"$tmpDir/helmRelease.yaml"
    "$(dirname "$0")/splitYamlIntoDir" "$tmpDir/helmRelease.yaml" "$tmpDir/helmRelease"
  fi

  (
    cd "$tmpDir/helmRelease"
    rm -f -- */HelmRelease/*.yaml
    (
      grep -Er '\s+image: \S+$' |
        grep -v 'artifacthub-ignore' || { if [[ "$?" == 2 ]]; then exit 2; fi; }
    )
  )
}

function updateChartYaml() {
  local chart="$1"
  local existingDir="${2:-}"
  local tmpDir
  tmpDir="$(mktemp -d -p "$TMP_DIR")"
  local allImages="$tmpDir/all_images.yaml"

  for valuesFile in "$chart/ci/artifacthub-values"*.yaml; do
    if [[ ! -f "$valuesFile" ]]; then
      echo "No artifacthub-values files found in '$chart/ci/', exiting" >&2
      exit 1
    fi

    getImages "$chart" "$existingDir" "$valuesFile"
  done |
    awk '{print ($2 == "-" ? $4 : $3) " # " $1}' |
    tr -d '"' |
    sed 's#:$##' |
    sort -k1 -k2 |
    uniq |
    column -t |
    jq -Rn '[[inputs][] | {image: .}]' |
    yq -y |
    tr -d "'" >"$allImages"

  # shellcheck disable=SC2016
  yq -Y -i --rawfile allImages "$allImages" '.annotations |= (. + {"artifacthub.io/images": $allImages | sub("\\s*$"; "")})' "$chart/Chart.yaml"
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
  if [[ -v 2 && ! -d "$2/artifacthub-values" ]]; then
    echo "Missing artifacthub-values directory '$2', exiting" >&2
    exit 1
  fi
  updateChartYaml "$1" "${2:-}"
else
  for chart in charts/*; do
    [[ -d "$chart" ]] || continue
    [[ -f "$chart/ci/artifacthub-values.yaml" ]] || continue

    if yq -e '.type == "library"' "$chart/Chart.yaml" >/dev/null; then
      echo "Skipping library chart '$chart'" >&2
      exit 0
    fi
    updateChartYaml "$chart"
  done
fi
