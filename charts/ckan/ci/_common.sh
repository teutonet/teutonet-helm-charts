#!/usr/bin/env bash

set -ex

jq -n '{
  ckan: {
    ingress: {
      hostname: "ckan.test"
    }
  }
}'
