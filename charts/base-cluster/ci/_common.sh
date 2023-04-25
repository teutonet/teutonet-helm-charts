#!/usr/bin/env bash

set -ex

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
