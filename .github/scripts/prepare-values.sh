#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

function mergeYaml() {
  local valuesFile="${1?}"
  local overrideJson="${2?}"
  (
    yq <"$valuesFile"
    echo "$overrideJson"
  ) | jq -s 'reduce .[] as $item ({}; . * $item)' | yq -y
}

function prepare-values() {
  local chart="${1?}"
  local runByGit="$2"
  local commonValues
  local values
  local valuesScript
  if [[ -f "$chart/ci/_common.sh" ]]; then
    commonValues="$("$chart/ci/_common.sh")"
    for values in "$chart/values.yaml" "$chart/ci/"*-values.yaml; do
      [[ -f "$values" ]] || continue
      [[ "$runByGit" == GIT ]] && [[ "$(basename "$values")" == values.yaml ]] && continue
      mergeYaml "$values" "$commonValues" | sponge "$values"
    done
  fi
  for valuesScript in "$chart/ci/"*-values.sh; do
    [[ -f "$valuesScript" ]] || continue
    values="${valuesScript/.sh/.yaml}"
    mergeYaml "$values" "$("$valuesScript")" | sponge "$values"
  done
}

if [[ -v 1 ]] && [[ -v 2 ]]; then
  prepare-values "$1" "$2"
elif [[ -v 1 ]]; then
  prepare-values "$1"
else
  for chart in charts/*; do
    [[ -d "$chart" ]] || continue
    prepare-values "$chart" "$2"
  done
fi
