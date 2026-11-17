#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

# self-hosted runners don't get the tools installed by the workflows, so fail early and clearly
# if one is missing or the wrong flavour (e.g. go-yq instead of python-yq, moreutils' parallel)
result=0
for tool in "$@"; do
  if ! command -v "$tool" &>/dev/null; then
    echo "::error::$tool is missing on this runner"
    result=1
    continue
  fi
  case "$tool" in
  yq)
    if yq --version 2>&1 | grep -q mikefarah; then
      echo "::error::yq is mikefarah/yq, but the python-yq jq-wrapper is needed"
      result=1
    fi
    ;;
  parallel)
    if ! parallel --version 2>/dev/null | grep -q 'GNU parallel'; then
      echo "::error::parallel is not GNU parallel (moreutils' parallel shadows it?)"
      result=1
    fi
    ;;
  esac
done
exit "$result"
