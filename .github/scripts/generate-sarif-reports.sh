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
    parallel ${GITHUB_JOB+--bar} --retries 10 -P 4 -k generateSarifReport "$chart" "{}" "reports/$chartName-{#}.json"

  # return with 1 (false) if a file has been found
  if find reports -type f -name "$chartName-*" -exec false {} + -quit; then
    # this allows for charts like teuto-cnpg which don't contain any images
    echo "No images found for $chartName" >&2
    return 0
  fi

  # shellcheck disable=SC1009
  cat "reports/$chartName-"*.json | jq -r -s -f .github/scripts/sarif-report-collect-results.jq >"reports/$chartName.json.sarif"
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
  if trivy image --skip-db-update --skip-java-db-update "$image" -f sarif --quiet --ignore-unfixed | jq -r --argjson locations "$locationsJson" --arg category "$chart/${GITHUB_JOB:-local}" '.runs |= map(.results |= map(.locations += [{logicalLocations: $locations}])) | .runs |= map(.automationDetails = {id: $category})' >"$tmpFile"; then
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
