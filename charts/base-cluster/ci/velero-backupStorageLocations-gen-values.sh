#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

i=0
url='url="https://github.com"'
provider="minio"
bucket='bucket="t8s"'
for prefix in 'prefix="/prod"' ''; do
  for existingSecret in 'existingSecret={name:"backup"}' 'existingSecret={name:"backup",key:"aws"}' ''; do
    for auth in 'accessKeyID="aki" | .secretAccessKey="sak"' ''; do
      [[ -n "$existingSecret" && -n "$auth" ]] && continue
      yq -y -n "{test$((i++)): ({} | .provider.$provider = ({} | .$url | .$auth | .$existingSecret) | .$prefix | .$bucket)}"
    done
  done
done | yq -s '{backup: { provider: { velero: { backupStorageLocations: .[], defaultLocation: "test0"}}}}'
