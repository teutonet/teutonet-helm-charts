#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

function createSarifReports() {
  local chart="${1?}"
  mkdir -p reports

  if yq -e '.type == "library"' "$chart/Chart.yaml" >/dev/null; then
    echo "Skipping library chart '$chart'" >&2
    return 0
  fi

  yq -r '.annotations["artifacthub.io/images"]' "$chart/Chart.yaml" |
    yq -r '.[] | .image' |
    parallel -P 0 -k generateSarifReport "$chart" "{}" "reports/$(basename "$chart")-{#}.sarif.json"
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
  trivy image "$image" -f sarif --quiet --ignore-unfixed | jq -r --argjson locations "$locationsJson" '.runs |= map(.results |= map(.locations |= ([{logicalLocations: $locations}, .[]])))' >"$outFile"
  # delete empty files, otherwise the check if they should be uploaded doesn't work correctly
  [[ -s "$outFile" ]] || rm -f "$outFile"
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
