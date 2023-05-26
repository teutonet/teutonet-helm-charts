#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

jq -n '{
  global: {
    clusterName: "test",
    serviceLevelAgreement: "None"
  },
  monitoring: {
    grafana: {
      adminPassword: "test"
    }
  }
}'
