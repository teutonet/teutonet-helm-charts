#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

function createSarifReports() {
  local chart="${1?}"
  local chartName
  chartName="$(basename "$chart")"
  mkdir -p reports

  if yq -e '.type == "library"' "$chart/Chart.yaml" >/dev/null; then
    echo "Skipping library chart '$chart'" >&2
    return 0
  fi

  yq -r '.annotations["artifacthub.io/images"]' "$chart/Chart.yaml" |
    yq -r '.[] | .image' |
    parallel --retries 3 -P 0 -k generateSarifReport "$chart" "{}" "reports/$chartName-{#}.json"
  # shellcheck disable=SC1009
  cat "reports/$chartName-"*.json | jq -r -s '{"$schema": .[0]["$schema"], version: .[0].version, runs: [reduce map(.runs[])[] as $run (null; .+$run as $new | .tool.driver.rules |= (.+$run.tool.driver.rules | unique_by(.id)) | $new*. | .results += ($run.results | map(.locations += [{physicalLocation: {artifactLocation: {uri: $run.properties.imageName}}}])) | del(.properties))]}' >"reports/$chartName.json.sarif"
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
  if trivy image "$image" -f sarif --quiet --ignore-unfixed | jq -r --argjson locations "$locationsJson" --arg category "${GITHUB_JOB:-local}/$chart" '.runs |= map(.results |= map(.locations += [{logicalLocations: $locations}])) | .runs |= map(.automationDetails = {id: $category})' >"$tmpFile"; then
    mv "${tmpFile}" "${outFile}"
  else
    rm "$tmpFile"
    return 1
  fi
}
export -f generateSarifReport

trivy image --download-db-only

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
