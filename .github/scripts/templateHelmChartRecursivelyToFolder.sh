#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

chart=${1?You need to provide the chart name}
targetDir=${2?You need to provide the target directory}

if yq -e '.type == "library"' "$chart/Chart.yaml" &>/dev/null; then
  echo "Skipping library chart '$chart'" >&2
  [[ -v GITHUB_OUTPUT && -f "$GITHUB_OUTPUT" ]] && echo "skipped=true" | tee -a "$GITHUB_OUTPUT"
  exit 0
else
  [[ -v GITHUB_OUTPUT && -f "$GITHUB_OUTPUT" ]] && echo "skipped=false" | tee -a "$GITHUB_OUTPUT"
fi

[[ ! -d "$targetDir" ]] && mkdir -p "$targetDir"

function templateAndSplit() {
  [[ -v RUNNER_DEBUG ]] && [[ "$RUNNER_DEBUG" == 1 ]] && set -x
  local values="${1?}"
  [[ -f "$values" ]] || return 0
  local chart="${2?}"
  local targetDir="${3?}"
  newResourcesDir="$targetDir/$(basename -s .yaml "$values")"

  mkdir "$newResourcesDir"

  parallel --semaphore-name templateLocalHelmChart --fg -P 100% "$BIN/templateLocalHelmChart" -1 "$chart" "$values" | yq -y -S >"$newResourcesDir.yaml"
  "$BIN/splitYamlIntoDir" "$newResourcesDir.yaml" "$newResourcesDir"
}
export -f templateAndSplit

export BIN="$(dirname "$0")"
parallel $([[ -v GITHUB_JOB ]] || printf --bar) -P 100% templateAndSplit {} "$chart" "$targetDir" ::: "$chart/values.yaml" "$chart/ci/"*-values.yaml
