#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

function checkLicenses() {
  local chart="${1?}"

  # shellcheck disable=SC2016
  if missingImages="$(yq -r -e -c --argjson usedImages "$(yq -r '.annotations["artifacthub.io/images"]' "${chart?}/Chart.yaml" | yq -r -c 'map(.image | split(":")[0]) | unique')" '$usedImages - (.licenses | keys) | if length == 0 then false else . end' .github/image_licenses.yaml)"; then
    echo "The following images of '$(basename "$chart")' have no license, please review:"
    echo "$missingImages" | yq -r 'map("  - " + .)[]'
    exit 1
  fi
}

if [[ "$#" == 1 && -d "$1" ]]; then
  checkLicenses "$1"
else
  result=0
  for chart in charts/*; do
    [[ -d "$chart" ]] || continue

    if ! checkLicenses "$chart"; then
      result=1
    fi
  done
  exit "$result"
fi
