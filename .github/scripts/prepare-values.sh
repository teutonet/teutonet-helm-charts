#!/usr/bin/env bash

function mergeYaml() {
  local valuesFile="${1?}"
  local overrideJson="${2?}"
  (
    yq <"$valuesFile"
    echo "$overrideJson"
  ) | jq -s 'reduce .[] as $item ({}; . * $item)' | yq -y
}

set -ex
for chart in charts/*; do
  [[ -d "$chart" ]] || continue
  if [[ -f "$chart/ci/_common.sh" ]]; then
    commonValues="$("$chart/ci/_common.sh")"
    for values in "$chart/values.yaml" "$chart/ci/"*-values.yaml; do
      [[ -f "$values" ]] || continue
      mergeYaml "$values" "$commonValues" | sponge "$values"
    done
  fi
  for valuesScript in "$chart/ci/"*-values.sh; do
    [[ -f "$valuesScript" ]] || continue
    values="${valuesScript/.sh/.yaml}"
    mergeYaml "$values" "$("$valuesScript")" | sponge "$values"
  done
done
