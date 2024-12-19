#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

source "$(dirname "$0")/trivy-login-to-registries.sh"

function createSarifReports() {
  local chart="${1?}"
  local chartName
  chartName="$(basename "$chart")"
  mkdir -p reports

  # shellcheck disable=SC2046
  yq -r '.annotations["artifacthub.io/images"]' "$chart/Chart.yaml" |
    yq -r '.[] | .image' |
    parallel ${GITHUB_JOB+--bar} --retries 10 -P 0 -k generateSarifReport "$chart" "{}" "reports/$chartName-{#}.json"
  # shellcheck disable=SC1009
  cat "reports/$chartName-"*.json | jq -r -s '. as $input | {"$schema": .[0]["$schema"], version: .[0].version, runs: [reduce map(.runs[])[] as $run (null; .+$run as $new | .tool.driver.rules |= (.+$run.tool.driver.rules|unique_by(.id)) | $new*. | del(.properties, .originalUriBaseIds, .results))]} | .runs[0].results = ($input | reduce map(.runs[])[] as $run ([]; . += ($run.results | map(.locations |= (([.[] | select(.physicalLocation)][0].physicalLocation.artifactLocation) as $physicalLocation | .[] | select(.logicalLocations)[] | map({physicalLocation:{artifactLocation:{uri:"\(.fullyQualifiedName)/\($run.properties.imageName)/\($run.originalUriBaseIds[$physicalLocation.uriBaseId].uri)\($physicalLocation.uri)"}}}))))))' >"reports/$chartName.json.sarif"
}

function generateSarifReport() {
  set -e
  set -o pipefail
  [[ "$RUNNER_DEBUG" == 1 ]] && set -x
  local chart="${1?}"
  local image="${2?}"
  local outFile="${3?}"
  local tmpFile
  tmpFile="$(mktemp)"
  local locationsJson
  # shellcheck disable=SC2016
  locationsJson="$(yq --arg image "$image" -r '.annotations["artifacthub.io/images"] | split("\n")[] | select(contains($image))' "$chart/Chart.yaml" |
    awk '{print $NF}' |
    jq -r -c -Rn '[inputs] | map({fullyQualifiedName: .})')"
  if trivy image "$image" -f sarif --quiet --ignore-unfixed | jq -r --argjson locations "$locationsJson" --arg category "$chart/${GITHUB_JOB:-local}" '.runs |= map(.results |= map(.locations += [{logicalLocations: $locations}])) | .runs |= map(.automationDetails = {id: $category})' >"$tmpFile"; then
    mv "${tmpFile}" "${outFile}"
  else
    rm "$tmpFile"
    return 1
  fi
}
export -f generateSarifReport

if [[ "$#" == 1 && -d "$1" ]]; then
  createSarifReports "$1"
else
  result=0
  for chart in charts/*; do
    [[ -d "$chart" ]] || continue

    if ! createSarifReports "$chart"; then
      result=1
    fi
  done
  exit "$result"
fi
