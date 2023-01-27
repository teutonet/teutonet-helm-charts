#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

issue=${1?You need to provide the issue ID}
chart=${2?You need to provide the chart name}
GITHUB_API_REPO_URL="${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}"
GITHUB_TOKEN="${GITHUB_TOKEN?Please export 'GITHUB_TOKEN'}"
GITHUB_WORKSPACE="${GITHUB_WORKSPACE:-$(git rev-parse --show-toplevel)}"
GITHUB_DEFAULT_BRANCH="${GITHUB_DEFAULT_BRANCH:-main}"
GITHUB_SERVER_URL="${GITHUB_SERVER_URL?Please export 'GITHUB_SERVER_URL'}"
GITHUB_REPO_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"
SCRIPTS="$GITHUB_WORKSPACE/.github/scripts/"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cd "$GITHUB_WORKSPACE"

function generateComment() {
  local chart="charts/${1?}"
  local -A diffs
  #local newResourcesDir
  #local originalResourcesDir
  local newResourcesFilename
  local originalResourcesFilename

  for values in "$chart/values.yaml" "$chart/ci/"*-values.yaml; do
    [[ -f "$values" ]] || continue
    originalResourcesFilename="$TMP_DIR/original-${values//\//-}"
    newResourcesFilename="$TMP_DIR/new-${values//\//-}"

    "$SCRIPTS/templateGitHelmChart" "$GITHUB_REPO_URL" "$chart" "${GITHUB_DEFAULT_BRANCH}" "$values" | yq -y -S >"$originalResourcesFilename"
    "$SCRIPTS/templateLocalHelmChart" "$chart" "$values" | yq -y -S >"$newResourcesFilename"

    diffs+=(
      [$values]="$(diff -u "$originalResourcesFilename" "$newResourcesFilename")"
    )
  done

  echo :robot: I have diffed this *beep* *boop*
  echo ---
  echo
  for values in "${!diffs[@]}"; do
    echo '<details>'
    echo "<summary>$values</summary>"
    echo
    echo '```diff'
    echo "${diffs[$values]}"
    echo '```'
    echo
    echo '</details>'
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
  local body="$1"
  local existingCommentId="$2"

  jq -cn --rawfile body <(echo "$body" | tee /tmp/body) '{body: $body}' |
    curl --silent --fail-with-body \
      -X PATCH \
      -H 'Accept: application/vnd.github+json' \
      -H "Authorization: token ${GITHUB_TOKEN}" \
      "${GITHUB_API_REPO_URL}/issues/comments/${existingCommentId}" \
      -d @-
}

existingCommentId="$(
  curl --silent --fail-with-body \
    -H 'Accept: application/vnd.github+json' \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    "${GITHUB_API_REPO_URL}/issues/${issue}/comments" |
    jq '. | map(select(.body | contains(":robot: I have diffed this *beep* *boop*")))[0].id'
)"

body=$(generateComment "$chart")

if [[ "$existingCommentId" == null ]]; then
  createComment "$issue" "$body"
else
  updateComment "$body" "$existingCommentId"
fi
