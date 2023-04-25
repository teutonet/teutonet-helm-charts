#!/usr/bin/env bash

set -ex

jq -n '{
  api_gateway: {
    ingress: {
      enabled: false
    }
  }
}'
