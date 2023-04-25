#!/usr/bin/env bash

set -ex

jq -n '{
  metadata: {
    customerID: 1000,
    customerName: "test"
  },
  cloud: "ffm3"
}'
