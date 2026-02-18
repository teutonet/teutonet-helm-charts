<!-- vim: set ft=markdown: -->
# common

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

A library chart for common resources

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| tasches | <st@teuto.net> |  |

## Source Code

* <https://github.com/teutonet/teutonet-helm-charts/tree/common-v2.0.0/charts/common>
* <https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/common>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.36.0 |

## Migration

### 1.x.x -> 2.0.0

The template function `common.resources` changed its signature and it's default behaviour;

It now accepts an additional parameter `setCPULimits` which defaults to `false`.

So now by default CPU limits are omitted from the `resourcesPreset`, but are still always
set via `resources`.
