#!/usr/bin/env bash

set -exu
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

if [[ "$PR_TITLE" != *"($changed):"* ]]; then
  echo "PR title must start with '\$type($changed):'." >&2
  exit 1
fi
