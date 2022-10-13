#!/usr/bin/env bash

echo "* @teutonet/k8s"

for DIR in ./charts/*; do
  [[ "$DIR" = "./charts/*" ]] && continue
  FILE="$DIR/Chart.yaml"
  DIR="${DIR//\./}"
  MAINTAINERS="$(yq e '.maintainers.[].name' "$FILE" | sed 's/^/@/' | sort --ignore-case | tr '\r\n' ' ')"
  echo -e "$DIR/ $MAINTAINERS"
done | sort

