#!/usr/bin/env bash

set -ex

jq -n '{
  registry: {
    storage: {
      mode: "s3",
      s3: {
        authSecret: {
          accessKey: "test-access-key",
          secretKey: "test-secret-key"
        }
      }
    },
    upstream: {
      config: {
        contents: [
          {
            namespace: "docker.io",
            host: "registry-1.docker.io",
            tls: true
          }
        ]
      }
    },
    ingress: {
      enabled: true,
      hostname: "oci-registry.test"
    }
  }
}'
