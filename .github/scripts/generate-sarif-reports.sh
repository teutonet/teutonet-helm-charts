#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

export DOCKER_CONFIG="$(mktemp -d)"
trap "rm -rf $DOCKER_CONFIG" EXIT

source "$(dirname "$0")/grype-login-to-registries.sh"

function createSarifReports() {
  local chart="${1?}"
  local chartName
  chartName="$(basename "$chart")"
  mkdir -p reports

  # shellcheck disable=SC2046
  yq -r '.annotations["artifacthub.io/images"]' "$chart/Chart.yaml" |
    yq -r '.[] | .image' |
    parallel ${GITHUB_JOB+--bar} --retries 10 -P 0 -k generateSarifReport "$chart" "$chartName" "{}" "reports/$chartName-{#}.json"

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
  local chartName="${2?}"
  local image="${3?}"
  local outFile="${4?}"
  local tmpFile
  tmpFile="$(mktemp)"
  local chartsJson
  # shellcheck disable=SC2016
  chartsJson="$(yq --arg image "$image" -r '.annotations["artifacthub.io/images"] | split("\n")[] | select(contains($image))' "$chart/Chart.yaml" |
    awk '{print $NF}' |
    jq -r -c -Rn '[inputs]')"
  if GRYPE_DB_AUTO_UPDATE=false grype "$image" -o sarif --by-cve --only-fixed | jq -r --arg category "$chart/${GITHUB_JOB:-local}" --argjson subCharts "$chartsJson" --arg chart "$chartName" '.runs |= (map(.automationDetails = {id: $category}) | map(.properties = {chart: $chart, subCharts: $subCharts}))' >"$tmpFile"; then
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
