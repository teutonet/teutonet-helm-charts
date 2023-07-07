#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

: "${PR_TITLE:?Environment variable must be set}"

changed=$(ct list-changed)

if [[ -z "$changed" ]]; then
  exit 0
fi

if [[ "$PR_TITLE" =~ chore(deps)* ]]; then
  exit 0
fi

num_changed=$(wc -l <<<"$changed")

if ((num_changed > 1)); then
  echo "This PR has changes to multiple charts. Please create individual PRs per chart." >&2
  exit 1
fi

# Strip charts directory
changed="${changed##*/}"

if ! cog verify "$PR_TITLE"; then
  echo "PR title must be a conventional commit message" >&2
  exit 1
fi

if ! cog verify "$PR_TITLE" 2>&1 | grep -Eq "^\s+Scope: $changed(/.+|)\$"; then
  echo "PR title must have scope '$changed/\$subscope'" >&2
  exit 1
fi

curl --silent --fail-with-body \
  -X POST \
  -H 'Accept: application/vnd.github+json' \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  "${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}/issues/${ISSUE_NUMBER}/labels" \
  -d '{"labels":["'"$changed"'"]}'
