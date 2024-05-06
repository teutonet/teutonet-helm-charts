#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x
[[ -o xtrace ]] && export RUNNER_DEBUG=1

set -eu
set -o pipefail

: "${PR_TITLE:?Environment variable must be set}"

changed="${CHANGED_CHART?Environment variable must be set}"

if ! cog verify "$PR_TITLE"; then
	echo "PR title must be a conventional commit message" >&2
	exit 1
fi

if [[ -n "$changed" ]] && ! cog verify "$PR_TITLE" 2>&1 | grep -Eq "^\s+Scope: $changed(/.+|)\$"; then
	echo "PR title must have scope '$changed/\$subscope'" >&2
	exit 1
fi
