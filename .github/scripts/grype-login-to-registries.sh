#!/usr/bin/env bash

if ! (return 0 2>/dev/null); then
  echo This must be sourced, not executed. >&2
  exit 1
fi

declare -A IMAGE_PULL_TOKENS=(
  ["registry-gitlab.teuto.net"]="${TEUTO_PORTAL_WORKER_PULL_TOKEN?}"
  ["ghcr.io"]="${GHCR_PULL_TOKEN}"
)

if command -v grype &>/dev/null; then
  grype db update -q
fi

echo -n '{}' >"$DOCKER_CONFIG/config.json"
for registry in "${!IMAGE_PULL_TOKENS[@]}"; do
  jq --arg username github-cve-scanning --rawfile password <(echo -n "${IMAGE_PULL_TOKENS["$registry"]}") --arg registry "$registry" '. |= . * {auths: {$registry: {username: $username, password: $password}}}' "$DOCKER_CONFIG/config.json" | sponge "$DOCKER_CONFIG/config.json"
done
