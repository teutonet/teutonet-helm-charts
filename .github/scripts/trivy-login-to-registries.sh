#!/usr/bin/env bash

if ! (return 0 2>/dev/null); then
  echo This must be sourced, not executed. >&2
  exit 1
fi

declare -A IMAGE_PULL_TOKENS=(
  ["registry-gitlab.teuto.net"]="${TEUTO_PORTAL_WORKER_PULL_TOKEN?}"
)

trivy image --download-db-only

for registry in "${!IMAGE_PULL_TOKENS[@]}"; do
  TRIVY_PASSWORD="${IMAGE_PULL_TOKENS["$registry"]}" trivy registry login --username github-cve-scanning "$registry"
done
