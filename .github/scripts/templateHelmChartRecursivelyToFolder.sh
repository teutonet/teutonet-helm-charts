#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

chart=${1?You need to provide the chart name}
targetDir=${2?You need to provide the target directory}

if yq -e '.type == "library"' "$chart/Chart.yaml" >/dev/null; then
  echo "Skipping library chart '$chart'" >&2
  [[ -v GITHUB_OUTPUT ]] && [[ -f "$GITHUB_OUTPUT" ]] && echo "skipped=true" | tee -a "$GITHUB_OUTPUT"
  exit 0
else
  [[ -v GITHUB_OUTPUT ]] && [[ -f "$GITHUB_OUTPUT" ]] && echo "skipped=false" | tee -a "$GITHUB_OUTPUT"
fi

[[ ! -d "$targetDir" ]] && mkdir -p "$targetDir"

for values in "$chart/values.yaml" "$chart/ci/"*-values.yaml; do
  [[ -f "$values" ]] || continue
  (
    newResourcesDir="$targetDir/$(basename -s .yaml "$values")"

    mkdir "$newResourcesDir"

    "$(dirname "$0")/templateLocalHelmChart" -1 "$chart" "$values" | yq -y -S >"$newResourcesDir.yaml"
    "$(dirname "$0")/splitYamlIntoDir" "$newResourcesDir.yaml" "$newResourcesDir"
  ) &
done
trap 'EC=$?; kill $(jobs -p -r); exit $EC' INT
wait
