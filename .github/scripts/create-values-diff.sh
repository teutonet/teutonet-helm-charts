#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

issue=${1?You need to provide the issue ID}
chart=${2?You need to provide the chart name}
if [[ -v 3 ]]; then
  case "$3" in
    --dry-run)
      dryRun=true
      ;;
    *)
      echo "Option '$3' not supported" >/dev/stderr
      exit 1
      ;;
  esac
else
  dryRun=false
fi

if yq -e '.type == "library"' "$chart/Chart.yaml" >/dev/null; then
  echo "Skipping library chart '$chart'" >/dev/stderr
  exit 0
fi

GITHUB_API_URL="${GITHUB_API_URL:-https://api.github.com}"

if command -v gh &>/dev/null; then
  if ! [[ -v GITHUB_TOKEN ]]; then
    GITHUB_TOKEN=$(gh auth token)
  else
    GITHUB_TOKEN="${GITHUB_TOKEN?Please export 'GITHUB_TOKEN'}"
  fi
  if ! [[ -v GITHUB_REPOSITORY ]]; then
    GITHUB_REPOSITORY=$(gh repo view --json nameWithOwner -q .nameWithOwner)
  fi
fi
GITHUB_API_REPO_URL="${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}"
GITHUB_WORKSPACE="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
GITHUB_DEFAULT_BRANCH="${GITHUB_DEFAULT_BRANCH:-main}"
GITHUB_SERVER_URL="${GITHUB_SERVER_URL:-https://github.com}"
GITHUB_REPO_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"

[[ ! -v TMP_DIR ]] && trap 'rm -rf "$TMP_DIR"' EXIT
TMP_DIR="${TMP_DIR:-$(mktemp -d)}"

cd "$GITHUB_WORKSPACE"

function generateComment() {
  local chart="${1?}"
  local -A diffs
  local newResourcesDir
  local originalResourcesDir

  for values in "$chart/values.yaml" "$chart/ci/"*-values.yaml; do
    [[ -f "$values" ]] || continue
    (
      originalResourcesDir="$TMP_DIR/original-$(basename -s .yaml "$values")"
      newResourcesDir="$TMP_DIR/new-$(basename -s .yaml "$values")"

      mkdir "$originalResourcesDir" "$newResourcesDir"

      (
        "$(dirname "$0")/templateGitHelmChart" -1 "$GITHUB_REPO_URL" "$chart" "${GITHUB_DEFAULT_BRANCH}" "$values" | yq -y -S >"$originalResourcesDir.yaml"
        "$(dirname "$0")/splitYamlIntoDir" "$originalResourcesDir.yaml" "$originalResourcesDir"
      ) &

      (
        "$(dirname "$0")/templateLocalHelmChart" -1 "$chart" "$values" | yq -y -S >"$newResourcesDir.yaml"
        "$(dirname "$0")/splitYamlIntoDir" "$newResourcesDir.yaml" "$newResourcesDir"
      ) &

      wait
    ) &
  done
  wait
  for values in "$chart/values.yaml" "$chart/ci/"*-values.yaml; do
    [[ -f "$values" ]] || continue
    originalResourcesDir="$TMP_DIR/original-$(basename -s .yaml "$values")"
    newResourcesDir="$TMP_DIR/new-$(basename -s .yaml "$values")"

    diffs+=(
      [$values]="$(diff --unidirectional-new-file -ur "$originalResourcesDir" "$newResourcesDir" | curl -s -F syntax=diff -F "content=<-" https://dpaste.com/api/v2/)"
    )
    sleep 2
  done

  echo :robot: I have diffed this *beep* *boop*
  echo ---
  # shellcheck disable=SC2016
  echo '"/$namespace/$kind/$name.yaml" for normal resources'
  # shellcheck disable=SC2016
  echo '"/$namespace/HelmRelease/$name/$namespace/$kind/$name.yaml" for HelmReleases <- this is recursive'
  echo "'null' means it's either cluster-scoped or it's in the default namespace for the HelmRelease"
  echo ---
  echo
  for values in "${!diffs[@]}"; do
    if [[ "${diffs[$values]}" = *'This field is required.'* ]]; then
      echo "$values has no changes"
    else
      echo "[$values](${diffs[$values]})"
    fi
    echo
  done
}

function createComment() {
  local issue="$1"
  local body="$2"

  jq -cn --rawfile body <(echo "$body") '{body: $body}' |
    curl --silent --fail-with-body \
      -X POST \
      -H 'Accept: application/vnd.github+json' \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      "${GITHUB_API_REPO_URL}/issues/${issue}/comments" \
      -d @-
}

function updateComment() {
  local issue="$1"
  local commentId="$2"
  local body="$3"

  jq -cn --rawfile body <(echo "$body") '{body: $body}' |
    curl --silent --fail-with-body \
      -X PATCH \
      -H 'Accept: application/vnd.github+json' \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      "${GITHUB_API_REPO_URL}/issues/comments/${commentId}" \
      -d @-
}

body=$(generateComment "$chart")

if [[ "$dryRun" == false ]]; then
  existingCommentId="$(
    curl --silent --fail-with-body \
      -H 'Accept: application/vnd.github+json' \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      "${GITHUB_API_REPO_URL}/issues/${issue}/comments" |
      jq -er 'map(select(.body | contains(":robot: I have diffed this *beep* *boop*")))[0].id'
  )"
  if [[ "$existingCommentId" != null ]]; then
    updateComment "$issue" "$existingCommentId" "$body"
  else
    createComment "$issue" "$body"
  fi
else
  echo "$body"
fi
