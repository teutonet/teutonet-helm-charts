#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

function createSarifReports() {
  local chart="${1?}"
  mkdir -p reports

  yq -r '.annotations["artifacthub.io/images"]' "$chart/Chart.yaml" |
    yq -r '.[] | .image' |
    parallel -P 0 -k generateSarifReport "$chart" "{}" "reports/{#}.sarif.json"
}

function generateSarifReport() {
  local chart="${1?}"
  local image="${2?}"
  local outFile="${3?}"
  local locationsJson
  # shellcheck disable=SC2016
  locationsJson="$(yq --arg image "$image" -r '.annotations["artifacthub.io/images"] | split("\n")[] | select(contains($image))' "$chart/Chart.yaml" |
    awk '{print $NF}' |
    jq -r -c -Rn '[inputs] | map({fullyQualifiedName: .})')"
  trivy image "$image" -f sarif --quiet --ignore-unfixed | jq -r --argjson locations "$locationsJson" '.runs |= map(.results |= map(.locations |= ([$locations[], .[]])))' >"$outFile"
}
export -f generateSarifReport

trivy image --download-db-only

if [[ "$#" == 1 ]] && [[ -d "$1" ]]; then
  createSarifReports "$1"
else
  result=0
  for chart in charts/*; do
    [[ "$chart" == "charts/*" ]] && continue

    if ! createSarifReports "$chart"; then
      result=1
    fi
  done
  exit "$result"
fi
