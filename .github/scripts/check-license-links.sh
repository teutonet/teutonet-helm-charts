#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

# Images whose license can't be linked to a real, public file (e.g. a private registry
# without a public license file). Skipped entirely, both link-shape and content checks.
IGNORED_IMAGES=(
  "registry-gitlab.teuto.net/4teuto/dev/teuto-portal/teuto-portal-k8s-worker/teuto-portal-k8s-worker"
)

# Images whose licenseLink is real but whose content can't be verified by licensee:
# - docker.io/bats/bats: LICENSE.md concatenates two MIT notices (its own + inherited from the
#   predecessor "bats" project), which defeats licensee's text matcher.
# - docker.io/busybox: no plain-text mirror of the license exists, only the official HTML page.
# - docker.io/curlimages/curl: curl's license text isn't in licensee's bundled SPDX corpus.
NOT_CONTENT_VERIFIABLE=(
  "docker.io/bats/bats"
  "docker.io/busybox"
  "docker.io/curlimages/curl"
)

# licensee's SPDX corpus doesn't carry the "-only"/"-or-later" GPL-family suffixes, and uses
# "-Clause" for BSD variants. Normalize both sides before comparing.
function normalizeLicense() {
  local license="${1?}"

  license="$(echo "$license" | tr '[:lower:]' '[:upper:]')"
  case "$license" in
    AGPL-3.0-ONLY | AGPL-3.0-OR-LATER) echo "AGPL-3.0" ;;
    GPL-2.0-ONLY | GPL-2.0-OR-LATER) echo "GPL-2.0" ;;
    GPL-3.0-ONLY | GPL-3.0-OR-LATER) echo "GPL-3.0" ;;
    LGPL-2.1-ONLY | LGPL-2.1-OR-LATER) echo "LGPL-2.1" ;;
    LGPL-3.0-ONLY | LGPL-3.0-OR-LATER) echo "LGPL-3.0" ;;
    BSD-2) echo "BSD-2-CLAUSE" ;;
    BSD-3) echo "BSD-3-CLAUSE" ;;
    *) echo "$license" ;;
  esac
}

function isInList() {
  local needle="${1?}"
  shift
  local hay

  for hay in "$@"; do
    [[ "$needle" == "$hay" ]] && return 0
  done
  return 1
}

# This runs on pull_request_target against a PR-controlled licenseLink value, and
# checkLicenseContent curls whatever host is given. Without an allowlist, a PR could point
# licenseLink at an internal address (loopback, cloud metadata, ...) and turn this into an
# SSRF probe from a privileged runner. Only fetch from hosts we've actually reviewed.
ALLOWED_HOSTS=(
  "raw.githubusercontent.com"
  "gitlab.teuto.net"
  "curl.se"
  "www.busybox.net"
)

function isRealLicenseLink() {
  local link="${1?}"
  local path host

  # Only https is ever legitimate here; other schemes (plain http, or curl's
  # other supported protocols) are either insecure or pointless against these hosts.
  [[ "$link" =~ ^https:// ]] || return 1

  host="$(echo "$link" | sed -E 's#^[a-z]+://([^/]+).*#\1#')"
  isInList "$host" "${ALLOWED_HOSTS[@]}" || return 1

  # A link to a GitHub/GitLab repo root isn't a license file, it must point into the repo.
  if [[ "$link" =~ ^https?://(github\.com|gitlab\.[^/]+)/[^/]+/[^/]+/?$ ]]; then
    return 1
  fi

  # Reject bare domain roots (e.g. a project homepage instead of its license page).
  path="$(echo "$link" | sed -E 's#^[a-z]+://[^/]+##')"
  [[ "$path" =~ ^/?$ ]] && return 1

  return 0
}

# Fetches a licenseLink into its own directory. Pure network I/O, and the only part of this
# script worth running concurrently, so it's split out to be driven by GNU parallel below
# instead of being called inline. Runs concurrently, so a failure is marked with a sentinel
# file rather than reported directly.
function fetchLicenseLink() {
  local link="${1?}"
  local dir="${2?}"

  if ! curl -s -f -L --proto '=https' --connect-timeout 10 --max-time 30 --retry 2 -o "$dir/LICENSE" "$link"; then
    touch "$dir/.failed"
  fi
}

# Runs licensee against every already-fetched license file in a single Ruby process. Spawning
# a Ruby interpreter (and reloading licensee's whole SPDX corpus) per image is the expensive
# part, not the actual license matching, so this batches all of them into one process instead
# of shelling out to the `licensee` CLI once per image.
function detectLicenses() {
  ruby -rlicensee -e '
    # Without this, licensee hides any match below its own default confidence
    # threshold behind a "other"/nil placeholder, losing the exact signal our
    # own >=90%-confident-mismatch-vs-warning logic below needs.
    Licensee.confidence_threshold = 0

    STDIN.each_line do |line|
      dir = line.chomp
      file = Licensee::Projects::FSProject.new(dir).matched_files.first
      if file&.license
        puts [dir, file.license.spdx_id, file.confidence].join("\t")
      else
        puts [dir, "NONE", 0].join("\t")
      end
    end
  '
}

result=0
tmpRoot="$(mktemp -d)"
trap 'rm -rf "$tmpRoot"' EXIT

declare -A declaredByImage=()
declare -A linkByImage=()
declare -A dirByImage=()
declare -A imageByDir=()
toFetch=()

while IFS=$'\t' read -r image declared link; do
  isInList "$image" "${IGNORED_IMAGES[@]}" && continue

  if ! isRealLicenseLink "$link"; then
    echo "licenseLink for '$image' is not a real license file: $link" >&2
    result=1
    continue
  fi

  isInList "$image" "${NOT_CONTENT_VERIFIABLE[@]}" && continue

  dir="$tmpRoot/$(echo -n "$image" | sha1sum | cut -d' ' -f1)"
  mkdir -p "$dir"
  declaredByImage["$image"]="$declared"
  linkByImage["$image"]="$link"
  dirByImage["$image"]="$dir"
  imageByDir["$dir"]="$image"
  toFetch+=("$link"$'\t'"$dir")
done < <(yq -r '.licenses | to_entries[] | [.key, .value.license, .value.licenseLink] | @tsv' .github/image_licenses.yaml)

if [[ "${#toFetch[@]}" -gt 0 ]]; then
  export -f fetchLicenseLink
  # shellcheck disable=SC2046
  printf '%s\n' "${toFetch[@]}" |
    parallel $([[ -v GITHUB_JOB ]] || printf -- --bar) -P 0 --colsep '\t' fetchLicenseLink "{1}" "{2}"
fi

toDetect=()
for image in "${!dirByImage[@]}"; do
  dir="${dirByImage[$image]}"
  if [[ -e "$dir/.failed" ]]; then
    echo "could not fetch licenseLink for '$image': ${linkByImage[$image]}" >&2
    result=1
    continue
  fi
  toDetect+=("$dir")
done

if [[ "${#toDetect[@]}" -gt 0 ]]; then
  while IFS=$'\t' read -r dir detected confidence; do
    image="${imageByDir[$dir]}"
    declared="${declaredByImage[$image]}"
    link="${linkByImage[$image]}"

    if [[ "$detected" == "NONE" ]]; then
      echo "licenseLink for '$image' doesn't look like a license file at all: $link" >&2
      result=1
      continue
    fi

    declaredNorm="$(normalizeLicense "$declared")"
    detectedNorm="$(normalizeLicense "$detected")"

    [[ "$declaredNorm" == "$detectedNorm" ]] && continue

    if awk -v c="$confidence" 'BEGIN { exit !(c >= 90) }'; then
      echo "'$image' declares '$declared' but its licenseLink is confidently '$detected' (${confidence%.*}% confidence): $link" >&2
      result=1
    else
      echo "warning: '$image' declares '$declared', licensee's best (low-confidence, ${confidence%.*}%) guess is '$detected' — please double check: $link" >&2
    fi
  done < <(printf '%s\n' "${toDetect[@]}" | detectLicenses)
fi

exit "$result"
