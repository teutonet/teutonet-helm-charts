#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

set -eu
set -o pipefail

i=0
for url in 'url="https://github.com"' 'url="ssh://git@github.com/group/name.git"'; do
  for path in 'path="prod"' 'path="{{ .global.clusterName }}"' ''; do
    for extra in 'branch="main"' 'commit="549aee1"' 'semver="1.0.0"' 'tag="2.0.1"' ''; do
      for decr in 'decryption={provider:"sops"}' ''; do
        for auth in 'username="user" | .password="pass"' ''; do
          for git in 'gitInterval="5m"' ''; do
            [[ $url = *ssh* ]] && [[ -n "$auth" ]] && continue
            yq -y -n "{main$((i++)): ({} | .$url | .$path | .$extra | .$decr | .$auth | .$git)}"
          done
        done
      done
    done
  done
done | yq -s '{flux: {gitRepositories: .[]}}'
