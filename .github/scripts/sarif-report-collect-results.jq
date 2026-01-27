. as $input | {
  "$schema": .[0]["$schema"],
  version: .[0].version,
  runs: [
    reduce map(.runs[])[] as $run (null;
      .+$run as $new |
        .tool.driver.rules |= (
          .+($run.tool.driver.rules // []) | unique_by(.id)
        ) | $new*. | del(.properties, .originalUriBaseIds, .results)
    )
  ]
} | .runs[0].results = ($input | reduce map(.runs[])[] as $run ([];
  . += ($run.results |
    map(.locations |= (. as $locations | [
          $run.properties.subCharts[] as $subChart | $locations[] |
              . |= (
                (
                  .physicalLocation |= (
                    .artifactLocation |= (
                      .uri |= "file:///\($run.properties.chart):\($subChart):\(sub("^[^/]+/"; ""))"
                    )
                  )
                ) | (
                  .logicalLocations |= map(
                    .fullyQualifiedName |= "\($run.properties.chart):\($subChart):\(.)"
                  )
                )
              )
        ]
      ))
  )
) | unique)
