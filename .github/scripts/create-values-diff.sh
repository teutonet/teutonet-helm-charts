#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

issue=${1?You need to provide the issue ID}
chart=${2?You need to provide the chart name}
GITHUB_API_URL="${GITHUB_API_URL:-https://api.github.com}"
if command -v gh &> /dev/null; then
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
SCRIPTS="$GITHUB_WORKSPACE/.github/scripts/"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

cd "$GITHUB_WORKSPACE"

function splitYamlIntoDir() {
  local yaml="${1?}"
  local dir="${2?}"
  local IFS=$'\n'
  local selector

  for selector in $(yq -c -s '.[] | {kind: .kind, namespace: .metadata.namespace, name: .metadata.name}' <"$yaml"); do
    local resourceName
    local kind
    local namespace
    local name
    kind="$(jq --argjson selector "$selector" -n -r '$selector.kind')"
    namespace="$(jq --argjson selector "$selector" -n -r '$selector.namespace')"
    name="$(jq --argjson selector "$selector" -n -r '$selector.name')"

    resourceName="$dir/$namespace/$kind/$name.yaml"
    if [[ -f "$resourceName" ]]; then
      echo "'$resourceName' shouldn't already exist" >/dev/stderr
      return 1
    fi
    mkdir -p "$(dirname "$resourceName")"
    # shellcheck disable=SC2016
    yq -y -s --argjson selector "$selector" '.[] | select((.kind == $selector.kind) and (.metadata.namespace == $selector.namespace) and (.metadata.name == $selector.name))' <"$yaml" >"$resourceName"
    if [[ "$kind" == "HelmRelease" ]]; then
      "$SCRIPTS/templateHelmRelease" -1 <<<"$(sed -s '$a---' <(yq -s -y '.[] | select(.apiVersion | contains("source.toolkit.fluxcd.io"))' <"$yaml") "$resourceName")" >"${resourceName}_templated"
      splitYamlIntoDir "${resourceName}_templated" "$(dirname "$resourceName")/$(basename -s .yaml "$resourceName")"
      rm "${resourceName}_templated"
    fi
  done
}

function generateComment() {
  local chart="charts/${1?}"
  local -A diffs
  local newResourcesDir
  local originalResourcesDir

  for values in "$chart/values.yaml" "$chart/ci/"*-values.yaml; do
    [[ -f "$values" ]] || continue
    originalResourcesDir="$TMP_DIR/original-$(basename -s .yaml "$values")"
    newResourcesDir="$TMP_DIR/new-$(basename -s .yaml "$values")"

    mkdir "$originalResourcesDir" "$newResourcesDir"

    "$SCRIPTS/templateGitHelmChart" -1 "$GITHUB_REPO_URL" "$chart" "${GITHUB_DEFAULT_BRANCH}" "$values" | yq -y -S >"$originalResourcesDir.yaml"
    splitYamlIntoDir "$originalResourcesDir.yaml" "$originalResourcesDir"

    "$SCRIPTS/templateLocalHelmChart" -1 "$chart" "$values" | yq -y -S >"$newResourcesDir.yaml"
    splitYamlIntoDir "$newResourcesDir.yaml" "$newResourcesDir"


    diffs+=(
      [$values]="$(diff -ur "$originalResourcesDir" "$newResourcesDir")"
    )
    break
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

echo "$body"

exit 0
if [[ "$existingCommentId" == null ]]; then
  createComment "$issue" "$body"
else
  updateComment "$body" "$existingCommentId"
fi
