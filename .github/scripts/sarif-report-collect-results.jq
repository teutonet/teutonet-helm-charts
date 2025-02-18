. as $input | {
  "$schema": .[0]["$schema"],
  version: .[0].version,
  runs: [
    reduce map(.runs[])[] as $run (null;
      .+$run as $new |
        .tool.driver.rules |= (
          .+$run.tool.driver.rules | unique_by(.id)
        ) | $new*. | del(.properties, .originalUriBaseIds, .results)
    )
  ]
} | .runs[0].results = ($input | reduce map(.runs[])[] as $run ([];
  . += ($run.results |
    map(.locations |=
      (
        ([.[] | select(.physicalLocation)][0].physicalLocation.artifactLocation) as $physicalLocation | .[] | select(.logicalLocations)[] |
          map({
            physicalLocation: {
              artifactLocation: {
                uri: "\(.fullyQualifiedName)/\($run.properties.imageName)/\($run.originalUriBaseIds[$physicalLocation.uriBaseId].uri)\($physicalLocation.uri)"
              }
            }
          })
      )
    )
  )
) | unique)
