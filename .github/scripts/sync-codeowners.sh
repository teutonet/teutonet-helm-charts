#!/usr/bin/env bash

[[ "$RUNNER_DEBUG" == 1 ]] && set -x

echo "* @teutonet/k8s"

for DIR in ./charts/*; do
  [[ "$DIR" = "./charts/*" ]] && continue
  FILE="$DIR/Chart.yaml"
  DIR="${DIR//\./}"
  MAINTAINERS="$(yq e '.maintainers.[].name' "$FILE" | sed 's/^/@/' | sort --ignore-case | tr '\r\n' ' ')"
  echo -e "$DIR/ $MAINTAINERS @teutonet-bot"
done | sort
