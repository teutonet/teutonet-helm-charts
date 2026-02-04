# Changelog

## [3.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v3.0.0...teuto-cnpg-v3.1.0) (2026-02-04)


### Features

* **teuto-cnpg:** add postgres extensions to database spec ([#1768](https://github.com/teutonet/teutonet-helm-charts/issues/1768)) ([64c6e2f](https://github.com/teutonet/teutonet-helm-charts/commit/64c6e2f6e7d51a88c4f371b8291f607d69609abf))


### Miscellaneous Chores

* **teuto-cnpg/dependencies:** pin ghcr.io/cloudnative-pg/postgresql docker tag to 6e0bdf6 ([#1368](https://github.com/teutonet/teutonet-helm-charts/issues/1368)) ([67362ac](https://github.com/teutonet/teutonet-helm-charts/commit/67362ac8b22c0064435efd46c3f8c82d34eca473))

## [3.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v2.1.0...teuto-cnpg-v3.0.0) (2025-09-10)


### ⚠ BREAKING CHANGES

* **teuto-cnpg:** remodel to make use of the new way of creating barman backups ([#1663](https://github.com/teutonet/teutonet-helm-charts/issues/1663))

### Features

* **teuto-cnpg:** remodel to make use of the new way of creating barman backups ([#1663](https://github.com/teutonet/teutonet-helm-charts/issues/1663)) ([6c56e63](https://github.com/teutonet/teutonet-helm-charts/commit/6c56e635f67002250423794730b7f0495d6df5ff))


### Bug Fixes

* **teuto-cnpg/updateMethod:** set update method to switchover, set env-vars to make it compatible with newer barman ([#1572](https://github.com/teutonet/teutonet-helm-charts/issues/1572)) ([3082967](https://github.com/teutonet/teutonet-helm-charts/commit/30829679527a6c291fc30af1bcd0f9c91cee2657))

## [2.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v2.0.0...teuto-cnpg-v2.1.0) (2025-07-29)


### Features

* **teuto-cnpg/credentials:** allow adding roles during upgrades ([#1626](https://github.com/teutonet/teutonet-helm-charts/issues/1626)) ([441db93](https://github.com/teutonet/teutonet-helm-charts/commit/441db936e5c11ae3231331888b5894c9ec433d4b))

## [2.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v1.4.1...teuto-cnpg-v2.0.0) (2025-04-16)


### ⚠ BREAKING CHANGES

* **teuto-cnpg:** hash names of databases, to avoid collisions and a… ([#1441](https://github.com/teutonet/teutonet-helm-charts/issues/1441))

### Features

* **teuto-cnpg:** hash names of databases, to avoid collisions and a… ([#1441](https://github.com/teutonet/teutonet-helm-charts/issues/1441)) ([887992a](https://github.com/teutonet/teutonet-helm-charts/commit/887992acdcb704a17613d4f01721c37e76adb9c3))


### Bug Fixes

* **teuto-cnpg:** add values templating to README ([#1442](https://github.com/teutonet/teutonet-helm-charts/issues/1442)) ([c089439](https://github.com/teutonet/teutonet-helm-charts/commit/c0894392d735c5b101d559ce59e6d1aab42b9d2a))

## [1.4.1](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v1.4.0...teuto-cnpg-v1.4.1) (2025-04-14)


### Bug Fixes

* **teuto-cnpg:** replace `_` in database name with `-` ([#1437](https://github.com/teutonet/teutonet-helm-charts/issues/1437)) ([8c4b4bb](https://github.com/teutonet/teutonet-helm-charts/commit/8c4b4bba87322c2e5f2aeefd29ab868eabce793a))

## [1.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v1.3.0...teuto-cnpg-v1.4.0) (2025-02-24)


### Features

* **teuto-cnpg/backup:** add backup schedule ([#1354](https://github.com/teutonet/teutonet-helm-charts/issues/1354)) ([6967ce3](https://github.com/teutonet/teutonet-helm-charts/commit/6967ce3982ce62b716f6b25435f753d269fc4c1f))

## [1.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v1.2.0...teuto-cnpg-v1.3.0) (2025-02-24)


### Features

* **teuto-cnpg/backup:** add backup configuration ([#1352](https://github.com/teutonet/teutonet-helm-charts/issues/1352)) ([ec87e85](https://github.com/teutonet/teutonet-helm-charts/commit/ec87e8516c9cb8505fc7eaecdd49ac4a0fd78d3d))

## [1.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v1.1.0...teuto-cnpg-v1.2.0) (2025-02-07)


### Features

* **teuto-cnpg:** allow existing secrets to be used and skip generati… ([#1335](https://github.com/teutonet/teutonet-helm-charts/issues/1335)) ([7a6c7e1](https://github.com/teutonet/teutonet-helm-charts/commit/7a6c7e1928ec0b334c4cfd222383e22448404392))

## [1.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/teuto-cnpg-v1.0.0...teuto-cnpg-v1.1.0) (2025-02-05)


### Features

* **teuto-cnpg:** add credential management ([#1328](https://github.com/teutonet/teutonet-helm-charts/issues/1328)) ([ecb8d02](https://github.com/teutonet/teutonet-helm-charts/commit/ecb8d02f11eb2660743f34781bbd2b045048d9aa))

## 1.0.0 (2025-01-30)


### Features

* **teuto-cnpg:** add cnpg-wrapper skel ([#1310](https://github.com/teutonet/teutonet-helm-charts/issues/1310)) ([7a9249f](https://github.com/teutonet/teutonet-helm-charts/commit/7a9249fb728214d3b5c644da5f1acffe29fbb64d))
