# Changelog

## [1.5.0](https://github.com/teutonet/teutonet-helm-charts/compare/common-v1.4.0...common-v1.5.0) (2025-06-06)


### Features

* **common/telemetry:** add telemetry-collector as a generic service name ([#1432](https://github.com/teutonet/teutonet-helm-charts/issues/1432)) ([fdf3b21](https://github.com/teutonet/teutonet-helm-charts/commit/fdf3b21e793a8e3a37e132f9a1472ccb643a2d14))
* **common:** add kube-apiserver networkpolicy helper ([#1413](https://github.com/teutonet/teutonet-helm-charts/issues/1413)) ([58ed072](https://github.com/teutonet/teutonet-helm-charts/commit/58ed0726018962632766d467bdb90e4f4e6b55a5))


### Miscellaneous Chores

* **common/dependencies:** update helm release common to v2.27.0 ([#1389](https://github.com/teutonet/teutonet-helm-charts/issues/1389)) ([9e7587f](https://github.com/teutonet/teutonet-helm-charts/commit/9e7587f70bf05eced1d2cb0e5ac95ccc40dfd00a))
* **common:** add documentation about template usage ([#1426](https://github.com/teutonet/teutonet-helm-charts/issues/1426)) ([638add8](https://github.com/teutonet/teutonet-helm-charts/commit/638add81729bd169b3a35edfee1c68c6011c2be8))

## [1.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/common-v1.3.0...common-v1.4.0) (2025-02-26)


### Features

* **common/images:** add template for pullPolicy ([#1381](https://github.com/teutonet/teutonet-helm-charts/issues/1381)) ([fac4246](https://github.com/teutonet/teutonet-helm-charts/commit/fac4246811afcf2afefab03bc9224a0a717ad75e))

## [1.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/common-v1.2.1...common-v1.3.0) (2025-02-25)


### Features

* **common/telemetry:** abstract telemetry config to allow typed usage ([#1346](https://github.com/teutonet/teutonet-helm-charts/issues/1346)) ([5e5742f](https://github.com/teutonet/teutonet-helm-charts/commit/5e5742f1991583e23229dcfdb163786122c4df31))


### Miscellaneous Chores

* **common/dependencies:** update helm release common to v2.22.0 ([#1143](https://github.com/teutonet/teutonet-helm-charts/issues/1143)) ([3e83b9d](https://github.com/teutonet/teutonet-helm-charts/commit/3e83b9d2c7e9b38c05fe6fc33ffdf00800839087))
* **common/dependencies:** update helm release common to v2.26.0 ([#1194](https://github.com/teutonet/teutonet-helm-charts/issues/1194)) ([ca037e5](https://github.com/teutonet/teutonet-helm-charts/commit/ca037e51815aee4f9f728becdb930a410331f76d))
* **common/docs:** set vim modeline ([#1273](https://github.com/teutonet/teutonet-helm-charts/issues/1273)) ([322db3f](https://github.com/teutonet/teutonet-helm-charts/commit/322db3f7e5a34ec69f5e749888e46905a16b7339))
* **common:** formatting ([#1199](https://github.com/teutonet/teutonet-helm-charts/issues/1199)) ([99c18a3](https://github.com/teutonet/teutonet-helm-charts/commit/99c18a39c029484340a6240f4fa26db5c3feb18e))

## [1.2.1](https://github.com/teutonet/teutonet-helm-charts/compare/common-v1.2.0...common-v1.2.1) (2024-08-07)


### Miscellaneous Chores

* **common/dependencies:** update helm release common to v2.19.3 ([#973](https://github.com/teutonet/teutonet-helm-charts/issues/973)) ([0187a4a](https://github.com/teutonet/teutonet-helm-charts/commit/0187a4aff3330b08f43ff6271d674e091f90df27))
* **common/dependencies:** update helm release common to v2.21.0 ([#1017](https://github.com/teutonet/teutonet-helm-charts/issues/1017)) ([edfeb09](https://github.com/teutonet/teutonet-helm-charts/commit/edfeb09ebe30659b97329d46fb554c883a220ac0))
* **common:** improve developer experience by providing tab-completion ([#1004](https://github.com/teutonet/teutonet-helm-charts/issues/1004)) ([4785b0f](https://github.com/teutonet/teutonet-helm-charts/commit/4785b0f4c1a48a7f15ec8d4f5b62282811e14429))

## [1.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/common-v1.1.0...common-v1.2.0) (2024-07-01)


### Features

* **common/helm:** add support for git helmRepositories ([#945](https://github.com/teutonet/teutonet-helm-charts/issues/945)) ([ea0d644](https://github.com/teutonet/teutonet-helm-charts/commit/ea0d644239233665da4e91eea61811d12d511360))


### Bug Fixes

* **common/telemetry:** checking of endpoint add missing `http://` if necessary ([#956](https://github.com/teutonet/teutonet-helm-charts/issues/956)) ([03c1fba](https://github.com/teutonet/teutonet-helm-charts/commit/03c1fba9b026c26adc698caa8521c85a4384bd5b))


### Miscellaneous Chores

* **common/dependencies:** update helm release common to v2.19.2 ([#918](https://github.com/teutonet/teutonet-helm-charts/issues/918)) ([6687537](https://github.com/teutonet/teutonet-helm-charts/commit/668753765205113f771bda02fa6996de04be6cd7))
* **common:** mustMerge* is the safer option ([#1002](https://github.com/teutonet/teutonet-helm-charts/issues/1002)) ([4299e1d](https://github.com/teutonet/teutonet-helm-charts/commit/4299e1dfd1bdf4154ca94368986518f4e1689a35))

## [1.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/common-v1.0.0...common-v1.1.0) (2024-04-18)


### Features

* **common:** add telemetry auto-detection template ([#869](https://github.com/teutonet/teutonet-helm-charts/issues/869)) ([c7c82e6](https://github.com/teutonet/teutonet-helm-charts/commit/c7c82e625871cfab3fa680371766a676877dee55))
* **common:** add telemetry auto-detection template ([#869](https://github.com/teutonet/teutonet-helm-charts/issues/869)) ([#874](https://github.com/teutonet/teutonet-helm-charts/issues/874)) ([77f367a](https://github.com/teutonet/teutonet-helm-charts/commit/77f367a4c492a4e5f7c39d46e3c73042b7fc9e35))

## 1.0.0 (2024-04-12)


### Features

* **common:** initial implementation ([#854](https://github.com/teutonet/teutonet-helm-charts/issues/854)) ([d7fe1c0](https://github.com/teutonet/teutonet-helm-charts/commit/d7fe1c0f345d6c0317005e9fc8ab7ba7a8a38aab))


### Miscellaneous Chores

* **common/dependencies:** update helm release common to v2.19.1 ([#860](https://github.com/teutonet/teutonet-helm-charts/issues/860)) ([06bb273](https://github.com/teutonet/teutonet-helm-charts/commit/06bb27390bde7e4c245180d94bdf67d2392d8ada))
