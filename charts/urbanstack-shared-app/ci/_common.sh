#!/usr/bin/env bash

set -ex

jq -n '{
  image: {
    repository: "ol-teuto/external-citytool-container",
    digest: "sha256:fe40cf592b6460c7892846df4e6989cd7dc0106830e1467bce458940d2403275",
    registry: "ghcr.io"
  },
  host: "test.local",
  postgres: {
    host: "my-postgres-host-rw",
    secret: "my-database-secret",
    database: "my-database-name",
    networkPolicy: {
      matchLabels: {
        "cnpg.io/cluster": "my-postgres-host"
      }
    }
  },
  keycloakIssuer: "https://login.local/realms/test",
  keycloakClientId: "my_client",
  
  tenant: "my-tenant",
  citytool: "some-citytool",
  contact: "test@test.test"
}'
