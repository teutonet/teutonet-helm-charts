#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

jq -n '{
  chirpstack: {
    apiSecret: "SUPERSECRETsupersecretSUPERSECRE"
  }
}'
