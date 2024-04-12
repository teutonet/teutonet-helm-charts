[
  .registries | paths(scalars) as $p | $p + [getpath($p)] |
    .[-1] as $type |
      if $type == "ALL_IMAGES" then
        "\(.[0:-1] | join("/"))/.*"
      elif $type == "ALL_TAGS" then
        "\(.[0:-1] | join("/")):.*"
      else
        "\(.[0:-1] | join("/")):\($type)"
      end |
      "^\(.)(\\s|$)"
] |
  join("|")
