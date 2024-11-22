#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

WHITELIST=(
  "AGPL-3.0" # We're not writing software 🤷
  "AGPL-3.0-only"
  "AGPL-3.0-or-later"
  "CC-BY-SA-3.0"
  "CDDL-1.0"
  "CDDL-1.1"
  "EPL-1.0"
  "EPL-2.0"
  "CPL-1.0"
  "GPLv2"
  "GPL-1.0"
  "GPL-1.0-only"
  "GPL-1.0-or-later"
  "GPLv2"
  "GPLv2+"
  "GPLv2 with exceptions"
  "GPLv3+"
  "GPL-2.0"
  "GPL-2.0-only"
  "GPL-2.0-or-later"
  "GPL-2.0-with-autoconf-exception"
  "GPL-2.0-with-autoconf-exception+"
  "GPL-2.0-with-bison-exception"
  "GPL-2.0-with-bison-exception+"
  "GPL-2.0-with-classpath-exception"
  "GPL-3.0"
  "GPL-3.0-only"
  "GPL-3.0-or-later"
  "GPL-3.0-with-autoconf-exception+"
  "GPL-3.0-with-autoconf-exception"
  "LGPLv2"
  "LGPLv2+"
  "LGPL-2.0"
  "LGPL-2.0-only"
  "LGPL-2.0-or-later"
  "LGPL-2.1"
  "LGPL-2.1-only"
  "LGPL-2.1-or-later"
  "LGPLv3+"
  "LGPL-3.0"
  "LGPL-3.0-only"
  "LGPL-3.0-or-later"
  "MPL-1.1"
  "MPL-2.0"
  "MPLv2.0"
  "Ruby"
  "Sleepycat"
  "WTFPL"
)

# shellcheck disable=SC2016
licenseConversionJq='map({Image: (.Metadata.RepoTags // .Metadata.RepoDigests)[0], License: (.Results[] | .Licenses[]? | .Name)} as $licenseInfo | $licenseInfo+{PackageOrPath: (.Results[] | .Licenses[]? | select(.Name == $licenseInfo.License) | if .PkgName != "" then .PkgName else .FilePath end)}) | group_by(.License) | map({(.[0].License): (map(del(.License)) | group_by(.Image) | map({(.[0].Image): map(.PackageOrPath) | unique}) | add) }) | add'
function scanLicenses() {
  local chart="${1?}"
  local licenseMap
  local unacceptedLicenses=()
  local unacceptedLicense
  licenseMap="$(yq -r '.annotations["artifacthub.io/images"]' "$chart/Chart.yaml" | yq -r '.[] | .image' |
    sed -e '/aquasecurity\/trivy-operator/d' -e '/teuto-portal-k8s-worker/d' |
    parallel -k trivy image {} --severity HIGH,CRITICAL,MEDIUM -f json --scanners license --license-full --quiet |
    jq -s -r "$licenseConversionJq")"
  mapfile -t unacceptedLicenses < <(jq <<<"$licenseMap" -r --argjson acceptedLicenses "[\"$(echo -n "${WHITELIST[@]}" | tr " " \\n |
    paste -sd '@' | sed 's#@#","#g')\"]" '(keys-$acceptedLicenses)[]')
  if [[ "${#unacceptedLicenses[@]}" -gt 0 ]]; then
    echo "found ${#unacceptedLicenses[@]} untrusted images in '$chart', please fix;" >&2
    for unacceptedLicense in "${unacceptedLicenses[@]}"; do
      echo "license $unacceptedLicense has not been accepted and is used in the following images:" >&2
      for image in $(jq <<<"$licenseMap" -r --arg unacceptedLicense "$unacceptedLicense" '.[$unacceptedLicense] | keys[]'); do
        echo "  > $image:" >&2
        for packageOrFile in $(jq <<<"$licenseMap" -r --arg unacceptedLicense "$unacceptedLicense" --arg image "$image" '.[$unacceptedLicense][$image][]'); do
          echo "      - $packageOrFile" >&2
        done
      done
    done
    return 1
  fi
}

if [[ "$#" == 1 && -d "$1" ]]; then
  scanLicenses "$1"
else
  result=0
  for chart in charts/*; do
    [[ -d "$chart" ]] || continue

    if ! scanLicenses "$chart"; then
      result=1
    fi
  done
  exit "$result"
fi
