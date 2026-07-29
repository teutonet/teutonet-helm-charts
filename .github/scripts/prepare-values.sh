#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

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
  local commonValues
  local values
  if [[ -f "$chart/ci/_common.sh" ]]; then
    commonValues="$("$chart/ci/_common.sh")"
    values="$chart/values.yaml"
    mergeYaml "$values" "$commonValues" | sponge "$values"
    if [[ "$RUNNER_DEBUG" == 1 ]]; then
      cat "$values" >&2
    fi
  fi
}

set -ex
if [[ -v 1 ]]; then
  prepare-values "$1"
else
  for chart in charts/*; do
    [[ -d "$chart" ]] || continue
    prepare-values "$chart"
  done
fi
