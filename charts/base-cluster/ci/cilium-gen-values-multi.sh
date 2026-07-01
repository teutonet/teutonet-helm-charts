#!/usr/bin/env bash
set -eu
set -o pipefail

ci_dir="$(dirname "$0")"
cilium_overlay='{"global": {"networkPolicy": {"type": "cilium"}}}'

result='{}'
for source in "$ci_dir"/artifacthub-values*.yaml; do
  [[ -f "$source" ]] || continue
  name="$(basename "$source" .yaml)"
  name="${name//-values/}"
  merged=$(jq -s 'reduce .[] as $item ({}; . * $item)' \
    <(yq . "$source") \
    <(echo "$cilium_overlay"))
  result=$(jq --arg k "cilium-${name}" --argjson v "$merged" '. + {($k): $v}' <<<"$result")
done
echo "$result"
