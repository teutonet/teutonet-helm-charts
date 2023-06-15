#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

function getUntrustedImages() {
  local chart="${1?}"
  local trustedImagesRegex

  trustedImagesRegex="$(yq -r -f .github/scripts/trusted_images_regex.jq <.github/trusted_registries.yaml)"

  yq -r '.annotations["artifacthub.io/images"]' <"$chart/Chart.yaml" |
    yq -r '.[] | .image' |
    grep -v -E "$trustedImagesRegex"
}

function enforceTrustedImages() {
  local chart="${1?}"
  local untrustedImages=()

  mapfile -t untrustedImages < <(getUntrustedImages "$chart")
  if ((${#untrustedImages[@]} > 0)); then
    echo "found ${#untrustedImages[@]} untrusted images in '$chart', please fix;" >/dev/stderr
    for untrustedImage in "${untrustedImages[@]}"; do
      echo "    $untrustedImage" >/dev/stderr
    done
    return 1
  fi
}

if [[ "$#" == 1 ]] && [[ -d "$1" ]]; then
  enforceTrustedImages "$1"
else
  result=0
  for chart in charts/*; do
    [[ "$chart" == "charts/*" ]] && continue

    if ! enforceTrustedImages "$chart"; then
      result=1
    fi
  done
  exit "$result"
fi
