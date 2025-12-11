# Changelog

## [11.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v10.1.2...base-cluster-v11.0.0) (2025-12-10)


### ⚠ BREAKING CHANGES

* **base-cluster/monitoring:** grafana-tempo-distributed would need s3 ([#1875](https://github.com/teutonet/teutonet-helm-charts/issues/1875))

### Features

* **base-cluster/flux:** use centralised helmRepositories template ([#1845](https://github.com/teutonet/teutonet-helm-charts/issues/1845)) ([60658ed](https://github.com/teutonet/teutonet-helm-charts/commit/60658eda1067f2cb01894ade1bdbf948c333e94d))


### Bug Fixes

* **base-cluster/monitoring:** grafana-tempo-distributed would need s3 ([#1875](https://github.com/teutonet/teutonet-helm-charts/issues/1875)) ([df5c372](https://github.com/teutonet/teutonet-helm-charts/commit/df5c372b7349b248457cff8d37df7bc6887d31e4))
* **base-cluster/monitoring:** increase limit of grafana sidecar ([#1878](https://github.com/teutonet/teutonet-helm-charts/issues/1878)) ([fb1ebc6](https://github.com/teutonet/teutonet-helm-charts/commit/fb1ebc624ed56e4f8507df37f938766123636822))
* **base-cluster:** correctly set image repository ([#1848](https://github.com/teutonet/teutonet-helm-charts/issues/1848)) ([0e108dc](https://github.com/teutonet/teutonet-helm-charts/commit/0e108dc31016bb452813222273a0131f5f7a5469))


### Miscellaneous Chores

* **base-cluster/dependencies:** update common docker tag to v1.7.0 ([#1872](https://github.com/teutonet/teutonet-helm-charts/issues/1872)) ([b50ea98](https://github.com/teutonet/teutonet-helm-charts/commit/b50ea9817dd0b7ce86600199de98a2fdc46ca3a2))
* **base-cluster/dependencies:** update helm release reflector to v9.1.44 ([#1861](https://github.com/teutonet/teutonet-helm-charts/issues/1861)) ([2cfe4e5](https://github.com/teutonet/teutonet-helm-charts/commit/2cfe4e50c116d39a6388323efd8b17b2900f5650))

## [10.1.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v10.1.1...base-cluster-v10.1.2) (2025-12-05)


### Bug Fixes

* **base-cluster/monitoring:** move imageRenderer config to correct place ([#1860](https://github.com/teutonet/teutonet-helm-charts/issues/1860)) ([5e2e9f5](https://github.com/teutonet/teutonet-helm-charts/commit/5e2e9f5a79b9360d97e9fbc8c1ea5ba96e6e2683))
* **base-cluster:** set default value for kube-janitor to own repo ([#1857](https://github.com/teutonet/teutonet-helm-charts/issues/1857)) ([82b78e5](https://github.com/teutonet/teutonet-helm-charts/commit/82b78e50ca0c65915a5ec8c92270d531d0503552))


### Miscellaneous Chores

* **base-cluster/dependencies:** update docker.io/grafana/grafana-image-renderer docker tag to v5 ([#1822](https://github.com/teutonet/teutonet-helm-charts/issues/1822)) ([b9b16d7](https://github.com/teutonet/teutonet-helm-charts/commit/b9b16d7766cb191d2a952cf8484255d0da651ac7))
* **base-cluster/dependencies:** update helm release alloy to v1.5.0 ([#1855](https://github.com/teutonet/teutonet-helm-charts/issues/1855)) ([a157f21](https://github.com/teutonet/teutonet-helm-charts/commit/a157f21312b003118a6cb9aa2baf95df710faf30))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v79.11.0 ([#1850](https://github.com/teutonet/teutonet-helm-charts/issues/1850)) ([94e7e00](https://github.com/teutonet/teutonet-helm-charts/commit/94e7e004fa133c6ecc52d509f4b584aaf6ba36d4))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v79.9.0 ([#1842](https://github.com/teutonet/teutonet-helm-charts/issues/1842)) ([a834e6d](https://github.com/teutonet/teutonet-helm-charts/commit/a834e6d2bc6e058708484a3d7ed9f2b337bb8586))
* **base-cluster/dependencies:** update helm release reflector to v9.1.42 ([#1854](https://github.com/teutonet/teutonet-helm-charts/issues/1854)) ([b9a042a](https://github.com/teutonet/teutonet-helm-charts/commit/b9a042a452ec7ced9a99648dc59109f157ea668f))
* **base-cluster/dependencies:** update helm release tempo-distributed to v1.57.0 ([#1849](https://github.com/teutonet/teutonet-helm-charts/issues/1849)) ([c78f7d2](https://github.com/teutonet/teutonet-helm-charts/commit/c78f7d20375a4ac5aca33696c023e8bf0ad0ab8e))
* **base-cluster/ingress:** update gateway api ([#1843](https://github.com/teutonet/teutonet-helm-charts/issues/1843)) ([96a4b76](https://github.com/teutonet/teutonet-helm-charts/commit/96a4b765f7e4c595b302be182beef333a68dceb1))

## [10.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v10.1.0...base-cluster-v10.1.1) (2025-11-28)


### Bug Fixes

* **base-cluster/tracing:** use correct resources for tracing gateway ([#1832](https://github.com/teutonet/teutonet-helm-charts/issues/1832)) ([48c4fca](https://github.com/teutonet/teutonet-helm-charts/commit/48c4fca97048449a888987e9fb0986c1d5c17e44))


### Miscellaneous Chores

* **base-cluster/dependencies:** update helm release oauth2-proxy to v9 ([#1825](https://github.com/teutonet/teutonet-helm-charts/issues/1825)) ([b4f08bc](https://github.com/teutonet/teutonet-helm-charts/commit/b4f08bca7c9eba85124a2ac127d9f7db84577a68))
* **base-cluster/dependencies:** update helm release reflector to v9.1.41 ([#1833](https://github.com/teutonet/teutonet-helm-charts/issues/1833)) ([a7b9805](https://github.com/teutonet/teutonet-helm-charts/commit/a7b98054ce2f469b60faef58e9ec164cd1e30598))
* **base-cluster/dependencies:** update helm release traefik to v37 ([#1826](https://github.com/teutonet/teutonet-helm-charts/issues/1826)) ([fb514f3](https://github.com/teutonet/teutonet-helm-charts/commit/fb514f3a132f59c5d6911d2ca344ef4b38d01136))

## [10.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v10.0.3...base-cluster-v10.1.0) (2025-11-28)


### Features

* **base-cluster/logging:** enable automatic resizing ([#1785](https://github.com/teutonet/teutonet-helm-charts/issues/1785)) ([167e5e0](https://github.com/teutonet/teutonet-helm-charts/commit/167e5e03ae4b857e398ef3aa100fcd24db506a0f))
* **base-cluster/tracing:** add gateway to enable tail sampling ([#1736](https://github.com/teutonet/teutonet-helm-charts/issues/1736)) ([7c1bd9a](https://github.com/teutonet/teutonet-helm-charts/commit/7c1bd9a3504ea51cbdf8719298dacea3f9c41591))


### Bug Fixes

* **base-cluster/backup:** fix secret creation for velero ([#1816](https://github.com/teutonet/teutonet-helm-charts/issues/1816)) ([04a8ca0](https://github.com/teutonet/teutonet-helm-charts/commit/04a8ca01c23ce734467935addcbdab6cb2bcf5a8))
* **base-cluster/monitoring:** alertmanager condition ([#1781](https://github.com/teutonet/teutonet-helm-charts/issues/1781)) ([b6abed0](https://github.com/teutonet/teutonet-helm-charts/commit/b6abed0021bdfd788588e99a93f4fc7b4d5b07dd))


### Miscellaneous Chores

* **base-cluster/dependencies:** update common docker tag to v1.6.0 ([#1796](https://github.com/teutonet/teutonet-helm-charts/issues/1796)) ([f1d8f05](https://github.com/teutonet/teutonet-helm-charts/commit/f1d8f050bd11c2d797ccde70442d1c6b20990422))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.17.0 ([#1797](https://github.com/teutonet/teutonet-helm-charts/issues/1797)) ([86362fe](https://github.com/teutonet/teutonet-helm-charts/commit/86362fe91ff13e529540d59c4cb41026f88ed2e0))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.7.3 ([#1798](https://github.com/teutonet/teutonet-helm-charts/issues/1798)) ([f7b42d1](https://github.com/teutonet/teutonet-helm-charts/commit/f7b42d1b81c74931d9712600f0248db473e0e56d))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.7.4 ([#1818](https://github.com/teutonet/teutonet-helm-charts/issues/1818)) ([6a318a1](https://github.com/teutonet/teutonet-helm-charts/commit/6a318a18afc701c7b39f830a2757fe495a015512))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.7.5 ([#1823](https://github.com/teutonet/teutonet-helm-charts/issues/1823)) ([bcd266e](https://github.com/teutonet/teutonet-helm-charts/commit/bcd266e1b0e045f27eeb913d6be2edad4a818e50))
* **base-cluster/dependencies:** update docker.io/grafana/grafana-image-renderer docker tag to v3.12.9 ([#1639](https://github.com/teutonet/teutonet-helm-charts/issues/1639)) ([e99101a](https://github.com/teutonet/teutonet-helm-charts/commit/e99101a573c6677f5fd011b2421c2cdd53a9e1bf))
* **base-cluster/dependencies:** update helm release alloy to v1.2.1 ([#1771](https://github.com/teutonet/teutonet-helm-charts/issues/1771)) ([87df788](https://github.com/teutonet/teutonet-helm-charts/commit/87df7887b4934e476fb1f5849c8f7861f64655ab))
* **base-cluster/dependencies:** update helm release alloy to v1.4.0 ([#1799](https://github.com/teutonet/teutonet-helm-charts/issues/1799)) ([9bc1aaa](https://github.com/teutonet/teutonet-helm-charts/commit/9bc1aaa2a6d8d9df5917d85597dce00da7fda23c))
* **base-cluster/dependencies:** update helm release descheduler to v0.34.0 ([#1800](https://github.com/teutonet/teutonet-helm-charts/issues/1800)) ([33f9a53](https://github.com/teutonet/teutonet-helm-charts/commit/33f9a531d5fd6c1894dea4156ca938a338cb888a))
* **base-cluster/dependencies:** update helm release external-dns to v1.19.0 ([#1801](https://github.com/teutonet/teutonet-helm-charts/issues/1801)) ([c1f24a4](https://github.com/teutonet/teutonet-helm-charts/commit/c1f24a4c95a2a57a71cf18a34a25d8f94446a43e))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v75.15.2 ([#1772](https://github.com/teutonet/teutonet-helm-charts/issues/1772)) ([0cc66b2](https://github.com/teutonet/teutonet-helm-charts/commit/0cc66b27104ecfe40e259439e6df14ef73df7216))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v75.18.1 ([#1802](https://github.com/teutonet/teutonet-helm-charts/issues/1802)) ([b096b58](https://github.com/teutonet/teutonet-helm-charts/commit/b096b58c609aa1ee9fa8845c4d49e5223d004d7d))
* **base-cluster/dependencies:** update helm release loki to v6.46.0 ([#1727](https://github.com/teutonet/teutonet-helm-charts/issues/1727)) ([ec1b906](https://github.com/teutonet/teutonet-helm-charts/commit/ec1b9065b421b69d456e2be86e560d93450f39ae))
* **base-cluster/dependencies:** update helm release metrics-server to v3.13.0 ([#1805](https://github.com/teutonet/teutonet-helm-charts/issues/1805)) ([6ba8633](https://github.com/teutonet/teutonet-helm-charts/commit/6ba86338b855f549e212f733c0609925ebcf9d01))
* **base-cluster/dependencies:** update helm release oauth2-proxy to v7.14.2 ([#1635](https://github.com/teutonet/teutonet-helm-charts/issues/1635)) ([d88c7c0](https://github.com/teutonet/teutonet-helm-charts/commit/d88c7c098327c6e65cd8df75434b7ec5fb3ff5d2))
* **base-cluster/dependencies:** update helm release oauth2-proxy to v7.18.0 ([#1806](https://github.com/teutonet/teutonet-helm-charts/issues/1806)) ([636a585](https://github.com/teutonet/teutonet-helm-charts/commit/636a585c2282b778df9f8621cf19f9dd5f682093))
* **base-cluster/dependencies:** update helm release reflector to v9.1.39 ([#1790](https://github.com/teutonet/teutonet-helm-charts/issues/1790)) ([5b032af](https://github.com/teutonet/teutonet-helm-charts/commit/5b032afe11f792f9f71284237a53a6d8395a7455))
* **base-cluster/dependencies:** update helm release reflector to v9.1.40 ([#1819](https://github.com/teutonet/teutonet-helm-charts/issues/1819)) ([da8be9d](https://github.com/teutonet/teutonet-helm-charts/commit/da8be9d04dae25307f58cd59bc4fa96eed3854d2))
* **base-cluster/dependencies:** update helm release tempo-distributed to v1.48.1 ([#1791](https://github.com/teutonet/teutonet-helm-charts/issues/1791)) ([d00ac00](https://github.com/teutonet/teutonet-helm-charts/commit/d00ac00973136c61644c42de5de38f681be292e0))
* **base-cluster/dependencies:** update helm release tempo-distributed to v1.56.2 ([#1807](https://github.com/teutonet/teutonet-helm-charts/issues/1807)) ([80c67d1](https://github.com/teutonet/teutonet-helm-charts/commit/80c67d16cb1f97c725de478a2a11428097873f96))
* **base-cluster/dependencies:** update helm release tetragon to v1.6.0 ([#1808](https://github.com/teutonet/teutonet-helm-charts/issues/1808)) ([c3fb92d](https://github.com/teutonet/teutonet-helm-charts/commit/c3fb92d65ffa395ec0731718c3f19f03f2619e75))
* **base-cluster/dependencies:** update helm release trivy-operator to v0.31.0 ([#1809](https://github.com/teutonet/teutonet-helm-charts/issues/1809)) ([59976f6](https://github.com/teutonet/teutonet-helm-charts/commit/59976f60e1ef1eb66a160a414ffc4a89b664e009))

## [10.0.3](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v10.0.2...base-cluster-v10.0.3) (2025-10-31)


### Miscellaneous Chores

* **base-cluster:** change value name to camel ([#1777](https://github.com/teutonet/teutonet-helm-charts/issues/1777)) ([b3bd6be](https://github.com/teutonet/teutonet-helm-charts/commit/b3bd6becaf6721b517bc1d6d192652b72dfc4571))

## [10.0.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v10.0.1...base-cluster-v10.0.2) (2025-10-31)


### Bug Fixes

* **base-cluster:** add missing value to template ([#1775](https://github.com/teutonet/teutonet-helm-charts/issues/1775)) ([870e7d1](https://github.com/teutonet/teutonet-helm-charts/commit/870e7d1db15976dd33754486768aeeba88db85d6))


### Miscellaneous Chores

* **base-cluster:** add loki retention value ([#1774](https://github.com/teutonet/teutonet-helm-charts/issues/1774)) ([de6b582](https://github.com/teutonet/teutonet-helm-charts/commit/de6b5825b1ffd6e2095fdc162d365aeb8c777864))

## [10.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v10.0.0...base-cluster-v10.0.1) (2025-10-27)


### Bug Fixes

* **base-cluster/descheduler:** don't remove pods with too many restarts ([#1744](https://github.com/teutonet/teutonet-helm-charts/issues/1744)) ([9c1ed51](https://github.com/teutonet/teutonet-helm-charts/commit/9c1ed51ef65d64dc1c61959901a2597981bdbd68))
* **base-cluster/ingress:** add missing `prometheus` block 🙄 ([#1767](https://github.com/teutonet/teutonet-helm-charts/issues/1767)) ([a329e1a](https://github.com/teutonet/teutonet-helm-charts/commit/a329e1ad30c30f801c991c52c6e118e62577e887))
* **base-cluster/loki:** adjust retention settings for loki logs ([#1745](https://github.com/teutonet/teutonet-helm-charts/issues/1745)) ([1985d34](https://github.com/teutonet/teutonet-helm-charts/commit/1985d3417efef4f97441b7ff6b3849a57ad42e3c))
* **base-cluster/monitoring:** use the correct prometheus datasource id ([#1764](https://github.com/teutonet/teutonet-helm-charts/issues/1764)) ([511cc84](https://github.com/teutonet/teutonet-helm-charts/commit/511cc849824e5c6a90dc1e956e8b0ee4b80738e7))

## [10.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.4.0...base-cluster-v10.0.0) (2025-10-23)


### ⚠ BREAKING CHANGES

* **base-cluster/backup:** add k8up provider ([#1751](https://github.com/teutonet/teutonet-helm-charts/issues/1751))

### Features

* **base-cluster/backup:** add k8up provider ([#1751](https://github.com/teutonet/teutonet-helm-charts/issues/1751)) ([0f36225](https://github.com/teutonet/teutonet-helm-charts/commit/0f362256ff0a3abb18edb78dbbf9f78aec71039d))


### Bug Fixes

* **base-cluster/kyverno:** change kubectl image ([#1734](https://github.com/teutonet/teutonet-helm-charts/issues/1734)) ([cb42f26](https://github.com/teutonet/teutonet-helm-charts/commit/cb42f26934961f71e9f1b69bc2dfbb96eafa1ff1))
* **base-cluster:** conditions must the `true`, not just truthy ([#1738](https://github.com/teutonet/teutonet-helm-charts/issues/1738)) ([7f46f4e](https://github.com/teutonet/teutonet-helm-charts/commit/7f46f4ea9b00c0b0c8f3c435a2b4519e125aaf1e))
* **base-cluster:** migrate promtail leftovers to alloy ([#1720](https://github.com/teutonet/teutonet-helm-charts/issues/1720)) ([8b7d062](https://github.com/teutonet/teutonet-helm-charts/commit/8b7d062cfeee4d54d52b8156dad46e0b9a5f19d9))


### Miscellaneous Chores

* **base-cluster/external-dns:** migrate domainFilters syntax ([#1681](https://github.com/teutonet/teutonet-helm-charts/issues/1681)) ([51a42a2](https://github.com/teutonet/teutonet-helm-charts/commit/51a42a24c2e84b70f81c63b7df9ded4b040f2bb4))
* **base-cluster/kdave:** remove kdave ([#1724](https://github.com/teutonet/teutonet-helm-charts/issues/1724)) ([723c049](https://github.com/teutonet/teutonet-helm-charts/commit/723c04913c4e07294a69391a20338bfc2646e3b2))
* **base-cluster/logs:** only delete volumes on deletion ([#1721](https://github.com/teutonet/teutonet-helm-charts/issues/1721)) ([36b657a](https://github.com/teutonet/teutonet-helm-charts/commit/36b657a990113a230a4e50027e5de263dbcbc69c))
* **base-cluster/logs:** optimize volume chown; this speeds up startup ([36b657a](https://github.com/teutonet/teutonet-helm-charts/commit/36b657a990113a230a4e50027e5de263dbcbc69c))
* **base-cluster/traces:** delete tempo volumes on deletion ([#1722](https://github.com/teutonet/teutonet-helm-charts/issues/1722)) ([0afce96](https://github.com/teutonet/teutonet-helm-charts/commit/0afce965f2c42d179a290bf9d14555d74ba10283))
* **base-cluster:** use upstream kubectl image instead of rancher ([#1718](https://github.com/teutonet/teutonet-helm-charts/issues/1718)) ([d4daf94](https://github.com/teutonet/teutonet-helm-charts/commit/d4daf945536eed6b588c8b765d1a95dddfe92a44))

## [9.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.3.2...base-cluster-v9.4.0) (2025-09-25)


### Features

* **base-cluster/traefik:** Changed ipFamilyPolicy to DualStack ([#1694](https://github.com/teutonet/teutonet-helm-charts/issues/1694)) ([166c9af](https://github.com/teutonet/teutonet-helm-charts/commit/166c9af490ed6c2efb521c873c692608ba86b8a5))


### Bug Fixes

* **base-cluster/velero:** remove last reference to bitnami images ([#1701](https://github.com/teutonet/teutonet-helm-charts/issues/1701)) ([50a5112](https://github.com/teutonet/teutonet-helm-charts/commit/50a51126c9a17f2b0418217d63075c2ff4db7a25))

## [9.3.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.3.1...base-cluster-v9.3.2) (2025-09-02)


### Bug Fixes

* **base-cluster/monitoring:** otherwise the metric will be duplicated if `suspend` is not set ([#1661](https://github.com/teutonet/teutonet-helm-charts/issues/1661)) ([193c6b3](https://github.com/teutonet/teutonet-helm-charts/commit/193c6b37928ae55c565c24f5bdce272951ad87c4))

## [9.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.3.0...base-cluster-v9.3.1) (2025-08-15)


### Bug Fixes

* **base-cluster/external-dns:** correctly check if provider is set ([#1658](https://github.com/teutonet/teutonet-helm-charts/issues/1658)) ([7933988](https://github.com/teutonet/teutonet-helm-charts/commit/7933988877da6f1284836b6bb390a9d5abac6534))

## [9.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.2.0...base-cluster-v9.3.0) (2025-08-15)


### Features

* **base-cluster/kyverno:** add capability for exceptions to be in all namespaces ([#1656](https://github.com/teutonet/teutonet-helm-charts/issues/1656)) ([1441fb0](https://github.com/teutonet/teutonet-helm-charts/commit/1441fb052b95273d854c0d3543660dbbf9fa1082))

## [9.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.1.1...base-cluster-v9.2.0) (2025-08-14)


### Features

* **base-cluster/cert-manager:** enableCertificateOwnerRef ([#1653](https://github.com/teutonet/teutonet-helm-charts/issues/1653)) ([283d86f](https://github.com/teutonet/teutonet-helm-charts/commit/283d86f38d828f91b2bc601d49ec6513cde3f41a))
* **base-cluster/cert-manager:** use oci repository ([#1650](https://github.com/teutonet/teutonet-helm-charts/issues/1650)) ([ef6382d](https://github.com/teutonet/teutonet-helm-charts/commit/ef6382dbc078466b98e1fb8a5473839d5b9112a2))
* **base-cluster/kyverno:** enable policyExceptions for kyverno ([#1655](https://github.com/teutonet/teutonet-helm-charts/issues/1655)) ([2029bcb](https://github.com/teutonet/teutonet-helm-charts/commit/2029bcb8fe202a7d11dfb462f43c533b4631b9e5))


### Bug Fixes

* **base-cluster/certificates:** certificate for `baseDomain` is not used ([#1644](https://github.com/teutonet/teutonet-helm-charts/issues/1644)) ([6a3ccae](https://github.com/teutonet/teutonet-helm-charts/commit/6a3ccae31cd8592b6f25f6ec16aba5892510a561))
* **base-cluster/dns:** only deploy external-dns HelmRepository if needed ([#1645](https://github.com/teutonet/teutonet-helm-charts/issues/1645)) ([7d313f2](https://github.com/teutonet/teutonet-helm-charts/commit/7d313f2a7e2c8ac33f60cd6588dfd1c5fceb9d14))
* **base-cluster/ingress-nginx:** set a couple of timeouts in the loadbalancer to the maximum value ([#1571](https://github.com/teutonet/teutonet-helm-charts/issues/1571)) ([bc6fe78](https://github.com/teutonet/teutonet-helm-charts/commit/bc6fe78413ea26f3b5003d645ef9918d0b346265))
* **base-cluster/monitoring:** remove versions from datasources so they always take precedence ([#1651](https://github.com/teutonet/teutonet-helm-charts/issues/1651)) ([6821ed8](https://github.com/teutonet/teutonet-helm-charts/commit/6821ed816d7d4263b0e683db366cf8ca7edd3b24))

## [9.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.1.0...base-cluster-v9.1.1) (2025-08-01)


### Bug Fixes

* **base-cluster/monitoring:** lock down kdave container ([#1646](https://github.com/teutonet/teutonet-helm-charts/issues/1646)) ([431548d](https://github.com/teutonet/teutonet-helm-charts/commit/431548d0e3d6423e06818f01ac0fd12ca5a3bf86))

## [9.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v9.0.0...base-cluster-v9.1.0) (2025-07-31)


### Features

* **base-cluster:** use new networkPolicy template ([#1414](https://github.com/teutonet/teutonet-helm-charts/issues/1414)) ([e433c02](https://github.com/teutonet/teutonet-helm-charts/commit/e433c02fb74052800e73a30ad03393a6e2754ac8))


### Bug Fixes

* **base-cluster/kyverno:** migrate to new `validationFailureAction` syntax ([#1621](https://github.com/teutonet/teutonet-helm-charts/issues/1621)) ([c3f16be](https://github.com/teutonet/teutonet-helm-charts/commit/c3f16bedb07de2fb1d7f2f238e9061c2f18bb656))
* **base-cluster/monitoring:** also create metrics for resources without suspend field ([#1634](https://github.com/teutonet/teutonet-helm-charts/issues/1634)) ([964b34c](https://github.com/teutonet/teutonet-helm-charts/commit/964b34c442e206040102f41f1309f45847622a16))
* **base-cluster/monitoring:** oauth-proxy serviceMonitor labels ([#1625](https://github.com/teutonet/teutonet-helm-charts/issues/1625)) ([86c1981](https://github.com/teutonet/teutonet-helm-charts/commit/86c198160202f47b4d081a07c4885e157bf75927))
* **base-cluster/monitoring:** pin image-renderer version to ensure it's compatible ([#1631](https://github.com/teutonet/teutonet-helm-charts/issues/1631)) ([685592c](https://github.com/teutonet/teutonet-helm-charts/commit/685592c14d617c1feb061730dab10ffc52850048))


### Miscellaneous Chores

* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v75.15.1 ([#1610](https://github.com/teutonet/teutonet-helm-charts/issues/1610)) ([256cb8e](https://github.com/teutonet/teutonet-helm-charts/commit/256cb8ea3718ed74427af61617289d5685840e2b))
* **base-cluster/dependencies:** update helm release loki to v6.33.0 ([#1618](https://github.com/teutonet/teutonet-helm-charts/issues/1618)) ([7e6a8e8](https://github.com/teutonet/teutonet-helm-charts/commit/7e6a8e8df1bb6efe30b8266de2181b1d5b231179))
* **base-cluster/dns:** migrate external-dns away from bitnami ([#1601](https://github.com/teutonet/teutonet-helm-charts/issues/1601)) ([7af34d2](https://github.com/teutonet/teutonet-helm-charts/commit/7af34d2f5f83995c6ad6cd665ac44055f606f281))
* **base-cluster/monitoring:** adjust metrics syntax ([#1562](https://github.com/teutonet/teutonet-helm-charts/issues/1562)) ([ebc2d74](https://github.com/teutonet/teutonet-helm-charts/commit/ebc2d74fabbd9b26de5db431158fc8e889310fd5))
* **base-cluster/monitoring:** migrate metrics-server away from bitnami ([#1604](https://github.com/teutonet/teutonet-helm-charts/issues/1604)) ([6a755d9](https://github.com/teutonet/teutonet-helm-charts/commit/6a755d9556619b4d2abaccb757250ebdc89345ef))
* **base-cluster:** migrate kubectl image away from bitnami ([#1606](https://github.com/teutonet/teutonet-helm-charts/issues/1606)) ([6fe2410](https://github.com/teutonet/teutonet-helm-charts/commit/6fe241066d03b1ebf77057c4be46c472b4db11e5))

## [9.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v8.2.1...base-cluster-v9.0.0) (2025-07-25)


### ⚠ BREAKING CHANGES

* **base-cluster/monitoring/alertmanager:** add receiver and route configuration capabilities ([#1600](https://github.com/teutonet/teutonet-helm-charts/issues/1600))

### Features

* **base-cluster/monitoring/alertmanager:** add receiver and route configuration capabilities ([#1600](https://github.com/teutonet/teutonet-helm-charts/issues/1600)) ([7f549fb](https://github.com/teutonet/teutonet-helm-charts/commit/7f549fb95019d1e1db288bc0ca278601fe5d370f))
* **base-cluster/monitoring:** don't automount the ServiceAccountToken ([#1615](https://github.com/teutonet/teutonet-helm-charts/issues/1615)) ([52386b7](https://github.com/teutonet/teutonet-helm-charts/commit/52386b7a0c1e8a062748af985f98ddf85f1408b1))


### Miscellaneous Chores

* **base-cluster/monitoring:** deploy log collector to potential control-plane ([#1616](https://github.com/teutonet/teutonet-helm-charts/issues/1616)) ([e021845](https://github.com/teutonet/teutonet-helm-charts/commit/e021845ad3299668918a7d4fc5a7532c45495503))

## [8.2.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v8.2.0...base-cluster-v8.2.1) (2025-07-24)


### Bug Fixes

* **base-cluster/rbac:** whitespace trimming ([#1608](https://github.com/teutonet/teutonet-helm-charts/issues/1608)) ([4b028b4](https://github.com/teutonet/teutonet-helm-charts/commit/4b028b4ad0c04eadba520452292a15748e8b3d95))

## [8.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v8.1.0...base-cluster-v8.2.0) (2025-07-21)


### Features

* **base-cluster/flux:** add alert about suspended resources ([#1540](https://github.com/teutonet/teutonet-helm-charts/issues/1540)) ([bb1555e](https://github.com/teutonet/teutonet-helm-charts/commit/bb1555ede130f4ca909b41732df083a96859dc6b))
* **base-cluster/monitoring:** lower cpu request for prometheus ([#1578](https://github.com/teutonet/teutonet-helm-charts/issues/1578)) ([4a83bf6](https://github.com/teutonet/teutonet-helm-charts/commit/4a83bf6a0bdad3bb5a9f08de52d051a1644588d8))
* **base-cluster/monitoring:** non-critical alerts aren't routed to on-call ([#1533](https://github.com/teutonet/teutonet-helm-charts/issues/1533)) ([0d080f4](https://github.com/teutonet/teutonet-helm-charts/commit/0d080f4876a8141931e5f37d6ebb56c6b367bf0e))
* **base-cluster/rbac:** adjust rbac stuff for OIDC accounts ([#1538](https://github.com/teutonet/teutonet-helm-charts/issues/1538)) ([3f9aa69](https://github.com/teutonet/teutonet-helm-charts/commit/3f9aa697ff37b61f7113ff6d88d6d0012538019f))


### Bug Fixes

* **base-cluster/docs:** there is no 9.0.0 release for now... ([#1563](https://github.com/teutonet/teutonet-helm-charts/issues/1563)) ([8e417fb](https://github.com/teutonet/teutonet-helm-charts/commit/8e417fb688f6d9f1c869cd0e319fb87eb48c1ece))


### Miscellaneous Chores

* **base-cluster/dependencies:** update common docker tag to v1.5.0 ([#1520](https://github.com/teutonet/teutonet-helm-charts/issues/1520)) ([cb4a522](https://github.com/teutonet/teutonet-helm-charts/commit/cb4a5220023ea8b4edfe0ba13217d0392baab0a1))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.33.3-debian-12-r1 ([#1521](https://github.com/teutonet/teutonet-helm-charts/issues/1521)) ([4ed2a77](https://github.com/teutonet/teutonet-helm-charts/commit/4ed2a77a180972a3fc9718ff0f61d7fd74c3ae46))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.13.0 ([#1523](https://github.com/teutonet/teutonet-helm-charts/issues/1523)) ([e451428](https://github.com/teutonet/teutonet-helm-charts/commit/e451428d5d0295210620322f5929416f05256c72))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.14.1 ([#1544](https://github.com/teutonet/teutonet-helm-charts/issues/1544)) ([02ba163](https://github.com/teutonet/teutonet-helm-charts/commit/02ba1630fbeb8a2ad1dfac6399f54a70afa91071))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.15.0 ([#1585](https://github.com/teutonet/teutonet-helm-charts/issues/1585)) ([a672a67](https://github.com/teutonet/teutonet-helm-charts/commit/a672a67b0b0eaf519a99c0082ae5c1dd6a9d5dbd))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.6.1 ([#1524](https://github.com/teutonet/teutonet-helm-charts/issues/1524)) ([956ad7e](https://github.com/teutonet/teutonet-helm-charts/commit/956ad7ed1b25b94791ee9cf26b614ac7f96aec38))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.6.4 ([#1536](https://github.com/teutonet/teutonet-helm-charts/issues/1536)) ([32a69cc](https://github.com/teutonet/teutonet-helm-charts/commit/32a69cc5ee33de6376ba5fd9c27a6b9aba911a26))
* **base-cluster/dependencies:** update docker.io/vladgh/gpg docker tag to v1.3.6 ([#1509](https://github.com/teutonet/teutonet-helm-charts/issues/1509)) ([e521e61](https://github.com/teutonet/teutonet-helm-charts/commit/e521e616aee15234ad70f0dcc12d89797532317a))
* **base-cluster/dependencies:** update external-dns docker tag to v8.8.4 ([#1510](https://github.com/teutonet/teutonet-helm-charts/issues/1510)) ([b8b3f80](https://github.com/teutonet/teutonet-helm-charts/commit/b8b3f809064221d02416d3ee77531eda29a87bdc))
* **base-cluster/dependencies:** update external-dns docker tag to v8.9.1 ([#1559](https://github.com/teutonet/teutonet-helm-charts/issues/1559)) ([f9c5642](https://github.com/teutonet/teutonet-helm-charts/commit/f9c564236f343d09b15d8e4b321f19186cdbf547))
* **base-cluster/dependencies:** update external-dns docker tag to v8.9.2 ([#1575](https://github.com/teutonet/teutonet-helm-charts/issues/1575)) ([88b2630](https://github.com/teutonet/teutonet-helm-charts/commit/88b2630644a6962f736cc9a885e7aace10576364))
* **base-cluster/dependencies:** update grafana-tempo docker tag to v4 ([#1570](https://github.com/teutonet/teutonet-helm-charts/issues/1570)) ([63c2593](https://github.com/teutonet/teutonet-helm-charts/commit/63c259337ec8ca8a2363e5799adb3b51781a3554))
* **base-cluster/dependencies:** update grafana-tempo docker tag to v4.0.13 ([#1580](https://github.com/teutonet/teutonet-helm-charts/issues/1580)) ([5b9df00](https://github.com/teutonet/teutonet-helm-charts/commit/5b9df00b907aca4c1403c6b0e06dbc68f6bc16c7))
* **base-cluster/dependencies:** update helm release alloy to v1 ([#1573](https://github.com/teutonet/teutonet-helm-charts/issues/1573)) ([013a670](https://github.com/teutonet/teutonet-helm-charts/commit/013a67039e440e2a7364cec1a6de1f48dc4082c2))
* **base-cluster/dependencies:** update helm release alloy to v1.2.0 ([#1596](https://github.com/teutonet/teutonet-helm-charts/issues/1596)) ([aec70ba](https://github.com/teutonet/teutonet-helm-charts/commit/aec70ba52a18ce7eef4f99a4b7e91ec9f6ec39d3))
* **base-cluster/dependencies:** update helm release descheduler to v0.33.0 ([#1525](https://github.com/teutonet/teutonet-helm-charts/issues/1525)) ([36d8eca](https://github.com/teutonet/teutonet-helm-charts/commit/36d8ecaf7213fde6def6a284a56bb0fea3aa25ce))
* **base-cluster/dependencies:** update helm release ingress-nginx to v4.12.3 ([#1511](https://github.com/teutonet/teutonet-helm-charts/issues/1511)) ([3dd2aa7](https://github.com/teutonet/teutonet-helm-charts/commit/3dd2aa7f6618b8c602531ba9bb40a65e083b3e1b))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v75.12.0 ([#1598](https://github.com/teutonet/teutonet-helm-charts/issues/1598)) ([eec214f](https://github.com/teutonet/teutonet-helm-charts/commit/eec214f1fc21e63b4974dba0fe3f4607583c3b90))
* **base-cluster/dependencies:** update helm release kyverno to v3.4.4 ([#1512](https://github.com/teutonet/teutonet-helm-charts/issues/1512)) ([bc20fb9](https://github.com/teutonet/teutonet-helm-charts/commit/bc20fb9172d6bd20488b8ca86861aec07e3cf8ad))
* **base-cluster/dependencies:** update helm release kyverno-policies to v3.4.4 ([#1513](https://github.com/teutonet/teutonet-helm-charts/issues/1513)) ([f79dce1](https://github.com/teutonet/teutonet-helm-charts/commit/f79dce16b3965ae31dfd20a882df694a0f1550fe))
* **base-cluster/dependencies:** update helm release loki to v6.30.1 ([#1526](https://github.com/teutonet/teutonet-helm-charts/issues/1526)) ([4bf6daa](https://github.com/teutonet/teutonet-helm-charts/commit/4bf6daafb4438328bc896748cd186a2fb863a4af))
* **base-cluster/dependencies:** update helm release loki to v6.31.0 ([#1566](https://github.com/teutonet/teutonet-helm-charts/issues/1566)) ([b188c09](https://github.com/teutonet/teutonet-helm-charts/commit/b188c095f01f84b101416ad8b8399759355696d7))
* **base-cluster/dependencies:** update helm release loki to v6.32.0 ([#1586](https://github.com/teutonet/teutonet-helm-charts/issues/1586)) ([57c7d86](https://github.com/teutonet/teutonet-helm-charts/commit/57c7d867aefcc58cf47372f32a20e1105191ea39))
* **base-cluster/dependencies:** update helm release reflector to v9 ([#1590](https://github.com/teutonet/teutonet-helm-charts/issues/1590)) ([e679195](https://github.com/teutonet/teutonet-helm-charts/commit/e6791955ee0f0546174c1fda25dee487ef8fa46a))
* **base-cluster/dependencies:** update helm release tetragon to v1.4.1 ([#1581](https://github.com/teutonet/teutonet-helm-charts/issues/1581)) ([ff4f27d](https://github.com/teutonet/teutonet-helm-charts/commit/ff4f27d7306eb56ce29457d7ac46cc21829ac2c7))
* **base-cluster/dependencies:** update helm release traefik to v35.4.0 ([#1527](https://github.com/teutonet/teutonet-helm-charts/issues/1527)) ([9d30e5e](https://github.com/teutonet/teutonet-helm-charts/commit/9d30e5e36e72f71c2a12ea39080897ef5f1beabc))
* **base-cluster/dependencies:** update helm release traefik to v36 ([#1592](https://github.com/teutonet/teutonet-helm-charts/issues/1592)) ([8c9cafa](https://github.com/teutonet/teutonet-helm-charts/commit/8c9cafac227085d970e1271372c809972c6094e5))
* **base-cluster/dependencies:** update helm release trivy-operator to v0.29.2 ([#1528](https://github.com/teutonet/teutonet-helm-charts/issues/1528)) ([a815190](https://github.com/teutonet/teutonet-helm-charts/commit/a8151901cfc338d23130fb69ecef8e733902f2ac))
* **base-cluster/dependencies:** update helm release trivy-operator to v0.29.3 ([#1582](https://github.com/teutonet/teutonet-helm-charts/issues/1582)) ([b078902](https://github.com/teutonet/teutonet-helm-charts/commit/b0789029410b2755c3daba0ce968b3595bbb70e4))
* **base-cluster/dependencies:** update helm release velero to v7.2.2 ([#1172](https://github.com/teutonet/teutonet-helm-charts/issues/1172)) ([a33e9cb](https://github.com/teutonet/teutonet-helm-charts/commit/a33e9cb6e265243640e935790c0c66dec4ab425a))
* **base-cluster/dependencies:** update metrics-server docker tag to v7.4.10 ([#1576](https://github.com/teutonet/teutonet-helm-charts/issues/1576)) ([c29757a](https://github.com/teutonet/teutonet-helm-charts/commit/c29757ab08ae083284f308f8316188fab58eabf8))
* **base-cluster/dependencies:** update metrics-server docker tag to v7.4.6 ([#1514](https://github.com/teutonet/teutonet-helm-charts/issues/1514)) ([c897fbd](https://github.com/teutonet/teutonet-helm-charts/commit/c897fbd9369815aba7ea2c7c757196219b5b09aa))
* **base-cluster/dependencies:** update metrics-server docker tag to v7.4.9 ([#1541](https://github.com/teutonet/teutonet-helm-charts/issues/1541)) ([134e3c1](https://github.com/teutonet/teutonet-helm-charts/commit/134e3c11024f7715981727a5530f0bc2bdb1fca4))
* **base-cluster/dependencies:** update oauth2-proxy docker tag to v6.2.13 ([#1515](https://github.com/teutonet/teutonet-helm-charts/issues/1515)) ([0c04e1c](https://github.com/teutonet/teutonet-helm-charts/commit/0c04e1c336a07b980a427d608bb0e411ae8765e6))

## [8.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v8.0.0...base-cluster-v8.1.0) (2025-06-06)


### Features

* **base-cluster/monitoring:** allow upsizing tempo storage ([#1448](https://github.com/teutonet/teutonet-helm-charts/issues/1448)) ([db1a742](https://github.com/teutonet/teutonet-helm-charts/commit/db1a742100eb98e5fcaf833794bf5e4259f425d4))
* **base-cluster/monitoring:** also read secrets for datasources ([#1479](https://github.com/teutonet/teutonet-helm-charts/issues/1479)) ([83ba8bd](https://github.com/teutonet/teutonet-helm-charts/commit/83ba8bd71d9f21a3a6b3310252326838425d4668))
* **base-cluster/monitoring:** configure service graph for grafana ([#1422](https://github.com/teutonet/teutonet-helm-charts/issues/1422)) ([8d4bb4c](https://github.com/teutonet/teutonet-helm-charts/commit/8d4bb4c6d2641fc80b85cb01b354a6386a9aeaf9))
* **base-cluster/monitoring:** set code challenge for grafana ([#1500](https://github.com/teutonet/teutonet-helm-charts/issues/1500)) ([aa803da](https://github.com/teutonet/teutonet-helm-charts/commit/aa803da92a64110eaf83a56e0f54942412487c00))
* **base-cluster/monitoring:** set code_challenge_method for oauth2-proxy ([#1496](https://github.com/teutonet/teutonet-helm-charts/issues/1496)) ([b252cd7](https://github.com/teutonet/teutonet-helm-charts/commit/b252cd7e6d5b4e6ff6e459417068eadd13a898da))


### Bug Fixes

* **base-cluster:** this prevents the user from installing this under another name ([#1418](https://github.com/teutonet/teutonet-helm-charts/issues/1418)) ([f4807e8](https://github.com/teutonet/teutonet-helm-charts/commit/f4807e88bfdd196541d28f8ae20e06f82cedb428))


### Miscellaneous Chores

* **base-cluster/docs:** update flux helmrelease command to update CRDs ([#1421](https://github.com/teutonet/teutonet-helm-charts/issues/1421)) ([a8fd535](https://github.com/teutonet/teutonet-helm-charts/commit/a8fd535e77c69e8813b5c8d631b20ff4d069edbe))
* **base-cluster/monitoring:** remove unnecessary open-telemetry-collector dashboard ([#1449](https://github.com/teutonet/teutonet-helm-charts/issues/1449)) ([520e9e1](https://github.com/teutonet/teutonet-helm-charts/commit/520e9e1a52e74974087a15ea215d9eb931dc3d3a))
* **base-cluster:** change descheduler syntax ([#1483](https://github.com/teutonet/teutonet-helm-charts/issues/1483)) ([907bdae](https://github.com/teutonet/teutonet-helm-charts/commit/907bdae6787077a75f7145c7ec0aa5f8a97ffd9c))

## [8.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v7.2.1...base-cluster-v8.0.0) (2025-05-27)


### ⚠ BREAKING CHANGES

* **base-cluster/ingress:** add option traefik for ingress controller and make it default ([#1420](https://github.com/teutonet/teutonet-helm-charts/issues/1420))
* **base-cluster/monitoring:** migrate promtail to alloy ([#1347](https://github.com/teutonet/teutonet-helm-charts/issues/1347))

### Features

* **base-cluster/ingress-nginx:** use risk-level Critical when annotations are enabled ([#1417](https://github.com/teutonet/teutonet-helm-charts/issues/1417)) ([a9d8ef2](https://github.com/teutonet/teutonet-helm-charts/commit/a9d8ef2a8a6854ac888d30d8188b7d8eaf320ecb))
* **base-cluster/ingress:** add option traefik for ingress controller and make it default ([#1420](https://github.com/teutonet/teutonet-helm-charts/issues/1420)) ([f62b197](https://github.com/teutonet/teutonet-helm-charts/commit/f62b1971038760bc7b66c35ff78b98703fde28a1))
* **base-cluster/ingress:** rename oauth-proxies to have a clean name ([#1434](https://github.com/teutonet/teutonet-helm-charts/issues/1434)) ([27a28d5](https://github.com/teutonet/teutonet-helm-charts/commit/27a28d5c5c3ffccb29272e8e12f22e44aeacf323))
* **base-cluster/monitoring:** migrate promtail to alloy ([#1347](https://github.com/teutonet/teutonet-helm-charts/issues/1347)) ([24db445](https://github.com/teutonet/teutonet-helm-charts/commit/24db44516ae6eaeafa1a45460375f80d7a171fbe))
* **base-cluster/monitoring:** rename alloy to be a generic name ([#1433](https://github.com/teutonet/teutonet-helm-charts/issues/1433)) ([3f5826a](https://github.com/teutonet/teutonet-helm-charts/commit/3f5826addfb58a96b754f6c3188753117b3e8ebd))


### Bug Fixes

* **base-cluster/cert-manager:** metrics collection ([#1397](https://github.com/teutonet/teutonet-helm-charts/issues/1397)) ([71e1189](https://github.com/teutonet/teutonet-helm-charts/commit/71e1189eb6e58d78fdbba867502318813c91fd32))
* **base-cluster/rbac:** *RoleBindings should always be prefixed to avoid collision ([#1484](https://github.com/teutonet/teutonet-helm-charts/issues/1484)) ([75de246](https://github.com/teutonet/teutonet-helm-charts/commit/75de246c30fca500b7e8bb0bff11ed7053fc3df3))


### Miscellaneous Chores

* **base-cluster/monitoring:** remove deprecated plugin ([#1478](https://github.com/teutonet/teutonet-helm-charts/issues/1478)) ([ee22df5](https://github.com/teutonet/teutonet-helm-charts/commit/ee22df5625c2495b3d93fdc01832cf5284e9e163))
* **base-cluster:** formatting ([#1424](https://github.com/teutonet/teutonet-helm-charts/issues/1424)) ([853f146](https://github.com/teutonet/teutonet-helm-charts/commit/853f146b1dd002a9975e3ec2ebb3ab053273d029))
* **base-cluster:** pin all versions ([#1447](https://github.com/teutonet/teutonet-helm-charts/issues/1447)) ([ec8a430](https://github.com/teutonet/teutonet-helm-charts/commit/ec8a4301f51c336ca047f7f4acc17c17fa595bc4))

## [7.2.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v7.2.0...base-cluster-v7.2.1) (2025-02-27)


### Bug Fixes

* **base-cluster/monitoring:** migrate to new flux metrics ([#1386](https://github.com/teutonet/teutonet-helm-charts/issues/1386)) ([18e48b2](https://github.com/teutonet/teutonet-helm-charts/commit/18e48b2dcb0dbd9fab5d9cbc6b84a10f735e9b58))


### Miscellaneous Chores

* **base-cluster/dependencies:** update common docker tag to v1.4.0 ([#1392](https://github.com/teutonet/teutonet-helm-charts/issues/1392)) ([bd7cccc](https://github.com/teutonet/teutonet-helm-charts/commit/bd7cccc994dc225e78d06bb10d73c24f1e9ccc51))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.31.4-debian-12-r1 ([#1224](https://github.com/teutonet/teutonet-helm-charts/issues/1224)) ([8e37d45](https://github.com/teutonet/teutonet-helm-charts/commit/8e37d45390de363fe9ec5809ab6af7db77b656dd))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.12.1 ([#1222](https://github.com/teutonet/teutonet-helm-charts/issues/1222)) ([b3530ed](https://github.com/teutonet/teutonet-helm-charts/commit/b3530ed26fd5613c57345b221a0e349ced4c87f0))
* **base-cluster/descheduler:** migrate config ([#1395](https://github.com/teutonet/teutonet-helm-charts/issues/1395)) ([ee58ce4](https://github.com/teutonet/teutonet-helm-charts/commit/ee58ce48ca1400cb74cd6869469eed05d28dd280))

## [7.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v7.1.3...base-cluster-v7.2.0) (2025-02-25)


### Features

* **base-cluster/monitoring:** improve alerting ([#1357](https://github.com/teutonet/teutonet-helm-charts/issues/1357)) ([3ce68b7](https://github.com/teutonet/teutonet-helm-charts/commit/3ce68b7823ebe1420a8199b4f066ffa730551256))


### Miscellaneous Chores

* **base-cluster/dependencies:** update common docker tag to v1.3.0 ([#1360](https://github.com/teutonet/teutonet-helm-charts/issues/1360)) ([816c247](https://github.com/teutonet/teutonet-helm-charts/commit/816c24717b1c4b45ea211231c18a9fb7ded161ab))

## [7.1.3](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v7.1.2...base-cluster-v7.1.3) (2025-02-21)


### Bug Fixes

* **base-cluster/monitoring:** use correct condition for grafana ingress ([#1350](https://github.com/teutonet/teutonet-helm-charts/issues/1350)) ([ec858d3](https://github.com/teutonet/teutonet-helm-charts/commit/ec858d3d0a5e75d3981906af3fd7b041a8508d7e))
* **base-cluster/rbac:** also allow preexistingRoles for clusterRole assignment ([#1351](https://github.com/teutonet/teutonet-helm-charts/issues/1351)) ([988168d](https://github.com/teutonet/teutonet-helm-charts/commit/988168daff826ba9316d1c4c0c433bb1daf918a4))

## [7.1.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v7.1.1...base-cluster-v7.1.2) (2025-02-12)


### Bug Fixes

* **base-cluster/kube-prometheus-stack:** only register healthcheck if enabled on both sides ([#1052](https://github.com/teutonet/teutonet-helm-charts/issues/1052)) ([21e966d](https://github.com/teutonet/teutonet-helm-charts/commit/21e966d7db3ff8ba36150305a321dca38aacc1a0))
* **base-cluster/kyverno:** apparently the type changed ([#1330](https://github.com/teutonet/teutonet-helm-charts/issues/1330)) ([aceafc3](https://github.com/teutonet/teutonet-helm-charts/commit/aceafc333f38f20e655ebae60c802ed969686a5d))
* **base-cluster:** allow all protocols for DNS ([#1306](https://github.com/teutonet/teutonet-helm-charts/issues/1306)) ([829ed95](https://github.com/teutonet/teutonet-helm-charts/commit/829ed95c65336be3795bdc08d84c6efa773f58fa))


### Miscellaneous Chores

* **base-cluster/docs:** mention validity of `.x.x` part in the versions ([#1271](https://github.com/teutonet/teutonet-helm-charts/issues/1271)) ([7e0894c](https://github.com/teutonet/teutonet-helm-charts/commit/7e0894cc8db3a34ba2fae7a9d4dee890192578c7))
* **base-cluster/docs:** set vim modeline ([#1290](https://github.com/teutonet/teutonet-helm-charts/issues/1290)) ([1276209](https://github.com/teutonet/teutonet-helm-charts/commit/127620966bb7a6c206e341fdcf6dce7ce05e96f5))
* **base-cluster:** make proxy-protocol configurable ([#1293](https://github.com/teutonet/teutonet-helm-charts/issues/1293)) ([0af12c6](https://github.com/teutonet/teutonet-helm-charts/commit/0af12c668dab11a38d204f4679432b04bd191d8c))

## [7.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v7.1.0...base-cluster-v7.1.1) (2024-12-20)


### Bug Fixes

* **base-cluster/kdave:** deploy wrapped ServiceMonitor ([#1267](https://github.com/teutonet/teutonet-helm-charts/issues/1267)) ([9698390](https://github.com/teutonet/teutonet-helm-charts/commit/96983905d7bde7c68bb4b8c07666512c7ffdb81f))

## [7.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v7.0.0...base-cluster-v7.1.0) (2024-12-04)


### Features

* **base-cluster/monitoring:** create aggregate ClusterRoles ([#1234](https://github.com/teutonet/teutonet-helm-charts/issues/1234)) ([cd037a0](https://github.com/teutonet/teutonet-helm-charts/commit/cd037a0fa942a75c6c087c86e7e2d2912e003690))


### Bug Fixes

* **base-cluster/tetragon:** only roll out tetragon repo when needed ([#1220](https://github.com/teutonet/teutonet-helm-charts/issues/1220)) ([2252399](https://github.com/teutonet/teutonet-helm-charts/commit/2252399ea0a6a31ea111359fdd0873e26375e001))
* **base-cluster:** additionalItems is the wrong field ([#1231](https://github.com/teutonet/teutonet-helm-charts/issues/1231)) ([0235cd6](https://github.com/teutonet/teutonet-helm-charts/commit/0235cd6f80eb168dfb12b3353af57790a85e6ddd))
* **base-cluster:** only `toYaml` if field exists ([#1226](https://github.com/teutonet/teutonet-helm-charts/issues/1226)) ([d81cd38](https://github.com/teutonet/teutonet-helm-charts/commit/d81cd3855530c7fafa7257c9507ab4e7caa220ca))


### Miscellaneous Chores

* **base-cluster/dependencies:** update helm release descheduler to 0.31.x ([#1236](https://github.com/teutonet/teutonet-helm-charts/issues/1236)) ([2504f6c](https://github.com/teutonet/teutonet-helm-charts/commit/2504f6c3bae93961b5af60bfa7cdd179019327b6))

## [7.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.7.0...base-cluster-v7.0.0) (2024-11-11)


### ⚠ BREAKING CHANGES

* **base-cluster/rbac:** allow to use the k8s default ClusterRoles ([#1230](https://github.com/teutonet/teutonet-helm-charts/issues/1230))
* **base-cluster/dependencies:** update helm release descheduler to 0.31.x ([#1173](https://github.com/teutonet/teutonet-helm-charts/issues/1173))

### Features

* **base-cluster/rbac:** allow to use the k8s default ClusterRoles ([#1230](https://github.com/teutonet/teutonet-helm-charts/issues/1230)) ([a3b24e4](https://github.com/teutonet/teutonet-helm-charts/commit/a3b24e4bf3f7256ac5a168d74830ddd79ba5f8d9))


### Bug Fixes

* **base-cluster/monitoring:** only roll out alertmanager oauth-proxy when alertmanager is enabled 🤣 ([#1180](https://github.com/teutonet/teutonet-helm-charts/issues/1180)) ([a1d8888](https://github.com/teutonet/teutonet-helm-charts/commit/a1d888866c2230ca01b364d9c7c2cfe78c5483a6))
* **base-cluster:** curl images imagePullPolicy ([#1168](https://github.com/teutonet/teutonet-helm-charts/issues/1168)) ([bb1942d](https://github.com/teutonet/teutonet-helm-charts/commit/bb1942d5d45b98cf29a7381759387dac13396658))


### Miscellaneous Chores

* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.31.2 ([#1191](https://github.com/teutonet/teutonet-helm-charts/issues/1191)) ([e3ffc13](https://github.com/teutonet/teutonet-helm-charts/commit/e3ffc13ac95fa95b6f177a48f6a3a5fbcb32225c))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.10.1 ([#1193](https://github.com/teutonet/teutonet-helm-charts/issues/1193)) ([54966a8](https://github.com/teutonet/teutonet-helm-charts/commit/54966a80f61b4da5fe149d42f5f0c2fbc46115e2))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.4.0 ([#1212](https://github.com/teutonet/teutonet-helm-charts/issues/1212)) ([6519edf](https://github.com/teutonet/teutonet-helm-charts/commit/6519edf4852201e474d696c113ce0fe93fa5fe6f))
* **base-cluster/dependencies:** update helm release descheduler to 0.31.x ([#1173](https://github.com/teutonet/teutonet-helm-charts/issues/1173)) ([784958c](https://github.com/teutonet/teutonet-helm-charts/commit/784958cc9e2508fb8e2afd533fcc6de68154095c))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v65 ([#1214](https://github.com/teutonet/teutonet-helm-charts/issues/1214)) ([5f701ed](https://github.com/teutonet/teutonet-helm-charts/commit/5f701ed3854862b5cb00d258f36119ea6fb67607))
* **base-cluster:** formatting ([#1198](https://github.com/teutonet/teutonet-helm-charts/issues/1198)) ([b9bd4a4](https://github.com/teutonet/teutonet-helm-charts/commit/b9bd4a4258bba421da8a09fc6040fb7330450307))
* **base-cluster:** this is now supported 🥳 ([#1135](https://github.com/teutonet/teutonet-helm-charts/issues/1135)) ([515ce2d](https://github.com/teutonet/teutonet-helm-charts/commit/515ce2da362b67fcf7519462c718a95973c55830))

## [6.7.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.6.3...base-cluster-v6.7.0) (2024-08-30)


### Features

* **base-cluster/tetragon:** add tetragon ([#1056](https://github.com/teutonet/teutonet-helm-charts/issues/1056)) ([9be7543](https://github.com/teutonet/teutonet-helm-charts/commit/9be75434ea7d2a63a2f64691d30a5038c8f5cdfb))


### Bug Fixes

* **base-cluster/kube-prometheus-stack:** only disable PrometheusNotConnectedToAlertmanagers when Alertmanager is disabled as well ([#1053](https://github.com/teutonet/teutonet-helm-charts/issues/1053)) ([dbb007a](https://github.com/teutonet/teutonet-helm-charts/commit/dbb007a9df530af4bd7753d39acfddc3da70868a))
* **base-cluster/monitoring:** send Watchdog alert to `null` if deadmansswitch is not configured ([#1120](https://github.com/teutonet/teutonet-helm-charts/issues/1120)) ([1e93c60](https://github.com/teutonet/teutonet-helm-charts/commit/1e93c60ffdad8a8c6868213bb00c069145b71514))


### Miscellaneous Chores

* **base-cluster/dependencies:** pin docker.io/vladgh/gpg docker tag to 1ba48a7 ([#1076](https://github.com/teutonet/teutonet-helm-charts/issues/1076)) ([23aa2dc](https://github.com/teutonet/teutonet-helm-charts/commit/23aa2dcc29c37ac077dacaa0f909c595a33c9b79))
* **base-cluster/dependencies:** update common docker tag to v1.2.1 ([#1080](https://github.com/teutonet/teutonet-helm-charts/issues/1080)) ([25ec4e8](https://github.com/teutonet/teutonet-helm-charts/commit/25ec4e82ebf257462551fee42ba4e5c05b1bbd47))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.8 ([#1060](https://github.com/teutonet/teutonet-helm-charts/issues/1060)) ([93f059a](https://github.com/teutonet/teutonet-helm-charts/commit/93f059a0b52d18f5680127b3ef89e0f018ec162d))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.31.0 ([#907](https://github.com/teutonet/teutonet-helm-charts/issues/907)) ([8544d01](https://github.com/teutonet/teutonet-helm-charts/commit/8544d01c3a8439b4dd1fe3435dc357bc96e3ac5f))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl:1.29.6 docker digest to 6f94559 ([#1027](https://github.com/teutonet/teutonet-helm-charts/issues/1027)) ([075d171](https://github.com/teutonet/teutonet-helm-charts/commit/075d171fd8326e4ae9e913c46684b98738b5b0c8))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.9.1 ([#1079](https://github.com/teutonet/teutonet-helm-charts/issues/1079)) ([8f1a39c](https://github.com/teutonet/teutonet-helm-charts/commit/8f1a39c0f45ecf3aeb21f7ce0ccadbf63df3c731))
* **base-cluster/dependencies:** update external-dns docker tag to v8 ([#1021](https://github.com/teutonet/teutonet-helm-charts/issues/1021)) ([9eb94aa](https://github.com/teutonet/teutonet-helm-charts/commit/9eb94aaad6a9d7aae64e4ad4a233bf609891ca52))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v62 ([#1145](https://github.com/teutonet/teutonet-helm-charts/issues/1145)) ([8ab376a](https://github.com/teutonet/teutonet-helm-charts/commit/8ab376aa99cbfcbf50ee3949514f3b333f9911de))
* **base-cluster/dependencies:** update helm release velero to v7.1.5 ([#1134](https://github.com/teutonet/teutonet-helm-charts/issues/1134)) ([32e0769](https://github.com/teutonet/teutonet-helm-charts/commit/32e0769a12e3113fcee9a0e59542bb61982c4ad2))
* **base-cluster/dependencies:** update oauth2-proxy docker tag to v6 ([#1146](https://github.com/teutonet/teutonet-helm-charts/issues/1146)) ([9885aba](https://github.com/teutonet/teutonet-helm-charts/commit/9885aba3b8cfed515a5b5409f6d7559f24510374))

## [6.6.3](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.6.2...base-cluster-v6.6.3) (2024-08-21)


### Bug Fixes

* **base-cluster/cert-manager:** ciliumNetworkPolicy for cert-manager otherwise it can't correctly talk to letsencrypt, ... 🤣 ([#1115](https://github.com/teutonet/teutonet-helm-charts/issues/1115)) ([a6919ca](https://github.com/teutonet/teutonet-helm-charts/commit/a6919caebb25ca105b7bcf33d21f6b727b431f52))
* **base-cluster/reflector:** pin image to registry and add image to trusted_registries ([#1090](https://github.com/teutonet/teutonet-helm-charts/issues/1090)) ([754c8b8](https://github.com/teutonet/teutonet-helm-charts/commit/754c8b87fa12917dd11f5cc3f5b8d792414c2b0e))


### Miscellaneous Chores

* **base-cluster/oauth-proxy:** adjust labels for proxies chore(base-cluster/oauth-proxy): adjust CiliumNetworkPolicy to correctly filter requests from ingress ([#1116](https://github.com/teutonet/teutonet-helm-charts/issues/1116)) ([4f58b28](https://github.com/teutonet/teutonet-helm-charts/commit/4f58b28e6bf60d82a58a3bc424c8e33e4ed44906))

## [6.6.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.6.1...base-cluster-v6.6.2) (2024-08-01)


### Bug Fixes

* **base-cluster/backup:** fix formatting ([#1063](https://github.com/teutonet/teutonet-helm-charts/issues/1063)) ([8da56f2](https://github.com/teutonet/teutonet-helm-charts/commit/8da56f2a20471540e1e33c63847de53626931db5))
* **base-cluster/kdave:** image 2.x.x is unsupported by the helm chart ([#1062](https://github.com/teutonet/teutonet-helm-charts/issues/1062)) ([e7bc047](https://github.com/teutonet/teutonet-helm-charts/commit/e7bc047d06bb1e3cadaf58a4948f76079f61d136))
* **base-cluster/kube-prometheus-stack:** set deployment strategy to r… ([#1067](https://github.com/teutonet/teutonet-helm-charts/issues/1067)) ([19854b7](https://github.com/teutonet/teutonet-helm-charts/commit/19854b7824c5e2b399d839ef9721ab3bf936e2f4))
* **base-cluster:** definitely enable everything for artifacthub ([#1064](https://github.com/teutonet/teutonet-helm-charts/issues/1064)) ([0157971](https://github.com/teutonet/teutonet-helm-charts/commit/01579717c84f97108b82f8fea7beb805a7982a7f))


### Miscellaneous Chores

* **base-cluster/dependencies:** update helm release velero to v7 ([#1023](https://github.com/teutonet/teutonet-helm-charts/issues/1023)) ([8b1f815](https://github.com/teutonet/teutonet-helm-charts/commit/8b1f8153baddca391ae133e2b75af847b7734741))

## [6.6.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.6.0...base-cluster-v6.6.1) (2024-07-31)


### Bug Fixes

* **base-cluster/velero:** remove dupplicated additionalLabels ([#1058](https://github.com/teutonet/teutonet-helm-charts/issues/1058)) ([82a2aa7](https://github.com/teutonet/teutonet-helm-charts/commit/82a2aa750371e7d1a74176167a6fce2526ec6e37))

## [6.6.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.5.1...base-cluster-v6.6.0) (2024-07-31)


### Features

* **base-cluster:** add kdave for deprecated CRD metrics ([#947](https://github.com/teutonet/teutonet-helm-charts/issues/947)) ([4609be4](https://github.com/teutonet/teutonet-helm-charts/commit/4609be4a4f7a315a7e419757a2b62c447759ab28))
* **base-cluster:** enable velero servicemonitor if prometheus is enabled ([#724](https://github.com/teutonet/teutonet-helm-charts/issues/724)) ([4482223](https://github.com/teutonet/teutonet-helm-charts/commit/44822234455e3a0cc59b6df580405643fbb4adaa)), closes [#487](https://github.com/teutonet/teutonet-helm-charts/issues/487)


### Bug Fixes

* **base-cluster/kube-janitor:** enable artifacthub-values and correctly prefix docker.io registry ([#1048](https://github.com/teutonet/teutonet-helm-charts/issues/1048)) ([17b9baf](https://github.com/teutonet/teutonet-helm-charts/commit/17b9baf00a49003abbc1ef4d2e91ba609e491418))


### Miscellaneous Chores

* **base-cluster:** use template instead of duplicated value ([#1050](https://github.com/teutonet/teutonet-helm-charts/issues/1050)) ([4ef2389](https://github.com/teutonet/teutonet-helm-charts/commit/4ef23899a073c3ed9f9d0867f626a60c028c3fcf))

## [6.5.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.5.0...base-cluster-v6.5.1) (2024-07-16)


### Bug Fixes

* **base-cluster/monitoring:** 🤦 ([#1026](https://github.com/teutonet/teutonet-helm-charts/issues/1026)) ([20f57c1](https://github.com/teutonet/teutonet-helm-charts/commit/20f57c1d0df7a4783a6fa335678737d41b02c19c))
* **base-cluster/monitoring:** don't configure route without receiver ([#1024](https://github.com/teutonet/teutonet-helm-charts/issues/1024)) ([fe3d87a](https://github.com/teutonet/teutonet-helm-charts/commit/fe3d87a583a7a320e18e80edd3354e4f3ba0d984))
* **base-cluster/monitoring:** slipped through review as well... ([#1033](https://github.com/teutonet/teutonet-helm-charts/issues/1033)) ([9a242a0](https://github.com/teutonet/teutonet-helm-charts/commit/9a242a073479a924146b5008d569d2c8dc1d6bbb))


### Miscellaneous Chores

* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.8.0 ([#1014](https://github.com/teutonet/teutonet-helm-charts/issues/1014)) ([b7fe8f8](https://github.com/teutonet/teutonet-helm-charts/commit/b7fe8f87006bfc131b9e9d37449c340c362b4aaf))
* **base-cluster/dependencies:** update helm release descheduler to 0.30.x ([#1015](https://github.com/teutonet/teutonet-helm-charts/issues/1015)) ([26a8e26](https://github.com/teutonet/teutonet-helm-charts/commit/26a8e26a37940143a7a019e147a119512e11f2a6))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v61 ([#1022](https://github.com/teutonet/teutonet-helm-charts/issues/1022)) ([49c905c](https://github.com/teutonet/teutonet-helm-charts/commit/49c905cc3af8254d30003d3d2bc7400dbea6ee0a))

## [6.5.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.4.0...base-cluster-v6.5.0) (2024-07-04)


### Features

* **base-cluster:** add kube-janitor ([#1011](https://github.com/teutonet/teutonet-helm-charts/issues/1011)) ([2f8a414](https://github.com/teutonet/teutonet-helm-charts/commit/2f8a4145ed6a22d412b1be43391e747518d5e99a))


### Bug Fixes

* **base-cluster/oidc:** this fixes the wrongly rolled out outh config ([#1000](https://github.com/teutonet/teutonet-helm-charts/issues/1000)) ([798a7c7](https://github.com/teutonet/teutonet-helm-charts/commit/798a7c77331bab25cb6cb9dce297a89cdaebf5c8))


### Miscellaneous Chores

* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.6 ([#960](https://github.com/teutonet/teutonet-helm-charts/issues/960)) ([e4919d6](https://github.com/teutonet/teutonet-helm-charts/commit/e4919d6b649336ca5e9244a55e60afb4059cf13d))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.3.0 ([#953](https://github.com/teutonet/teutonet-helm-charts/issues/953)) ([c650271](https://github.com/teutonet/teutonet-helm-charts/commit/c6502710639a8f52501942728f72542c93d254ff))
* **base-cluster/dependencies:** update helm release velero to v6.7.0 ([#954](https://github.com/teutonet/teutonet-helm-charts/issues/954)) ([84f7b52](https://github.com/teutonet/teutonet-helm-charts/commit/84f7b52b248316d505453a5530894e5ad8343018))
* **base-cluster:** mustMerge* is the safer option ([#1003](https://github.com/teutonet/teutonet-helm-charts/issues/1003)) ([4b49283](https://github.com/teutonet/teutonet-helm-charts/commit/4b4928317eadc4bee0c5a3eb646303dc36311e95))

## [6.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.3.0...base-cluster-v6.4.0) (2024-06-28)


### Features

* **base-cluster/grafana:** add persistence and configuration options ([#999](https://github.com/teutonet/teutonet-helm-charts/issues/999)) ([ce0fff7](https://github.com/teutonet/teutonet-helm-charts/commit/ce0fff742a4d3f880ccbf63ec6b41f6b615076cb))


### Miscellaneous Chores

* **base-cluster:** mustMerge* is the safer option ([#1001](https://github.com/teutonet/teutonet-helm-charts/issues/1001)) ([95a932b](https://github.com/teutonet/teutonet-helm-charts/commit/95a932b47a8b6149d591afce4342474205390a2c))

## [6.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.2.0...base-cluster-v6.3.0) (2024-06-19)


### Features

* **base-cluster/raise_api_version:** raise api version for helm.tool… ([#983](https://github.com/teutonet/teutonet-helm-charts/issues/983)) ([1439938](https://github.com/teutonet/teutonet-helm-charts/commit/143993801cafd568a97d8be07e78144feb529b97))


### Bug Fixes

* **base-cluster/kyverno:** change image registry for the test image ([#996](https://github.com/teutonet/teutonet-helm-charts/issues/996)) ([1b77a34](https://github.com/teutonet/teutonet-helm-charts/commit/1b77a34823f4a5582a8341d139cd6f32cd55a003))
* **base-cluster:** add missing seccompProfiles ([#988](https://github.com/teutonet/teutonet-helm-charts/issues/988)) ([18b59c6](https://github.com/teutonet/teutonet-helm-charts/commit/18b59c634787e7366747f1afa1c14df31ec8673c))
* **base-cluster:** kyverno image registries ([#987](https://github.com/teutonet/teutonet-helm-charts/issues/987)) ([a931a2e](https://github.com/teutonet/teutonet-helm-charts/commit/a931a2ecf525add514f58ca9b541ae71302f4e1b))
* **base-cluster:** wrong image for crds.migration ([#993](https://github.com/teutonet/teutonet-helm-charts/issues/993)) ([3c43f0f](https://github.com/teutonet/teutonet-helm-charts/commit/3c43f0fa6326475981334202f610c603794628e5))


### Miscellaneous Chores

* **base-cluster:** add missing resources for descheduler ([#989](https://github.com/teutonet/teutonet-helm-charts/issues/989)) ([39b3389](https://github.com/teutonet/teutonet-helm-charts/commit/39b33896326e3775dc037367a189de4998d7ee26))
* **base-cluster:** fix kyverno pdb version ([#990](https://github.com/teutonet/teutonet-helm-charts/issues/990)) ([fb08b9d](https://github.com/teutonet/teutonet-helm-charts/commit/fb08b9db13e0d761a04bb7005baa0fc5c80a59c6))

## [6.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.1.4...base-cluster-v6.2.0) (2024-06-13)


### Features

* **base-cluster:** allow creating git helmRepositories ([#946](https://github.com/teutonet/teutonet-helm-charts/issues/946)) ([e35415e](https://github.com/teutonet/teutonet-helm-charts/commit/e35415e48745a16a85144ebe20d7dd1c91cfe6f6))


### Bug Fixes

* **base-cluster:** fix nodeCollector is not scheduleable ([#974](https://github.com/teutonet/teutonet-helm-charts/issues/974)) ([c7df73b](https://github.com/teutonet/teutonet-helm-charts/commit/c7df73bad95cd0066442b3da94c969ab228c675f))
* **base-cluster:** set correct label for workinghours ([#980](https://github.com/teutonet/teutonet-helm-charts/issues/980)) ([06153d0](https://github.com/teutonet/teutonet-helm-charts/commit/06153d00cec263b6458ba03c0c24bdfadfbb30f5))

## [6.1.4](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.1.3...base-cluster-v6.1.4) (2024-04-25)


### Bug Fixes

* **base-cluster/flux:** kustomization path templating ([#900](https://github.com/teutonet/teutonet-helm-charts/issues/900)) ([151257f](https://github.com/teutonet/teutonet-helm-charts/commit/151257f84bdb9905cd0f0fcb78cc2e3cfd75cd9b))
* **base-cluster/flux:** kustomization path templating ([#901](https://github.com/teutonet/teutonet-helm-charts/issues/901)) ([6c5d844](https://github.com/teutonet/teutonet-helm-charts/commit/6c5d8444302815ae86de8611b4e15904ba02ddfa))

## [6.1.3](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.1.2...base-cluster-v6.1.3) (2024-04-25)


### Bug Fixes

* **base-cluster/kyverno+flux:** remove old policy they don't exist upstream anymore as well ([#898](https://github.com/teutonet/teutonet-helm-charts/issues/898)) ([ab5055e](https://github.com/teutonet/teutonet-helm-charts/commit/ab5055e89cb71e9563a4944bcd216397f08665fc))

## [6.1.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.1.1...base-cluster-v6.1.2) (2024-04-24)


### Bug Fixes

* **base-cluster/flux:** set fixed values for gpg key creation as defa… ([#894](https://github.com/teutonet/teutonet-helm-charts/issues/894)) ([f0afff3](https://github.com/teutonet/teutonet-helm-charts/commit/f0afff3acd06e320080300dea8f093b2195e766f))

## [6.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.1.0...base-cluster-v6.1.1) (2024-04-22)


### Bug Fixes

* **base-cluster/flux:** kustomization path templating ([#890](https://github.com/teutonet/teutonet-helm-charts/issues/890)) ([7e67787](https://github.com/teutonet/teutonet-helm-charts/commit/7e677871a251686174e6802d25a86a53a50a2291))

## [6.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v6.0.0...base-cluster-v6.1.0) (2024-04-22)


### Features

* **base-cluster/descheduler:** run as deployment and enable prometheus ([#838](https://github.com/teutonet/teutonet-helm-charts/issues/838)) ([47b7cdf](https://github.com/teutonet/teutonet-helm-charts/commit/47b7cdf5e2453d7b243a701cc20354574cbc23f7))
* **base-cluster/flux:** add option to add a path inside the kustomiz… ([#876](https://github.com/teutonet/teutonet-helm-charts/issues/876)) ([358b9e2](https://github.com/teutonet/teutonet-helm-charts/commit/358b9e26bdcd525debac397f5c3aafa0a0c274ba))
* **base-cluster/monitoring:** use different setup for tls for oauth-… ([#852](https://github.com/teutonet/teutonet-helm-charts/issues/852)) ([cc2e6a9](https://github.com/teutonet/teutonet-helm-charts/commit/cc2e6a90f2b7f89eb7702a6807894c4c56aca98c))
* **base-cluster/tracing:** add resources settings for ingester ([#832](https://github.com/teutonet/teutonet-helm-charts/issues/832)) ([eb211e5](https://github.com/teutonet/teutonet-helm-charts/commit/eb211e53ece17d917fe22bc763e3d6fbcfe89c13))
* **base-cluster:** overhaul resources ([#835](https://github.com/teutonet/teutonet-helm-charts/issues/835)) ([f39dba8](https://github.com/teutonet/teutonet-helm-charts/commit/f39dba8cc3f9de055216d6b0f676b5c3e328b657))


### Bug Fixes

* **base-cluster/monitoring:** overwritten wildcard certificates ([#868](https://github.com/teutonet/teutonet-helm-charts/issues/868)) ([26cf112](https://github.com/teutonet/teutonet-helm-charts/commit/26cf11221a5998e2c0d9440fc80ab9418ba97913))
* **base-cluster/tracing:** remove undefined exporter ([#845](https://github.com/teutonet/teutonet-helm-charts/issues/845)) ([f514b24](https://github.com/teutonet/teutonet-helm-charts/commit/f514b241dab81341daf2d25d8420f30e88cc4449))
* **ci:** better handling of generated values ([#875](https://github.com/teutonet/teutonet-helm-charts/issues/875)) ([f1300f8](https://github.com/teutonet/teutonet-helm-charts/commit/f1300f87a1f5215b490d1cc531c1341a4f39c304))


### Miscellaneous Chores

* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.4 ([#871](https://github.com/teutonet/teutonet-helm-charts/issues/871)) ([95d8c22](https://github.com/teutonet/teutonet-helm-charts/commit/95d8c227964e2afe2fd59716e42207053db0718d))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.7.1 ([#842](https://github.com/teutonet/teutonet-helm-charts/issues/842)) ([d36d4f9](https://github.com/teutonet/teutonet-helm-charts/commit/d36d4f95de8cf71e61ebb73403edcff7ccfb2911))
* **base-cluster/dependencies:** update helm release common to v2.19.1 ([#839](https://github.com/teutonet/teutonet-helm-charts/issues/839)) ([eb07e18](https://github.com/teutonet/teutonet-helm-charts/commit/eb07e1872f0ea22a317341020776e4c2b510c53c))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v58 ([#851](https://github.com/teutonet/teutonet-helm-charts/issues/851)) ([6e79448](https://github.com/teutonet/teutonet-helm-charts/commit/6e794482caa26ba69a60edb55d9c9093d6f95ce7))
* **base-cluster/dependencies:** update oauth2-proxy docker tag to v5 ([#849](https://github.com/teutonet/teutonet-helm-charts/issues/849)) ([fa4c495](https://github.com/teutonet/teutonet-helm-charts/commit/fa4c4956b9981fb32c532f8838a9793861373c26))
* **base-cluster/monitoring:** remove unnecessary arg ([#829](https://github.com/teutonet/teutonet-helm-charts/issues/829)) ([f9cdd7d](https://github.com/teutonet/teutonet-helm-charts/commit/f9cdd7def3645b275b08235f7213065febdc612c))
* **base-cluster:** use tag instead of digest for gpg image ([#844](https://github.com/teutonet/teutonet-helm-charts/issues/844)) ([13be21b](https://github.com/teutonet/teutonet-helm-charts/commit/13be21b475aff338565363df61554290041b9a59))
* **base-cluster:** use teutonet common chart ([#857](https://github.com/teutonet/teutonet-helm-charts/issues/857)) ([a35b63c](https://github.com/teutonet/teutonet-helm-charts/commit/a35b63c0199ad1f2521706ceaacd832fe5261a70))

## [6.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v5.0.1...base-cluster-v6.0.0) (2024-03-25)


### ⚠ BREAKING CHANGES

* **base-cluster/kyverno:** upgrade 🤮 ([#784](https://github.com/teutonet/teutonet-helm-charts/issues/784))

### Features

* add helmrelease schemas 😍 ([#792](https://github.com/teutonet/teutonet-helm-charts/issues/792)) ([89ed7eb](https://github.com/teutonet/teutonet-helm-charts/commit/89ed7eb540c647cb3e15b590d20a6a83331a61b7))
* **base-cluster:** enable cilium dns proxy ([#825](https://github.com/teutonet/teutonet-helm-charts/issues/825)) ([73c97fa](https://github.com/teutonet/teutonet-helm-charts/commit/73c97faf8376a0c94b00d1651b351a116e521faf))
* **base-cluster:** upgrade all HRs and enable driftDetection ([#773](https://github.com/teutonet/teutonet-helm-charts/issues/773)) ([fe6e71a](https://github.com/teutonet/teutonet-helm-charts/commit/fe6e71a0600192705e4c68da7bafd0df6448b17c))


### Bug Fixes

* **base-cluster-schema/schema:** remove required for serviceLevelAgre… ([#791](https://github.com/teutonet/teutonet-helm-charts/issues/791)) ([d9917b5](https://github.com/teutonet/teutonet-helm-charts/commit/d9917b5d52659fa2d10938bd830a1355f681a2e6))
* **base-cluster/grafana:** oidc secret handling ([#756](https://github.com/teutonet/teutonet-helm-charts/issues/756)) ([73a15d2](https://github.com/teutonet/teutonet-helm-charts/commit/73a15d28b4158f4668305c9b076b535dc70565e0))
* **base-cluster/kyverno:** configure missing registry for kyverno images ([#811](https://github.com/teutonet/teutonet-helm-charts/issues/811)) ([83c44f5](https://github.com/teutonet/teutonet-helm-charts/commit/83c44f54ece474d2044b87fa0d92246379cd8a80))
* **base-cluster/metrics-server:** remove mount, as it's fixed via chart ([#818](https://github.com/teutonet/teutonet-helm-charts/issues/818)) ([b8cbe36](https://github.com/teutonet/teutonet-helm-charts/commit/b8cbe365c99bc315d499c6f1bfe44a84bf22133e))
* **base-cluster/monitoring:** missing UIDs and cross-connections ([#824](https://github.com/teutonet/teutonet-helm-charts/issues/824)) ([39b19d2](https://github.com/teutonet/teutonet-helm-charts/commit/39b19d210e82b385e8e5c2119896e5f28259329d))
* **base-cluster/oauth-proxy:** use correct secretName for certificate ([#758](https://github.com/teutonet/teutonet-helm-charts/issues/758)) ([eda417c](https://github.com/teutonet/teutonet-helm-charts/commit/eda417c7036d49acd1f6db4c66cb11ed8c3cf45a))
* helmrelease-schemas ([#794](https://github.com/teutonet/teutonet-helm-charts/issues/794)) ([6544385](https://github.com/teutonet/teutonet-helm-charts/commit/65443857c75d07b245c14e05d1fae76f0c0de479))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#786](https://github.com/teutonet/teutonet-helm-charts/issues/786)) ([c9e14e4](https://github.com/teutonet/teutonet-helm-charts/commit/c9e14e4d2edee3547a237d16d1a2c0d97c9c384c))
* **base-cluster/backup:** pin velero, as they don't follow semver ([#781](https://github.com/teutonet/teutonet-helm-charts/issues/781)) ([a87c79e](https://github.com/teutonet/teutonet-helm-charts/commit/a87c79e4d4ab74b589880f387714e306c3c05bc2))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.3 ([#788](https://github.com/teutonet/teutonet-helm-charts/issues/788)) ([622ddd3](https://github.com/teutonet/teutonet-helm-charts/commit/622ddd356e419a658ee924741d1b601e6c11b25e))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.6.0 ([#753](https://github.com/teutonet/teutonet-helm-charts/issues/753)) ([ae31961](https://github.com/teutonet/teutonet-helm-charts/commit/ae31961abf6bb619489b8ef6617b1983ecf2dae1))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.2.3 ([#764](https://github.com/teutonet/teutonet-helm-charts/issues/764)) ([cf45276](https://github.com/teutonet/teutonet-helm-charts/commit/cf45276178409998800552d07ec546302e0869e0))
* **base-cluster/dependencies:** update external-dns docker tag to v7 ([#827](https://github.com/teutonet/teutonet-helm-charts/issues/827)) ([1ea1bf9](https://github.com/teutonet/teutonet-helm-charts/commit/1ea1bf9d2bc90f73a5c49f1ea65dbeac8a5bdf5c))
* **base-cluster/dependencies:** update grafana-tempo docker tag to v3 ([#828](https://github.com/teutonet/teutonet-helm-charts/issues/828)) ([7c0f9ba](https://github.com/teutonet/teutonet-helm-charts/commit/7c0f9bab316b71991e589155576bcfc3ff33d7e8))
* **base-cluster/dependencies:** update helm release common to v2.16.1 ([#782](https://github.com/teutonet/teutonet-helm-charts/issues/782)) ([e6568d0](https://github.com/teutonet/teutonet-helm-charts/commit/e6568d00ca52f09e904ff4016fd812a039667fd8))
* **base-cluster/dependencies:** update helm release common to v2.19.0 ([#814](https://github.com/teutonet/teutonet-helm-charts/issues/814)) ([5419c5c](https://github.com/teutonet/teutonet-helm-charts/commit/5419c5c1a6f5af28df6cedd8857430b3c55cf622))
* **base-cluster/dependencies:** update helm release descheduler to 0.29.x ([#704](https://github.com/teutonet/teutonet-helm-charts/issues/704)) ([61264cb](https://github.com/teutonet/teutonet-helm-charts/commit/61264cbcdb76ff10fbe422d70dc2bebf4cf00ee7))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v57 ([#820](https://github.com/teutonet/teutonet-helm-charts/issues/820)) ([2e64dbe](https://github.com/teutonet/teutonet-helm-charts/commit/2e64dbeca3d846e175ec1e9f4430202ea62cdafc))
* **base-cluster/dependencies:** update helm release velero to v5.4.1 ([#798](https://github.com/teutonet/teutonet-helm-charts/issues/798)) ([ab8a741](https://github.com/teutonet/teutonet-helm-charts/commit/ab8a741c7a2349c04d58a3fd26d5345ccab98fe0))
* **base-cluster/dependencies:** update helm release velero to v6 ([#812](https://github.com/teutonet/teutonet-helm-charts/issues/812)) ([b09985e](https://github.com/teutonet/teutonet-helm-charts/commit/b09985e7288c7f688429517d71da2270c87ec499))
* **base-cluster/dependencies:** update metrics-server docker tag to v7 ([#821](https://github.com/teutonet/teutonet-helm-charts/issues/821)) ([3ca7dbc](https://github.com/teutonet/teutonet-helm-charts/commit/3ca7dbc6cdc9477d5ac0127ff00c0c3d4369db52))
* **base-cluster/kyverno:** upgrade 🤮 ([#784](https://github.com/teutonet/teutonet-helm-charts/issues/784)) ([1c62356](https://github.com/teutonet/teutonet-helm-charts/commit/1c623567d495a79dd975a1f7807bcaf70a51d11d))
* **base-cluster:** streamline imagePullPolicy ([#757](https://github.com/teutonet/teutonet-helm-charts/issues/757)) ([61f1c7f](https://github.com/teutonet/teutonet-helm-charts/commit/61f1c7fcbcf713e6d9660dc6d9497733d9e9b93e))

## [5.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v5.0.0...base-cluster-v5.0.1) (2024-02-12)


### Bug Fixes

* **base-cluster/backup:** add defaultBackupStorageLocation flag for velero 🙄 ([#779](https://github.com/teutonet/teutonet-helm-charts/issues/779)) ([d0e9ff9](https://github.com/teutonet/teutonet-helm-charts/commit/d0e9ff973aec296c550c0e34f009459345e82d32))

## [5.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.12.0...base-cluster-v5.0.0) (2024-02-10)


### ⚠ BREAKING CHANGES

* **base-cluster/backup:** only enable velero if a backupstoragelocation is set ([#763](https://github.com/teutonet/teutonet-helm-charts/issues/763))

### Features

* **base-cluster/grafana:** add dashboards for namespace monitoring ([#712](https://github.com/teutonet/teutonet-helm-charts/issues/712)) ([1651273](https://github.com/teutonet/teutonet-helm-charts/commit/165127347418973f17f5fa8ce6215c38dd067de5))
* **base-cluster/limitrange-quotas:** add limitrange and resource quota ([#673](https://github.com/teutonet/teutonet-helm-charts/issues/673)) ([f0ac4c2](https://github.com/teutonet/teutonet-helm-charts/commit/f0ac4c2a0079f0cd7350bc613781a62222a2df1d))


### Bug Fixes

* **base-cluster/backup:** only enable velero if a backupstoragelocation is set ([#763](https://github.com/teutonet/teutonet-helm-charts/issues/763)) ([4dfec43](https://github.com/teutonet/teutonet-helm-charts/commit/4dfec438883114c3f97b177013a238df54e1a100)), closes [#752](https://github.com/teutonet/teutonet-helm-charts/issues/752)
* **base-cluster/cert-manager:** set higher resource quota for cert-ma… ([#742](https://github.com/teutonet/teutonet-helm-charts/issues/742)) ([53a51bb](https://github.com/teutonet/teutonet-helm-charts/commit/53a51bbee0e589e25b40a616e613c699d8a7a094))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#720](https://github.com/teutonet/teutonet-helm-charts/issues/720)) ([e77941e](https://github.com/teutonet/teutonet-helm-charts/commit/e77941e49a04dcac1ddc56270027fcb2679249e2))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#735](https://github.com/teutonet/teutonet-helm-charts/issues/735)) ([45842f3](https://github.com/teutonet/teutonet-helm-charts/commit/45842f34fd78b650a24607e6f72befa4ccbc4025))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#738](https://github.com/teutonet/teutonet-helm-charts/issues/738)) ([c83ff3e](https://github.com/teutonet/teutonet-helm-charts/commit/c83ff3e0ab16038dbd2e7b8b64e70a5d596d534f))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#744](https://github.com/teutonet/teutonet-helm-charts/issues/744)) ([b8d4d2f](https://github.com/teutonet/teutonet-helm-charts/commit/b8d4d2fb34708b8eb504178625f57b9888c219fe))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#746](https://github.com/teutonet/teutonet-helm-charts/issues/746)) ([3da1a81](https://github.com/teutonet/teutonet-helm-charts/commit/3da1a8114255d5ef665f45d6314609d800a33bc7))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#747](https://github.com/teutonet/teutonet-helm-charts/issues/747)) ([72978e3](https://github.com/teutonet/teutonet-helm-charts/commit/72978e3ef9ae046a8dafeca4cb894e2c31abc998))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#748](https://github.com/teutonet/teutonet-helm-charts/issues/748)) ([92b09a1](https://github.com/teutonet/teutonet-helm-charts/commit/92b09a1596359ad4d15f486895895ceea91afe48))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#749](https://github.com/teutonet/teutonet-helm-charts/issues/749)) ([b53bd86](https://github.com/teutonet/teutonet-helm-charts/commit/b53bd863fb74c5a1ba09495ce65b1ea96189796d))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#750](https://github.com/teutonet/teutonet-helm-charts/issues/750)) ([feb6630](https://github.com/teutonet/teutonet-helm-charts/commit/feb66304bbfdf0b39fbdd30c23591bef45f60c3e))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#760](https://github.com/teutonet/teutonet-helm-charts/issues/760)) ([4b0dac4](https://github.com/teutonet/teutonet-helm-charts/commit/4b0dac422de200597542a7fb0d072af82f4159ca))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#761](https://github.com/teutonet/teutonet-helm-charts/issues/761)) ([6515b38](https://github.com/teutonet/teutonet-helm-charts/commit/6515b38decbea55fcd958dc70854096bd022731a))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#762](https://github.com/teutonet/teutonet-helm-charts/issues/762)) ([dd58442](https://github.com/teutonet/teutonet-helm-charts/commit/dd58442fa214b9b00e4701c3a39d0fb725109e38))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#765](https://github.com/teutonet/teutonet-helm-charts/issues/765)) ([cf7f587](https://github.com/teutonet/teutonet-helm-charts/commit/cf7f587ea403b0135ebe7ebe09076149c1c4cb0f))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#775](https://github.com/teutonet/teutonet-helm-charts/issues/775)) ([5837439](https://github.com/teutonet/teutonet-helm-charts/commit/58374390f9ae724b33f216776386a22b3a1737be))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#776](https://github.com/teutonet/teutonet-helm-charts/issues/776)) ([5c04406](https://github.com/teutonet/teutonet-helm-charts/commit/5c04406da62a04b2637cce9b859c0bfd74fb9255))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.1 ([#726](https://github.com/teutonet/teutonet-helm-charts/issues/726)) ([11fa033](https://github.com/teutonet/teutonet-helm-charts/commit/11fa0335f0a13144fd7297e393cd3934a8cfbf24))
* **base-cluster/dependencies:** update helm release common to v2.14.1 ([#692](https://github.com/teutonet/teutonet-helm-charts/issues/692)) ([c570d70](https://github.com/teutonet/teutonet-helm-charts/commit/c570d70ad5c7dac8e4a5e816838b285e2d75ab2d))

## [4.12.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.11.0...base-cluster-v4.12.0) (2024-01-15)


### Features

* **base-cluster/monitoring:** add pagerduty alertmanager receiver ([#653](https://github.com/teutonet/teutonet-helm-charts/issues/653)) ([fba2f36](https://github.com/teutonet/teutonet-helm-charts/commit/fba2f36fb314444a8b030bf5181cfc4e107bb636))


### Bug Fixes

* **base-cluster/cert-manager:** debounce certificate-expiration alert ([#668](https://github.com/teutonet/teutonet-helm-charts/issues/668)) ([1e9777a](https://github.com/teutonet/teutonet-helm-charts/commit/1e9777aa4af6ef508f1feb2e53496fc500880992))
* **base-cluster/grafana:** quote roleAttributePath ([#716](https://github.com/teutonet/teutonet-helm-charts/issues/716)) ([eb336e6](https://github.com/teutonet/teutonet-helm-charts/commit/eb336e62c3d29a9cf48e47475aa497e879c5dfbd))
* **base-cluster/helmrepositories:** add missing nginx condition ([#669](https://github.com/teutonet/teutonet-helm-charts/issues/669)) ([ba7d4dd](https://github.com/teutonet/teutonet-helm-charts/commit/ba7d4ddc3f5f9836698acadcaf05fabf5061cadf))
* **base-cluster/monitoring:** correctly quote grafana roleAttributePath ([#671](https://github.com/teutonet/teutonet-helm-charts/issues/671)) ([95ae50b](https://github.com/teutonet/teutonet-helm-charts/commit/95ae50b8a1ad94a910a5e2a7078410a5be5c0e01))
* **base-cluster/monitoring:** don't use bitnamis "strong" password ([#685](https://github.com/teutonet/teutonet-helm-charts/issues/685)) ([5627d24](https://github.com/teutonet/teutonet-helm-charts/commit/5627d245db69297676f97b30ee32cd77403bea6d))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#658](https://github.com/teutonet/teutonet-helm-charts/issues/658)) ([58f899e](https://github.com/teutonet/teutonet-helm-charts/commit/58f899e216a30c764e40b94c8f65db565f67cd4c))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#664](https://github.com/teutonet/teutonet-helm-charts/issues/664)) ([8c58a89](https://github.com/teutonet/teutonet-helm-charts/commit/8c58a892549791cc1abd5a45c1e5d99b049c2447))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#670](https://github.com/teutonet/teutonet-helm-charts/issues/670)) ([afd3590](https://github.com/teutonet/teutonet-helm-charts/commit/afd3590220ce6a2a3ec1641bd3fc5ec70bdcfe1b))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#672](https://github.com/teutonet/teutonet-helm-charts/issues/672)) ([99d63b6](https://github.com/teutonet/teutonet-helm-charts/commit/99d63b679612b6cf4289bacbd97470c7f4efff6e))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#674](https://github.com/teutonet/teutonet-helm-charts/issues/674)) ([9f81339](https://github.com/teutonet/teutonet-helm-charts/commit/9f81339525773b260ef7509631bd813dc7a28f15))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#695](https://github.com/teutonet/teutonet-helm-charts/issues/695)) ([c5ccc48](https://github.com/teutonet/teutonet-helm-charts/commit/c5ccc48b8dae5cff2347ad9ac445048c472f90b7))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#696](https://github.com/teutonet/teutonet-helm-charts/issues/696)) ([9921ed4](https://github.com/teutonet/teutonet-helm-charts/commit/9921ed4dbc59be7529b1daded30f9b8795b358a1))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#703](https://github.com/teutonet/teutonet-helm-charts/issues/703)) ([679406b](https://github.com/teutonet/teutonet-helm-charts/commit/679406b42e7f87f092c0f361a791bc5fcdc4e4a3))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#708](https://github.com/teutonet/teutonet-helm-charts/issues/708)) ([6103683](https://github.com/teutonet/teutonet-helm-charts/commit/61036832b5f1a5e25b14840a08528300b768bf09))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#709](https://github.com/teutonet/teutonet-helm-charts/issues/709)) ([b89a529](https://github.com/teutonet/teutonet-helm-charts/commit/b89a52948664abd67d2ec340caa908ec80bccf96))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#710](https://github.com/teutonet/teutonet-helm-charts/issues/710)) ([f661166](https://github.com/teutonet/teutonet-helm-charts/commit/f661166a9b9f79cc57b6ffb22e7b7e27a86040ce))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.0 ([#701](https://github.com/teutonet/teutonet-helm-charts/issues/701)) ([d0ee006](https://github.com/teutonet/teutonet-helm-charts/commit/d0ee006a1c8c1144fb7c4191eb6e6a1a55a8eded))
* **base-cluster/dependencies:** update docker.io/curlimages/curl docker tag to v8.5.0 ([#702](https://github.com/teutonet/teutonet-helm-charts/issues/702)) ([a6f1a6f](https://github.com/teutonet/teutonet-helm-charts/commit/a6f1a6f62d7ef4afe7ecaa9ebcae0e6e666765ff))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.2.2 ([#677](https://github.com/teutonet/teutonet-helm-charts/issues/677)) ([415a6ca](https://github.com/teutonet/teutonet-helm-charts/commit/415a6ca9d788aac0fcc81bdcbb5f1aadfe3772e9))
* **base-cluster/dependencies:** update helm release common to v2.13.4 ([#682](https://github.com/teutonet/teutonet-helm-charts/issues/682)) ([2859413](https://github.com/teutonet/teutonet-helm-charts/commit/28594138d7a1f6730e851f9f5c0edc51babbd1e3))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v55 ([#657](https://github.com/teutonet/teutonet-helm-charts/issues/657)) ([8e0bf61](https://github.com/teutonet/teutonet-helm-charts/commit/8e0bf6143dc4e77e416968ae238b9e308fe0141e))

## [4.11.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.10.0...base-cluster-v4.11.0) (2023-11-23)


### Features

* **base-cluster/monitoring:** allow admin login even with oidc ([#645](https://github.com/teutonet/teutonet-helm-charts/issues/645)) ([c4b8b89](https://github.com/teutonet/teutonet-helm-charts/commit/c4b8b8924ed455637f1d2a3dc1a59c4a33ee0edb))


### Bug Fixes

* **base-cluster/ingress:** fix templating when no baseDomain is set ([#647](https://github.com/teutonet/teutonet-helm-charts/issues/647)) ([46dae44](https://github.com/teutonet/teutonet-helm-charts/commit/46dae449bd66c4f4a9d66c21b982fa258a71d232))
* **base-cluster:** notes formatting ([#644](https://github.com/teutonet/teutonet-helm-charts/issues/644)) ([c23ca9c](https://github.com/teutonet/teutonet-helm-charts/commit/c23ca9c70f039b5af48256e368bf1fa8c90d1628))

## [4.10.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.9.1...base-cluster-v4.10.0) (2023-11-23)


### Features

* **base-cluster/monitoring:** improve strength of generated grafana adminPassword ([#640](https://github.com/teutonet/teutonet-helm-charts/issues/640)) ([c605812](https://github.com/teutonet/teutonet-helm-charts/commit/c6058127e9a8732f3025277ae9a108c6ebc63b03))
* **base-cluster/monitoring:** monitor all namespaces by default ([#545](https://github.com/teutonet/teutonet-helm-charts/issues/545)) ([fd8168b](https://github.com/teutonet/teutonet-helm-charts/commit/fd8168b88d8c4d575fcb66efc270f0f895eacef7))
* **base-cluster/monitoring:** oidc authentication ([#623](https://github.com/teutonet/teutonet-helm-charts/issues/623)) ([1ae3499](https://github.com/teutonet/teutonet-helm-charts/commit/1ae3499f70afd2c92d0c8e6b1ccfddbe86ae6caa))


### Bug Fixes

* **base-cluster/kyverno:** fix excluded namespaces ([#608](https://github.com/teutonet/teutonet-helm-charts/issues/608)) ([5a6a6ea](https://github.com/teutonet/teutonet-helm-charts/commit/5a6a6ea1039cd95d7e07c5d400289d6d504cc056))
* **base-cluster/monitoring:** cert-manager is always deployed, so should its dashboard ([#642](https://github.com/teutonet/teutonet-helm-charts/issues/642)) ([ae7fee2](https://github.com/teutonet/teutonet-helm-charts/commit/ae7fee25ba552da183b3adff646f5a7c59185f9f))


### Miscellaneous Chores

* **base-cluster/dependencies:** improve conditions ([#632](https://github.com/teutonet/teutonet-helm-charts/issues/632)) ([5b23701](https://github.com/teutonet/teutonet-helm-charts/commit/5b2370154f4e8e0e12d1417b7e9e2c226ac51bb8))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.28.2 ([#589](https://github.com/teutonet/teutonet-helm-charts/issues/589)) ([bb7edba](https://github.com/teutonet/teutonet-helm-charts/commit/bb7edba302539f410689d26dea2796dad433740e))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.28.4 ([#628](https://github.com/teutonet/teutonet-helm-charts/issues/628)) ([729772e](https://github.com/teutonet/teutonet-helm-charts/commit/729772ec48c33321a96a90ee500543e7b39892a2))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2.1.2 ([#586](https://github.com/teutonet/teutonet-helm-charts/issues/586)) ([80531f3](https://github.com/teutonet/teutonet-helm-charts/commit/80531f3e342bbb3f7b12d84abb3983a7d6ab5c81))
* **base-cluster/dependencies:** update helm release common to v2.13.3 ([#613](https://github.com/teutonet/teutonet-helm-charts/issues/613)) ([8ec0f38](https://github.com/teutonet/teutonet-helm-charts/commit/8ec0f38a4d926f3b3adaa19013de0dcc9a76e25c))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v54 ([#631](https://github.com/teutonet/teutonet-helm-charts/issues/631)) ([14a7d58](https://github.com/teutonet/teutonet-helm-charts/commit/14a7d58dba4c1ce372955f80b109b1a007a989bf))

## [4.9.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.9.0...base-cluster-v4.9.1) (2023-10-06)


### Bug Fixes

* **base-cluster/ingress-nginx:** use correct field ([#601](https://github.com/teutonet/teutonet-helm-charts/issues/601)) ([4c8c1f4](https://github.com/teutonet/teutonet-helm-charts/commit/4c8c1f48c39f46e9f23710598a2f5a8823d2dddd))

## [4.9.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.8.0...base-cluster-v4.9.0) (2023-10-06)


### Features

* **base-cluster/nginx:** add possibility to disable ingress ([#489](https://github.com/teutonet/teutonet-helm-charts/issues/489)) ([c5d822a](https://github.com/teutonet/teutonet-helm-charts/commit/c5d822a4c030a10b7acb76c0abe79c6ac6392fc5))
* **base-cluster/nginx:** add toggle for snippets ([#599](https://github.com/teutonet/teutonet-helm-charts/issues/599)) ([be13b6a](https://github.com/teutonet/teutonet-helm-charts/commit/be13b6aa084effab44cf9af7cc0b0549315a8bf4))

## [4.8.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.7.0...base-cluster-v4.8.0) (2023-09-20)


### Features

* **base-cluster/flux:** change ssh algorithm to ed25519 ([#582](https://github.com/teutonet/teutonet-helm-charts/issues/582)) ([5dfa01f](https://github.com/teutonet/teutonet-helm-charts/commit/5dfa01fd730eb8409262e76eb01f2c38216ac095))
* **base-cluster/ingress:** enable tracing for nginx ([#578](https://github.com/teutonet/teutonet-helm-charts/issues/578)) ([b7aabcb](https://github.com/teutonet/teutonet-helm-charts/commit/b7aabcbb4f81dd86558a4f84da322f68bd39ab40))
* **base-cluster:** add priorityClassName to critical applications ([#535](https://github.com/teutonet/teutonet-helm-charts/issues/535)) ([abcce53](https://github.com/teutonet/teutonet-helm-charts/commit/abcce53156f21ee14baad214572964631838ecb4))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#580](https://github.com/teutonet/teutonet-helm-charts/issues/580)) ([a8932e8](https://github.com/teutonet/teutonet-helm-charts/commit/a8932e888401e6aaa9ff8aa4c4ff1ce08071483a))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.27.6 ([#576](https://github.com/teutonet/teutonet-helm-charts/issues/576)) ([94dfe6b](https://github.com/teutonet/teutonet-helm-charts/commit/94dfe6b38f95882b4c65064d7205e6da7ced7710))
* **base-cluster/dependencies:** update docker.io/fluxcd/flux-cli docker tag to v2 ([#521](https://github.com/teutonet/teutonet-helm-charts/issues/521)) ([2cdc7f0](https://github.com/teutonet/teutonet-helm-charts/commit/2cdc7f07b3084a525233064119e00c76c51c44ce))

## [4.7.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.6.0...base-cluster-v4.7.0) (2023-09-13)


### Features

* **base-cluster/tracing:** add OpenTelemetry Collector and Grafana Tempo ([#439](https://github.com/teutonet/teutonet-helm-charts/issues/439)) ([8176833](https://github.com/teutonet/teutonet-helm-charts/commit/8176833388c7db9035244b6cde382ce3086be98f))
* **base-cluster/tracing:** enable tracing for prometheus ([#556](https://github.com/teutonet/teutonet-helm-charts/issues/556)) ([57bd136](https://github.com/teutonet/teutonet-helm-charts/commit/57bd13699f1883394d7203943a798998e0c77400))
* **base-cluster/tracing:** simplify tracingConfig ([#557](https://github.com/teutonet/teutonet-helm-charts/issues/557)) ([5645d12](https://github.com/teutonet/teutonet-helm-charts/commit/5645d12b2c04134e3fb65fb8aa933ea16b6af59c))
* **base-cluster:** remove unused helmrepositories ([#546](https://github.com/teutonet/teutonet-helm-charts/issues/546)) ([b2ae1e6](https://github.com/teutonet/teutonet-helm-charts/commit/b2ae1e63ff185fd1d86a429c9b43189214ffa55d))


### Bug Fixes

* **base-cluster/tracing:** add missing otel to trusted image ([#552](https://github.com/teutonet/teutonet-helm-charts/issues/552)) ([5332ca8](https://github.com/teutonet/teutonet-helm-charts/commit/5332ca88fc2a1208b2493a7dad3c746a31936085))
* **base-cluster/tracing:** apparently tempo changed their service name ([#555](https://github.com/teutonet/teutonet-helm-charts/issues/555)) ([a3b1cf0](https://github.com/teutonet/teutonet-helm-charts/commit/a3b1cf02b0f80f3ba2f1306fc3da174dfc2e006b))
* **base-cluster/tracing:** grafana tempo labels indentation ([#553](https://github.com/teutonet/teutonet-helm-charts/issues/553)) ([79a239b](https://github.com/teutonet/teutonet-helm-charts/commit/79a239b927c459de03bac4b13043aead7d518dc1))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#528](https://github.com/teutonet/teutonet-helm-charts/issues/528)) ([f50f801](https://github.com/teutonet/teutonet-helm-charts/commit/f50f8016b5fffbea2a2f5ea4249644ede974defa))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#531](https://github.com/teutonet/teutonet-helm-charts/issues/531)) ([f9e3ea5](https://github.com/teutonet/teutonet-helm-charts/commit/f9e3ea53adfa8b14148376d42b501c253c0f2efe))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#566](https://github.com/teutonet/teutonet-helm-charts/issues/566)) ([7b6dda9](https://github.com/teutonet/teutonet-helm-charts/commit/7b6dda91d0a7147ba267191c392d1ddb855bae89))
* **base-cluster/backup:** migrate velero to 5.x ([#529](https://github.com/teutonet/teutonet-helm-charts/issues/529)) ([10759bf](https://github.com/teutonet/teutonet-helm-charts/commit/10759bfce72c57ad506f651e8dc4ef57e890162f))
* **base-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.27.5 ([#533](https://github.com/teutonet/teutonet-helm-charts/issues/533)) ([37966aa](https://github.com/teutonet/teutonet-helm-charts/commit/37966aaf5d4cf3699223c151e11c5e54926a3513))
* **base-cluster/dependencies:** update helm release common to v2.10.1 ([#561](https://github.com/teutonet/teutonet-helm-charts/issues/561)) ([b82c790](https://github.com/teutonet/teutonet-helm-charts/commit/b82c790a59b2c134d371df3c7b5bccc555e5dfb5))
* **base-cluster/dependencies:** update helm release common to v2.11.0 ([#568](https://github.com/teutonet/teutonet-helm-charts/issues/568)) ([3edd2b3](https://github.com/teutonet/teutonet-helm-charts/commit/3edd2b389c52d17624d494f618b5e55af6a24c3c))
* **base-cluster/dependencies:** update helm release common to v2.9.0 ([#512](https://github.com/teutonet/teutonet-helm-charts/issues/512)) ([4162755](https://github.com/teutonet/teutonet-helm-charts/commit/41627550e0e347f67829c9b73ef225469841ac33))
* **base-cluster/dependencies:** update helm release common to v2.9.1 ([#534](https://github.com/teutonet/teutonet-helm-charts/issues/534)) ([a8f5cfc](https://github.com/teutonet/teutonet-helm-charts/commit/a8f5cfc83351676e10abff3342d711abc38cc9fa))
* **base-cluster/dependencies:** update helm release common to v2.9.2 ([#547](https://github.com/teutonet/teutonet-helm-charts/issues/547)) ([e795117](https://github.com/teutonet/teutonet-helm-charts/commit/e795117e49796928d6b5eaf7fa36b5ef0643195a))
* **base-cluster/dependencies:** update helm release descheduler to 0.28.x ([#538](https://github.com/teutonet/teutonet-helm-charts/issues/538)) ([3f927b9](https://github.com/teutonet/teutonet-helm-charts/commit/3f927b9c0522b6b4136313aa2f2fa7e7771eecc9))
* **base-cluster/dependencies:** update helm release kube-prometheus-stack to v51 ([#564](https://github.com/teutonet/teutonet-helm-charts/issues/564)) ([00d46bc](https://github.com/teutonet/teutonet-helm-charts/commit/00d46bce88299c2121bffc1d8f21261f0e0bc872))
* **base-cluster/dependencies:** update oauth2-proxy docker tag to v4 ([#543](https://github.com/teutonet/teutonet-helm-charts/issues/543)) ([399e610](https://github.com/teutonet/teutonet-helm-charts/commit/399e61006fe3b3f6c764d79531173403a1dcc829))
* **base-cluster:** remove pause container image configuration ([#515](https://github.com/teutonet/teutonet-helm-charts/issues/515)) ([d95087f](https://github.com/teutonet/teutonet-helm-charts/commit/d95087f012d22414afe5913f3d19e21da974d139))
* **base-cluster:** remove steutol ([#541](https://github.com/teutonet/teutonet-helm-charts/issues/541)) ([aa36edd](https://github.com/teutonet/teutonet-helm-charts/commit/aa36eddd8c998cf3aa5fc83e0e07c94e43ce45c8))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.4 ([#484](https://github.com/teutonet/teutonet-helm-charts/issues/484)) ([3e73e61](https://github.com/teutonet/teutonet-helm-charts/commit/3e73e61caa0bf590116db7958f34aeff8c231d7e))
* **deps:** update helm release kube-prometheus-stack to v48 ([#482](https://github.com/teutonet/teutonet-helm-charts/issues/482)) ([2b18f57](https://github.com/teutonet/teutonet-helm-charts/commit/2b18f57fe9169839f9759a6bebc476eed7ef9e5c))

## [4.6.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.5.4...base-cluster-v4.6.0) (2023-08-22)


### Features

* **base-cluster/nginx:** enable underscores in headers ([#488](https://github.com/teutonet/teutonet-helm-charts/issues/488)) ([b6b8f0a](https://github.com/teutonet/teutonet-helm-charts/commit/b6b8f0a8c162a9640eaeae0fb260fbe77aacda99))
* **base-cluster/velero:** increase velero resources ([#491](https://github.com/teutonet/teutonet-helm-charts/issues/491)) ([e9cd094](https://github.com/teutonet/teutonet-helm-charts/commit/e9cd094e5899520450fbc1373e74948af9f78b62))


### Bug Fixes

* **base-cluster/backup:** typos in credential keys ([#497](https://github.com/teutonet/teutonet-helm-charts/issues/497)) ([b990a04](https://github.com/teutonet/teutonet-helm-charts/commit/b990a047a1d80e7430bda0cae0679466bac54023))

## [4.5.4](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.5.3...base-cluster-v4.5.4) (2023-08-21)


### Bug Fixes

* **base-cluster/backups:** Allow for better configuration of s3 buckets ([#495](https://github.com/teutonet/teutonet-helm-charts/issues/495)) ([b64fcc8](https://github.com/teutonet/teutonet-helm-charts/commit/b64fcc8057b8e589c8d98c2dd43be9b38d37b3e7))
* **base-cluster/flux:** correctly check for the correct imagePullPolicy ([#477](https://github.com/teutonet/teutonet-helm-charts/issues/477)) ([9818d77](https://github.com/teutonet/teutonet-helm-charts/commit/9818d775b626c64d68d278be7d7f6ea6d40374ce))
* **base-cluster/imagePullSecrets:** getting recreated upon reconciliation ([#476](https://github.com/teutonet/teutonet-helm-charts/issues/476)) ([b910569](https://github.com/teutonet/teutonet-helm-charts/commit/b910569d1f95fd26d316f3cd3a0ea5c658f5b461))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#478](https://github.com/teutonet/teutonet-helm-charts/issues/478)) ([9cefe19](https://github.com/teutonet/teutonet-helm-charts/commit/9cefe1936ab103be57d572c1470447dbcfc6f0fb))

## [4.5.3](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.5.2...base-cluster-v4.5.3) (2023-07-07)


### Bug Fixes

* **base-cluster/kyverno:** add aws provider ([#471](https://github.com/teutonet/teutonet-helm-charts/issues/471)) ([6d80478](https://github.com/teutonet/teutonet-helm-charts/commit/6d80478c52e49b715ed790d3deea35d500b1bec2))
* **base-cluster/velero:** add docker.io as registry ([#474](https://github.com/teutonet/teutonet-helm-charts/issues/474)) ([28553a4](https://github.com/teutonet/teutonet-helm-charts/commit/28553a41ccc61950b9391b0d962032e7b6106bb0))


### Miscellaneous Chores

* **deps:** update helm release common to v2.5.0 ([#462](https://github.com/teutonet/teutonet-helm-charts/issues/462)) ([03b6520](https://github.com/teutonet/teutonet-helm-charts/commit/03b652030040e01dcdef4c5fbe3992b48f781bc8))
* **deps:** update helm release common to v2.6.0 ([#468](https://github.com/teutonet/teutonet-helm-charts/issues/468)) ([ecb2102](https://github.com/teutonet/teutonet-helm-charts/commit/ecb2102b141d0e7d27fb476ca3e102719c461eee))

## [4.5.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.5.1...base-cluster-v4.5.2) (2023-06-29)


### Bug Fixes

* **base-cluster/backup:** also lower resource requests for nodeAgent ([#459](https://github.com/teutonet/teutonet-helm-charts/issues/459)) ([384f3cd](https://github.com/teutonet/teutonet-helm-charts/commit/384f3cd7844bc40b85be3ecd5e689c9938cc341e))


### Miscellaneous Chores

* **deps:** update helm release kube-prometheus-stack to v47 ([#454](https://github.com/teutonet/teutonet-helm-charts/issues/454)) ([5d16743](https://github.com/teutonet/teutonet-helm-charts/commit/5d1674369275cccb0f3447fc8ddf9f58dce7d3e0))

## [4.5.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.5.0...base-cluster-v4.5.1) (2023-06-21)


### Bug Fixes

* **base-cluster/backup:** reduce request, make configurable ([#453](https://github.com/teutonet/teutonet-helm-charts/issues/453)) ([85e9b13](https://github.com/teutonet/teutonet-helm-charts/commit/85e9b13e0c404a46a612dd7554411a9fe11b8220))
* **base-cluster:** update config to comply with trusted images ([#451](https://github.com/teutonet/teutonet-helm-charts/issues/451)) ([9431caf](https://github.com/teutonet/teutonet-helm-charts/commit/9431caf831346c06d6a3d31d27a3c50fc2ae8111))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#438](https://github.com/teutonet/teutonet-helm-charts/issues/438)) ([fffc128](https://github.com/teutonet/teutonet-helm-charts/commit/fffc128ba81038842ce8356d3d46b203123aa1f3))
* **base-cluster/schema:** use $def instead of URL ([#452](https://github.com/teutonet/teutonet-helm-charts/issues/452)) ([82142eb](https://github.com/teutonet/teutonet-helm-charts/commit/82142ebaad2d049fb5bb35be0e02890fd68ebd5f))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.3 ([#447](https://github.com/teutonet/teutonet-helm-charts/issues/447)) ([dcb099d](https://github.com/teutonet/teutonet-helm-charts/commit/dcb099da6d49ea24aa9208a4834214b6c5967d6b))

## [4.5.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.4.0...base-cluster-v4.5.0) (2023-06-12)


### Features

* **base-cluster/backup:** implement velero backup provider ([#431](https://github.com/teutonet/teutonet-helm-charts/issues/431)) ([47ee030](https://github.com/teutonet/teutonet-helm-charts/commit/47ee0304dd650fd6d9ae1ed67995e317afd3733c))
* **base-cluster/kube-prometheus-stack:** restructure kube-prometheus-stack for better maintainability ([#391](https://github.com/teutonet/teutonet-helm-charts/issues/391)) ([3441b57](https://github.com/teutonet/teutonet-helm-charts/commit/3441b57ab5663438912d9e06ebd3ec8011c8415a))
* **base-cluster/monitoring:** add trivy dashboard ([#400](https://github.com/teutonet/teutonet-helm-charts/issues/400)) ([d0d28d3](https://github.com/teutonet/teutonet-helm-charts/commit/d0d28d35adf7d1363a4fe5d0e6576a59712a5772))
* **base-cluster:** add pre-delete hook and docs about uninstalling ([#407](https://github.com/teutonet/teutonet-helm-charts/issues/407)) ([a02ba9e](https://github.com/teutonet/teutonet-helm-charts/commit/a02ba9ead69f466357ac6977f8759cdc2987353e))
* **base-cluster:** support and use OCI helmRepositories wherever possible ([#381](https://github.com/teutonet/teutonet-helm-charts/issues/381)) ([f83f433](https://github.com/teutonet/teutonet-helm-charts/commit/f83f433ba73ed93ca3e06a52806a46a0ffc0b9bd))


### Bug Fixes

* **base-cluster/backup:** fix non-working default configuration ([#440](https://github.com/teutonet/teutonet-helm-charts/issues/440)) ([438416d](https://github.com/teutonet/teutonet-helm-charts/commit/438416d04b62f6ec7cb1459cdbbdec6082dff447))
* **base-cluster/grafana:** fix dashboard name ([#429](https://github.com/teutonet/teutonet-helm-charts/issues/429)) ([cdbb398](https://github.com/teutonet/teutonet-helm-charts/commit/cdbb398f17900d727c479c8507620f176ff5bf24))
* **base-cluster/uninstallation:** do the correct templating 🤦 ([#427](https://github.com/teutonet/teutonet-helm-charts/issues/427)) ([39e4940](https://github.com/teutonet/teutonet-helm-charts/commit/39e49401105b1f625cd0a1c1aee639427170602f))
* **base-cluster:** fix uninstallation templating ([#425](https://github.com/teutonet/teutonet-helm-charts/issues/425)) ([394dd36](https://github.com/teutonet/teutonet-helm-charts/commit/394dd36c3eaec88b252f9f429a67d5353e36b449))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#367](https://github.com/teutonet/teutonet-helm-charts/issues/367)) ([d57e531](https://github.com/teutonet/teutonet-helm-charts/commit/d57e5317cd573d18d01448aa7404d3d3398b9851))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.2 ([#421](https://github.com/teutonet/teutonet-helm-charts/issues/421)) ([4d0fcd7](https://github.com/teutonet/teutonet-helm-charts/commit/4d0fcd7bf5a45cdac602670908b1f8a0de9ce914))
* **deps:** update helm release common to v2.2.5 ([#383](https://github.com/teutonet/teutonet-helm-charts/issues/383)) ([6205753](https://github.com/teutonet/teutonet-helm-charts/commit/620575318783563c30ae38e436208f3ba24aa203))
* **deps:** update helm release common to v2.4.0 ([#419](https://github.com/teutonet/teutonet-helm-charts/issues/419)) ([a2eef0a](https://github.com/teutonet/teutonet-helm-charts/commit/a2eef0aae49cef3be171c610ff8146b9b2b6fb65))
* **deps:** update helm release descheduler to 0.27.x ([#388](https://github.com/teutonet/teutonet-helm-charts/issues/388)) ([4e66a01](https://github.com/teutonet/teutonet-helm-charts/commit/4e66a01b5a0e514e5dda7a820213f316f3ec945c))
* **deps:** update helm release kube-prometheus-stack to v46 ([#424](https://github.com/teutonet/teutonet-helm-charts/issues/424)) ([73daff3](https://github.com/teutonet/teutonet-helm-charts/commit/73daff315e1b90e8aa0bdbbd3a11b63148b75174))

## [4.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.3.1...base-cluster-v4.4.0) (2023-05-08)


### Features

* **base-cluster/descheduler:** add new version ([#392](https://github.com/teutonet/teutonet-helm-charts/issues/392)) ([cb11504](https://github.com/teutonet/teutonet-helm-charts/commit/cb11504f96f2db80c4f24d11815b61218fa9387a))
* **base-cluster/monitoring:** make rootFS readOnly ([#386](https://github.com/teutonet/teutonet-helm-charts/issues/386)) ([6c92e41](https://github.com/teutonet/teutonet-helm-charts/commit/6c92e41a374bc14cc4cfec21a55f8cfdf76f3056))

## [4.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.3.0...base-cluster-v4.3.1) (2023-04-28)


### Bug Fixes

* **base-cluster/ingress:** change "kind" of default ([#376](https://github.com/teutonet/teutonet-helm-charts/issues/376)) ([32d6063](https://github.com/teutonet/teutonet-helm-charts/commit/32d6063af102d668f20334e500328455c824e549))

## [4.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.2.0...base-cluster-v4.3.0) (2023-04-27)


### Features

* **base-cluster/ci:** add scripts, deduplicate values ([#357](https://github.com/teutonet/teutonet-helm-charts/issues/357)) ([1c0a7f1](https://github.com/teutonet/teutonet-helm-charts/commit/1c0a7f1b5377d5fe9b9114d05cec6db39fee77ae))
* **base-cluster/ingress:** set nginx as default ingerssClass ([#368](https://github.com/teutonet/teutonet-helm-charts/issues/368)) ([93b4747](https://github.com/teutonet/teutonet-helm-charts/commit/93b4747ddef340470c27162347971515afb9ab59))
* **base-cluster/ingress:** support hetzner cloud loadbalancer ([#363](https://github.com/teutonet/teutonet-helm-charts/issues/363)) ([96a5119](https://github.com/teutonet/teutonet-helm-charts/commit/96a5119e2ca569464965dd1c4932767d3599a088))
* **base-cluster/monitoring:** add podMonitor and dashboard for flux ([#314](https://github.com/teutonet/teutonet-helm-charts/issues/314)) ([6e58cf8](https://github.com/teutonet/teutonet-helm-charts/commit/6e58cf89ca62c9ed6fcf7788bfc76a56b1abb23f))
* **base-cluster:** prepare for flux drift-detection ([#323](https://github.com/teutonet/teutonet-helm-charts/issues/323)) ([9089bd5](https://github.com/teutonet/teutonet-helm-charts/commit/9089bd52640cef227f301f3cc41f3cb5e248699f))
* **base-cluster:** update CODEOWNERS ([#332](https://github.com/teutonet/teutonet-helm-charts/issues/332)) ([79bd962](https://github.com/teutonet/teutonet-helm-charts/commit/79bd962de9fadb043de9a43817cd3d97565e5655))


### Bug Fixes

* **base-cluster/cert-manager:** use correct ClusterIssuer name ([#358](https://github.com/teutonet/teutonet-helm-charts/issues/358)) ([2ed7824](https://github.com/teutonet/teutonet-helm-charts/commit/2ed7824887d4bb443c0c79b3f099fde573e851b9))
* **base-cluster/docs:** typos ([#313](https://github.com/teutonet/teutonet-helm-charts/issues/313)) ([cf24622](https://github.com/teutonet/teutonet-helm-charts/commit/cf24622ce728970ccf09aac53d8c731a1e11aced))
* **base-cluster/flux:** adjust schema for flux gitRepositories ([#344](https://github.com/teutonet/teutonet-helm-charts/issues/344)) ([0ab5ee9](https://github.com/teutonet/teutonet-helm-charts/commit/0ab5ee98e4b72331358c8da57ab50eff0696d7cf))
* **base-cluster/ingress:** remove duplicate certs ([#369](https://github.com/teutonet/teutonet-helm-charts/issues/369)) ([a2b652f](https://github.com/teutonet/teutonet-helm-charts/commit/a2b652f96bff6f0d8c5d8cefc24f78ea0f8369b6))
* **base-cluster:** weird stuff ([#327](https://github.com/teutonet/teutonet-helm-charts/issues/327)) ([5a3fc3e](https://github.com/teutonet/teutonet-helm-charts/commit/5a3fc3e301095e36153cf689555eb6a822042688))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#319](https://github.com/teutonet/teutonet-helm-charts/issues/319)) ([e295af7](https://github.com/teutonet/teutonet-helm-charts/commit/e295af74af05524434bb9bf070760aec1e146a12))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#340](https://github.com/teutonet/teutonet-helm-charts/issues/340)) ([06e2877](https://github.com/teutonet/teutonet-helm-charts/commit/06e28774cf1b4f58672ce0473c85b50b23cf7871))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.26.4 ([#342](https://github.com/teutonet/teutonet-helm-charts/issues/342)) ([88493f2](https://github.com/teutonet/teutonet-helm-charts/commit/88493f22224e068d7297d151011905f0b261be2b))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.1 ([#351](https://github.com/teutonet/teutonet-helm-charts/issues/351)) ([3a22fce](https://github.com/teutonet/teutonet-helm-charts/commit/3a22fceb617b8e5f0eb18e104f104070e65649b6))

## [4.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.1.1...base-cluster-v4.2.0) (2023-03-23)


### Features

* **base-cluster/docs:** add info about components ([#291](https://github.com/teutonet/teutonet-helm-charts/issues/291)) ([575878f](https://github.com/teutonet/teutonet-helm-charts/commit/575878f65dd7360f4b9da92fa5388fe734beace3)), closes [#290](https://github.com/teutonet/teutonet-helm-charts/issues/290)


### Miscellaneous Chores

* **deps:** update docker.io/bitnami/kubectl docker tag to v1.26.3 ([#307](https://github.com/teutonet/teutonet-helm-charts/issues/307)) ([c017239](https://github.com/teutonet/teutonet-helm-charts/commit/c0172397c9a54bef788948de3210ef9350d99147))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.41.2 ([#303](https://github.com/teutonet/teutonet-helm-charts/issues/303)) ([9d9b327](https://github.com/teutonet/teutonet-helm-charts/commit/9d9b32751273db9a688d76be219f846b0a931364))
* **deps:** update helm release common to v2.2.4 ([#264](https://github.com/teutonet/teutonet-helm-charts/issues/264)) ([4e4f4ed](https://github.com/teutonet/teutonet-helm-charts/commit/4e4f4edcceeec46b2df23f3e2d9d152d296f8933))
* **deps:** update helm release nfs-server-provisioner to v1.8.0 ([#265](https://github.com/teutonet/teutonet-helm-charts/issues/265)) ([a72e3ff](https://github.com/teutonet/teutonet-helm-charts/commit/a72e3ff0eb12bcbc360e46a9790e6c717f63ba32)), closes [#263](https://github.com/teutonet/teutonet-helm-charts/issues/263)

## [4.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.1.0...base-cluster-v4.1.1) (2023-03-13)


### Bug Fixes

* **base-cluster/validation:** ssh regex ([#270](https://github.com/teutonet/teutonet-helm-charts/issues/270)) ([0567f66](https://github.com/teutonet/teutonet-helm-charts/commit/0567f6656ae669832656912870151a6788433d91))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#273](https://github.com/teutonet/teutonet-helm-charts/issues/273)) ([d41cada](https://github.com/teutonet/teutonet-helm-charts/commit/d41cada6a879e2ce268fb92f7c2a14635bfa1da9))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#283](https://github.com/teutonet/teutonet-helm-charts/issues/283)) ([4535610](https://github.com/teutonet/teutonet-helm-charts/commit/4535610925e77057591b7ebe8cd4edf5280a3f6d))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.41.0 ([#276](https://github.com/teutonet/teutonet-helm-charts/issues/276)) ([fce38d0](https://github.com/teutonet/teutonet-helm-charts/commit/fce38d017997903d53ad30e5f0b43d1b453632b8))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.41.1 ([#282](https://github.com/teutonet/teutonet-helm-charts/issues/282)) ([2b24d9e](https://github.com/teutonet/teutonet-helm-charts/commit/2b24d9e193c0d79494b230916b49fb1a617a6104))

## [4.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-4.0.0...base-cluster-v4.1.0) (2023-03-07)


### Features

* **base-cluster:** use current version dir for schema ([#260](https://github.com/teutonet/teutonet-helm-charts/issues/260)) ([18ed476](https://github.com/teutonet/teutonet-helm-charts/commit/18ed476fa17a45f7589dd9ff4f36ee8f726cde9d))


### Bug Fixes

* **base-cluster/storage:** wrong usage of the "common.storage.class" ([#241](https://github.com/teutonet/teutonet-helm-charts/issues/241)) ([b1dbeb5](https://github.com/teutonet/teutonet-helm-charts/commit/b1dbeb5609c39e769126149881714e1645fc5950))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#255](https://github.com/teutonet/teutonet-helm-charts/issues/255)) ([f4f0eff](https://github.com/teutonet/teutonet-helm-charts/commit/f4f0effb317c5f0d16da63a493b6378e83065b88))
* **deps:** update helm release reflector to v7 ([#254](https://github.com/teutonet/teutonet-helm-charts/issues/254)) ([27f7a7d](https://github.com/teutonet/teutonet-helm-charts/commit/27f7a7d07b95ddfdffd9bbbfe697c9b3c30aee45))

## [4.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-3.3.2...base-cluster-v4.0.0) (2023-03-03)


### ⚠ BREAKING CHANGES

* **base-cluster:** remove storageclass from chart ([#224](https://github.com/teutonet/teutonet-helm-charts/issues/224))

### Features

* **base-cluster/readme:** add additional info ([#211](https://github.com/teutonet/teutonet-helm-charts/issues/211)) ([defc7c0](https://github.com/teutonet/teutonet-helm-charts/commit/defc7c0ac48ed4f060ec52ad342ed39d9a14e9c1))
* **base-cluster:** move version so renovate can detect this ([#217](https://github.com/teutonet/teutonet-helm-charts/issues/217)) ([ed575a1](https://github.com/teutonet/teutonet-helm-charts/commit/ed575a1d9d569716891e7bc50ab5c9616964706c))
* **base-cluster:** remove storageclass from chart ([#224](https://github.com/teutonet/teutonet-helm-charts/issues/224)) ([efebd28](https://github.com/teutonet/teutonet-helm-charts/commit/efebd286784a38b8cfaa3fd075064196188754c2))


### Bug Fixes

* **base-cluster:** correctly use chartSpec ([#226](https://github.com/teutonet/teutonet-helm-charts/issues/226)) ([c072c05](https://github.com/teutonet/teutonet-helm-charts/commit/c072c05a99125f8adfac47f37c82074970a9e3cc))


### Miscellaneous Chores

* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#244](https://github.com/teutonet/teutonet-helm-charts/issues/244)) ([daa9db7](https://github.com/teutonet/teutonet-helm-charts/commit/daa9db7fe890dc9fddd244fdcbe08c91f728a9df))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#249](https://github.com/teutonet/teutonet-helm-charts/issues/249)) ([30ff49f](https://github.com/teutonet/teutonet-helm-charts/commit/30ff49ff309dfeb9bc2443a14c0d9eef3cc2f027))
* **base-cluster/artifacthub-images:** Update ArtifactHUB images ([#251](https://github.com/teutonet/teutonet-helm-charts/issues/251)) ([8e9b9b1](https://github.com/teutonet/teutonet-helm-charts/commit/8e9b9b1c840cb34c6a03bdb1a3e43031be7d7d23))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.26.2 ([#246](https://github.com/teutonet/teutonet-helm-charts/issues/246)) ([163f15a](https://github.com/teutonet/teutonet-helm-charts/commit/163f15abcaceb23b1b77e160c34965f462a78614))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.40.1 ([#221](https://github.com/teutonet/teutonet-helm-charts/issues/221)) ([264fbc9](https://github.com/teutonet/teutonet-helm-charts/commit/264fbc99b1179e17c9fbc99f159e533391260f88))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.40.2 ([#243](https://github.com/teutonet/teutonet-helm-charts/issues/243)) ([59f273b](https://github.com/teutonet/teutonet-helm-charts/commit/59f273bb6a01e8889c06f2d558b773cfe9b78797))
* **deps:** update helm release nfs-server-provisioner to v1.7.0 ([#225](https://github.com/teutonet/teutonet-helm-charts/issues/225)) ([7c1c93e](https://github.com/teutonet/teutonet-helm-charts/commit/7c1c93e6cce6270fb6d1027f68b3b2239e99215e))
* **t8s-cluster:** Update ArtifactHUB images ([#233](https://github.com/teutonet/teutonet-helm-charts/issues/233)) ([22cab6b](https://github.com/teutonet/teutonet-helm-charts/commit/22cab6b19469775cae3d172b3f47b56ad111eb90))

## [3.3.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-3.3.1...base-cluster-v3.3.2) (2023-02-22)


### Bug Fixes

* **base-cluster/cert-manager:** fix name reference to clusterIssuer ([#218](https://github.com/teutonet/teutonet-helm-charts/issues/218)) ([1ec687f](https://github.com/teutonet/teutonet-helm-charts/commit/1ec687fbb8bae040ca7b6e64e4911684be7ff320))

## [3.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-3.3.0...base-cluster-v3.3.1) (2023-02-21)


### Bug Fixes

* **base-cluster/cert-manager:** fix clusterissuer templating ([#207](https://github.com/teutonet/teutonet-helm-charts/issues/207)) ([47a0c1d](https://github.com/teutonet/teutonet-helm-charts/commit/47a0c1da8e828ce716ebd26e95b8ccc5fe19f7bd))
* **base-cluster/schema:** adjust regex to catch common user errors ([#212](https://github.com/teutonet/teutonet-helm-charts/issues/212)) ([61836d4](https://github.com/teutonet/teutonet-helm-charts/commit/61836d4590a6095ffdc493e295244f25c2b478ac))


### Miscellaneous Chores

* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.40.0 ([#210](https://github.com/teutonet/teutonet-helm-charts/issues/210)) ([4180283](https://github.com/teutonet/teutonet-helm-charts/commit/4180283aeb1a2e27e93a40a93d8f0ad5656a734e))

## [3.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-3.2.0...base-cluster-v3.3.0) (2023-02-10)


### Features

* **base-cluster/ClusterIssuer:** rename old ClusterIssuer and add ([#184](https://github.com/teutonet/teutonet-helm-charts/issues/184)) ([6f18200](https://github.com/teutonet/teutonet-helm-charts/commit/6f1820048ddef5399a3bcc77185386f5987c2ee5)), closes [#183](https://github.com/teutonet/teutonet-helm-charts/issues/183)

## [3.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-3.1.0...base-cluster-v3.2.0) (2023-02-10)


### Features

* **base-cluster/kube-prometheus-stack:** bump version ([#192](https://github.com/teutonet/teutonet-helm-charts/issues/192)) ([47d22f5](https://github.com/teutonet/teutonet-helm-charts/commit/47d22f525c1628fc5ba31d3177b2b4daae7f767f))
* **base-cluster/storageclass:** prepare deletion by leaving them aft… ([#193](https://github.com/teutonet/teutonet-helm-charts/issues/193)) ([983bfc8](https://github.com/teutonet/teutonet-helm-charts/commit/983bfc8cab94561aa56381444092ecd46a2469c2))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([700fe07](https://github.com/teutonet/teutonet-helm-charts/commit/700fe07a5706c974fd5e608c1d67678bf8126b28))
* **base-cluster:** Update images in 'Chart.yaml' ([b6e37be](https://github.com/teutonet/teutonet-helm-charts/commit/b6e37be298771915ca1b8f8a43c2004fe6cc0f5d))
* **deps:** update helm release common to v2.2.3 ([#189](https://github.com/teutonet/teutonet-helm-charts/issues/189)) ([ea07b8a](https://github.com/teutonet/teutonet-helm-charts/commit/ea07b8a8f68197f55a5d85bcdf881f71c63578ae))
* **t8s-cluster:** Update images in 'Chart.yaml' ([91b78ab](https://github.com/teutonet/teutonet-helm-charts/commit/91b78ab382902f078dc8b6b28d0cf3a5842f7776))

## [3.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-3.0.1...base-cluster-v3.1.0) (2023-02-01)


### Features

* **base-cluster:** disable PrometheusNotConnectedToAlertman… ([#163](https://github.com/teutonet/teutonet-helm-charts/issues/163)) ([9669349](https://github.com/teutonet/teutonet-helm-charts/commit/9669349745b50091dff888ddd473c76d85131e77))
* **base-cluster:** lower base resource requests ([#151](https://github.com/teutonet/teutonet-helm-charts/issues/151)) ([f280d57](https://github.com/teutonet/teutonet-helm-charts/commit/f280d57278fdf3efa77aae2ade7fe89c503c737e))


### Bug Fixes

* **base-cluster:** fix logic for selection latest version ([#166](https://github.com/teutonet/teutonet-helm-charts/issues/166)) ([c30382b](https://github.com/teutonet/teutonet-helm-charts/commit/c30382b2e9767a6c89cd5e2b129a8d8683509e95))

## [3.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-3.0.0...base-cluster-v3.0.1) (2023-01-26)


### Bug Fixes

* **base-cluster:** wrong whitespace removal ([#157](https://github.com/teutonet/teutonet-helm-charts/issues/157)) ([1985ade](https://github.com/teutonet/teutonet-helm-charts/commit/1985ade1edc2fbaea0a0860de62128d6fee8e457))

## [3.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-2.0.0...base-cluster-v3.0.0) (2023-01-26)


### ⚠ BREAKING CHANGES

* **base-cluster:** Revert "feat(base-cluster)!: use flux as a direct… ([#152](https://github.com/teutonet/teutonet-helm-charts/issues/152))

### Bug Fixes

* **base-cluster:** Revert "feat(base-cluster)!: use flux as a direct… ([#152](https://github.com/teutonet/teutonet-helm-charts/issues/152)) ([10191a3](https://github.com/teutonet/teutonet-helm-charts/commit/10191a32dec2241bad62c3f2404b79e6d0fba1c4))


### Miscellaneous Chores

* **deps:** update helm release flux2 to v2.5.0 ([#149](https://github.com/teutonet/teutonet-helm-charts/issues/149)) ([d6e637f](https://github.com/teutonet/teutonet-helm-charts/commit/d6e637fec6f81f64089554840be86fc376300ea8))

## [2.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-1.2.2...base-cluster-v2.0.0) (2023-01-20)


### ⚠ BREAKING CHANGES

* **base-cluster:** use flux as a direct helm dependency ([#145](https://github.com/teutonet/teutonet-helm-charts/issues/145))

### Features

* **base-cluster:** bump kube-prometheus-stack version ([#142](https://github.com/teutonet/teutonet-helm-charts/issues/142)) ([42bf980](https://github.com/teutonet/teutonet-helm-charts/commit/42bf98095573174f2204daf65def2a1d9a61f2b8))
* **base-cluster:** use flux as a direct helm dependency ([#145](https://github.com/teutonet/teutonet-helm-charts/issues/145)) ([0a906e8](https://github.com/teutonet/teutonet-helm-charts/commit/0a906e837da70360805f13d4219810c4f3b7b2ba)), closes [#109](https://github.com/teutonet/teutonet-helm-charts/issues/109)


### Bug Fixes

* **base-cluster:** fix token retrieval ([#138](https://github.com/teutonet/teutonet-helm-charts/issues/138)) ([ac7dc9d](https://github.com/teutonet/teutonet-helm-charts/commit/ac7dc9d46f08e066bfb50b86a3793c47ece2bdbd))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([d88cde3](https://github.com/teutonet/teutonet-helm-charts/commit/d88cde358cbe31d566504c172d44e1bee9e61930))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.26.0 ([#139](https://github.com/teutonet/teutonet-helm-charts/issues/139)) ([e981a97](https://github.com/teutonet/teutonet-helm-charts/commit/e981a97361b4cc266a1f8a4394f32f5e4747b879))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.26.1 ([#141](https://github.com/teutonet/teutonet-helm-charts/issues/141)) ([1f62579](https://github.com/teutonet/teutonet-helm-charts/commit/1f625796e2103b1bcd848c0321867a0d8c0f996c))

## [1.2.2](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-1.2.1...base-cluster-v1.2.2) (2023-01-12)


### Bug Fixes

* **base-cluster:** remove bad whitespace 😕 ([#135](https://github.com/teutonet/teutonet-helm-charts/issues/135)) ([193223b](https://github.com/teutonet/teutonet-helm-charts/commit/193223b63b79bda337b12437f1674aca2d9c2a94))

## [1.2.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-1.2.0...base-cluster-v1.2.1) (2023-01-12)


### Bug Fixes

* **base-cluster:** ingress tls annotation ([#133](https://github.com/teutonet/teutonet-helm-charts/issues/133)) ([086930d](https://github.com/teutonet/teutonet-helm-charts/commit/086930dd2b3233fd1677f54a689f78df34d85738))

## [1.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-1.1.0...base-cluster-v1.2.0) (2023-01-12)


### Features

* **base-cluster:** allow configuring the tools domains ([#130](https://github.com/teutonet/teutonet-helm-charts/issues/130)) ([85b127f](https://github.com/teutonet/teutonet-helm-charts/commit/85b127f6d407a9d9f9b81168445a47d406f0563a))


### Bug Fixes

* **base-cluster:** also implement grafana! and alertmanager ([#132](https://github.com/teutonet/teutonet-helm-charts/issues/132)) ([fa86162](https://github.com/teutonet/teutonet-helm-charts/commit/fa861627511b915b133ca81f577fc4445b3129fb))
* **base-cluster:** check for boolean instead of string ([#131](https://github.com/teutonet/teutonet-helm-charts/issues/131)) ([f6d45ae](https://github.com/teutonet/teutonet-helm-charts/commit/f6d45aea02d4812c90cac10271a8ec3dcc30bc5b))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([895dfbf](https://github.com/teutonet/teutonet-helm-charts/commit/895dfbf97ca5cf5c26e6dba74d6a0e277772ffed))
* **base-cluster:** Update images in 'Chart.yaml' ([c885b28](https://github.com/teutonet/teutonet-helm-charts/commit/c885b282bd7f142f18b7b241c764652acfa221a5))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.38.3 ([#126](https://github.com/teutonet/teutonet-helm-charts/issues/126)) ([7911b92](https://github.com/teutonet/teutonet-helm-charts/commit/7911b92d621f781ce014c5ffd27dd9d2480e77a8))

## [1.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-1.0.0...base-cluster-v1.1.0) (2023-01-10)


### Features

* **base-cluster:** enable brotli and gzip ([#124](https://github.com/teutonet/teutonet-helm-charts/issues/124)) ([6322dcf](https://github.com/teutonet/teutonet-helm-charts/commit/6322dcf9e44a7d39215580726283d0486c6b4337))


### Miscellaneous Chores

* **deps:** update k8s.gcr.io/pause docker tag to v3.9 ([#123](https://github.com/teutonet/teutonet-helm-charts/issues/123)) ([0f1a88f](https://github.com/teutonet/teutonet-helm-charts/commit/0f1a88fcb93a0a2d1d6f5cfbb8b9690d8eb780cc))

## [1.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.8.0...base-cluster-v1.0.0) (2023-01-09)


### ⚠ BREAKING CHANGES

* **base-cluster:** migrate `.dns.email` to `.certManager.email`, ([#120](https://github.com/teutonet/teutonet-helm-charts/issues/120))

### Features

* **base-cluster:** add more info for the installation ([#117](https://github.com/teutonet/teutonet-helm-charts/issues/117)) ([d408283](https://github.com/teutonet/teutonet-helm-charts/commit/d4082835a0e007d0f2f4138aa3fadc8afae9d00c))
* **base-cluster:** replace sleep with pause container ([#110](https://github.com/teutonet/teutonet-helm-charts/issues/110)) ([7776ce5](https://github.com/teutonet/teutonet-helm-charts/commit/7776ce5880f2a28e97b02c7ca6ad62be2b5cb4cd))


### Bug Fixes

* **base-cluster:** add missing type parameter ([#108](https://github.com/teutonet/teutonet-helm-charts/issues/108)) ([bf28366](https://github.com/teutonet/teutonet-helm-charts/commit/bf2836612422220e68bd04a53dffb10487c9f983))
* **base-cluster:** validation ([#111](https://github.com/teutonet/teutonet-helm-charts/issues/111)) ([0b592b9](https://github.com/teutonet/teutonet-helm-charts/commit/0b592b956c64694e7aef84127bc3ecfbe2014163))


### refactor

* **base-cluster:** migrate `.dns.email` to `.certManager.email`, ([#120](https://github.com/teutonet/teutonet-helm-charts/issues/120)) ([31fb6dd](https://github.com/teutonet/teutonet-helm-charts/commit/31fb6dd5311976b0a6ed18ba55e2bac714b7dee3)), closes [#119](https://github.com/teutonet/teutonet-helm-charts/issues/119)

## [0.8.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.7.1...base-cluster-v0.8.0) (2023-01-02)


### Features

* **base-cluster:** update bootstrap documentation ([#113](https://github.com/teutonet/teutonet-helm-charts/issues/113)) ([65e2073](https://github.com/teutonet/teutonet-helm-charts/commit/65e2073be3cdcf9a5e453b86d8ee5e4a9aa07ee2))


### Bug Fixes

* **base-cluster:** add extraArgs so nginx LISTENs on the correct ports ([#114](https://github.com/teutonet/teutonet-helm-charts/issues/114)) ([30a8153](https://github.com/teutonet/teutonet-helm-charts/commit/30a8153c605a05562263291ac221bafb43ead9ce))
* **base-cluster:** fix certificates templating ([#112](https://github.com/teutonet/teutonet-helm-charts/issues/112)) ([6111e7b](https://github.com/teutonet/teutonet-helm-charts/commit/6111e7b4eb84bc6f82540b4f3b4ff560e521ecf8))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([d2a9bcb](https://github.com/teutonet/teutonet-helm-charts/commit/d2a9bcb5618e7f83fcd68f13a7b1b88277889d81))
* **base-cluster:** Update images in 'Chart.yaml' ([f8f4db3](https://github.com/teutonet/teutonet-helm-charts/commit/f8f4db3478c2ee878ab833cbd417638f506b4336))
* **base-cluster:** Update images in 'Chart.yaml' ([a14eb67](https://github.com/teutonet/teutonet-helm-charts/commit/a14eb67ffe08181080c4c63f66f8600d0f65c80b))
* **base-cluster:** Update images in 'Chart.yaml' ([d27ce7e](https://github.com/teutonet/teutonet-helm-charts/commit/d27ce7e87af7a1c14c963c6567dec8ac45b03211))
* **base-cluster:** Update images in 'Chart.yaml' ([fc3c072](https://github.com/teutonet/teutonet-helm-charts/commit/fc3c0726a4534478e8536cd9b3f3acd60fc7f98e))
* **base-cluster:** Update images in 'Chart.yaml' ([957a2dc](https://github.com/teutonet/teutonet-helm-charts/commit/957a2dc966eedbeffabc47bc9f341f35509baaa5))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.38.2 ([#107](https://github.com/teutonet/teutonet-helm-charts/issues/107)) ([bb5e27a](https://github.com/teutonet/teutonet-helm-charts/commit/bb5e27a3d6d2970c0ff48326963f818f46592f70))

## [0.7.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.7.0...base-cluster-v0.7.1) (2022-12-14)


### Bug Fixes

* **base-cluster:** multiple rules trigger wrong yaml ([#105](https://github.com/teutonet/teutonet-helm-charts/issues/105)) ([d4740fe](https://github.com/teutonet/teutonet-helm-charts/commit/d4740feb8c780d22bc0f5473586a2108dd7f3865))

## [0.7.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.6.0...base-cluster-v0.7.0) (2022-12-12)


### Features

* **base-cluster:** add rbac configuration options ([#100](https://github.com/teutonet/teutonet-helm-charts/issues/100)) ([e851d34](https://github.com/teutonet/teutonet-helm-charts/commit/e851d340f3202a7ebaf1f94aabb7c03e2db56ea1))

## [0.6.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.5.0...base-cluster-v0.6.0) (2022-12-12)


### Features

* **base-cluster:** update charts to their latest major version ([#101](https://github.com/teutonet/teutonet-helm-charts/issues/101)) ([6b57915](https://github.com/teutonet/teutonet-helm-charts/commit/6b57915243c7d5769ea8e3fab06c1b715ee32d29))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([6b67ba0](https://github.com/teutonet/teutonet-helm-charts/commit/6b67ba0a3b5b3350fb2e189757d3ee2784e56575))
* **base-cluster:** Update images in 'Chart.yaml' ([d282f18](https://github.com/teutonet/teutonet-helm-charts/commit/d282f1836ce32f4d185d341f440e1e23c51baf8b))
* **base-cluster:** Update images in 'Chart.yaml' ([c4fe668](https://github.com/teutonet/teutonet-helm-charts/commit/c4fe6687f7fa77ff5b5e9045cf90593513cc3090))
* **base-cluster:** Update images in 'Chart.yaml' ([f341e11](https://github.com/teutonet/teutonet-helm-charts/commit/f341e119918ac5699388be7097b0a1e9b3fb66f9))
* **base-cluster:** Update images in 'Chart.yaml' ([60d2aaa](https://github.com/teutonet/teutonet-helm-charts/commit/60d2aaadcccdef815d09f0b7e8b1c2e59e6bfa78))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.25.5 ([#102](https://github.com/teutonet/teutonet-helm-charts/issues/102)) ([1325d75](https://github.com/teutonet/teutonet-helm-charts/commit/1325d75f18a4bf17ee46711f3e53920cd148e1e9))
* **deps:** update helm release common to v2.2.1 ([#97](https://github.com/teutonet/teutonet-helm-charts/issues/97)) ([f5bc313](https://github.com/teutonet/teutonet-helm-charts/commit/f5bc31330fd18f94b4657b41867dd6d30cb88399))
* **deps:** update helm release common to v2.2.2 ([#103](https://github.com/teutonet/teutonet-helm-charts/issues/103)) ([21065b3](https://github.com/teutonet/teutonet-helm-charts/commit/21065b308c3f2261cfd2171630d6a1ab0f60b104))

## [0.5.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.4.1...base-cluster-v0.5.0) (2022-11-24)


### Features

* **base-cluster:** remove keyserver ([#96](https://github.com/teutonet/teutonet-helm-charts/issues/96)) ([10c7a1a](https://github.com/teutonet/teutonet-helm-charts/commit/10c7a1a376631988e4aacec30e8da97fb755772a))
* **base-cluster:** replace custom secret sync with reflector ([#94](https://github.com/teutonet/teutonet-helm-charts/issues/94)) ([47c67de](https://github.com/teutonet/teutonet-helm-charts/commit/47c67dee85a418e43ba7367d8e08b9549813b963))


### Miscellaneous Chores

* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.37.0 ([#92](https://github.com/teutonet/teutonet-helm-charts/issues/92)) ([03715da](https://github.com/teutonet/teutonet-helm-charts/commit/03715da86c050d1326756d249e4005bfe1981c2e))

## [0.4.1](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.4.0...base-cluster-v0.4.1) (2022-11-22)


### Bug Fixes

* **base-cluster:** trivy yaml duplicate key ([#90](https://github.com/teutonet/teutonet-helm-charts/issues/90)) ([b3f83d0](https://github.com/teutonet/teutonet-helm-charts/commit/b3f83d033b947a996ee4bd2c14b892c8855a41a7))

## [0.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.3.0...base-cluster-v0.4.0) (2022-11-22)


### Features

* **base-cluster:** add option to use a specific IP ([#82](https://github.com/teutonet/teutonet-helm-charts/issues/82)) ([345aa5b](https://github.com/teutonet/teutonet-helm-charts/commit/345aa5b68ca3caa1155adacd52febb6de8d7a9ea)), closes [#66](https://github.com/teutonet/teutonet-helm-charts/issues/66)
* **base-cluster:** add ref selection ([#85](https://github.com/teutonet/teutonet-helm-charts/issues/85)) ([34a5cf7](https://github.com/teutonet/teutonet-helm-charts/commit/34a5cf74f08816d211b92c88831a5ee72af196bd)), closes [#84](https://github.com/teutonet/teutonet-helm-charts/issues/84)
* **base-cluster:** add securityContexts to all pods ([#75](https://github.com/teutonet/teutonet-helm-charts/issues/75)) ([2094c99](https://github.com/teutonet/teutonet-helm-charts/commit/2094c9945d9a6624aabcc2b8a675a0a835ba9264)), closes [#68](https://github.com/teutonet/teutonet-helm-charts/issues/68)
* **base-cluster:** add support for flux sops decryption ([#86](https://github.com/teutonet/teutonet-helm-charts/issues/86)) ([029668d](https://github.com/teutonet/teutonet-helm-charts/commit/029668d9d3ce777cd7345e48f1c47eb7f9d576bf))
* **base-cluster:** miscellaneous adjustments ([#89](https://github.com/teutonet/teutonet-helm-charts/issues/89)) ([e5d2f4a](https://github.com/teutonet/teutonet-helm-charts/commit/e5d2f4a3b93592b8f0631fe79ae00606365d8f1a))


### Bug Fixes

* **base-cluster:** add status selector for namespaces ([#81](https://github.com/teutonet/teutonet-helm-charts/issues/81)) ([c67efd2](https://github.com/teutonet/teutonet-helm-charts/commit/c67efd243b8767bf3d90cc41739b65f3da6f9c52))
* **base-cluster:** correctly configure prometheus to scrape etcd via ([#88](https://github.com/teutonet/teutonet-helm-charts/issues/88)) ([677e446](https://github.com/teutonet/teutonet-helm-charts/commit/677e44698fe9fe76965d37927b07c9d41efac7ea))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([0e92aad](https://github.com/teutonet/teutonet-helm-charts/commit/0e92aad7a9aaaeffe359526925230613246090ca))
* **base-cluster:** Update images in 'Chart.yaml' ([6535b05](https://github.com/teutonet/teutonet-helm-charts/commit/6535b0598a54d6ceecbfd705dc9af57d4a1f702d))
* **base-cluster:** Update images in 'Chart.yaml' ([f0e4b56](https://github.com/teutonet/teutonet-helm-charts/commit/f0e4b56afb5f4f810d63f7fc93c535a467a3c94e))
* **base-cluster:** Update images in 'Chart.yaml' ([24510d2](https://github.com/teutonet/teutonet-helm-charts/commit/24510d2dd13e48321996816b963cf5f6bbd7d425))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.25.4 ([#74](https://github.com/teutonet/teutonet-helm-charts/issues/74)) ([c7fa0ed](https://github.com/teutonet/teutonet-helm-charts/commit/c7fa0ed2321f306b75d091ff8ff1abc5d151010e))
* **deps:** update helm release common to v2.2.0 ([#76](https://github.com/teutonet/teutonet-helm-charts/issues/76)) ([60e0b97](https://github.com/teutonet/teutonet-helm-charts/commit/60e0b97560e5512ddaa864ce48403f118a534ce1))

## [0.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.2.1...base-cluster-v0.3.0) (2022-11-09)


### Features

* **base-cluster:** add ci values for artifacthub ([#46](https://github.com/teutonet/teutonet-helm-charts/issues/46)) ([5b4e657](https://github.com/teutonet/teutonet-helm-charts/commit/5b4e65722a9a6d7f53387b77c401ac625c75d563))
* **base-cluster:** replace etcd secret job hook with a daemonset ([#71](https://github.com/teutonet/teutonet-helm-charts/issues/71)) ([79b673c](https://github.com/teutonet/teutonet-helm-charts/commit/79b673c7e9ed60f64cf9e641e52b0a8c9ccdc051))


### Bug Fixes

* **base-cluster:** change url to the "new" correct one ([#49](https://github.com/teutonet/teutonet-helm-charts/issues/49)) ([b892f7a](https://github.com/teutonet/teutonet-helm-charts/commit/b892f7a2af93bccc7ee67fbe25e9120b2a038b91))
* **base-cluster:** fix secret-sync cronjob ([#72](https://github.com/teutonet/teutonet-helm-charts/issues/72)) ([aa89dce](https://github.com/teutonet/teutonet-helm-charts/commit/aa89dce8a01178abc068f98797aa79755fa50bb2))
* **base-cluster:** fix templating of kyverno policies ([#50](https://github.com/teutonet/teutonet-helm-charts/issues/50)) ([04aa9ab](https://github.com/teutonet/teutonet-helm-charts/commit/04aa9abdd17278febd32c2ad69e7652fe60d1fa9))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([820b050](https://github.com/teutonet/teutonet-helm-charts/commit/820b050e0e93a6cfbce6a21503c6815f85a3a105))
* **base-cluster:** Update images in 'Chart.yaml' ([2132051](https://github.com/teutonet/teutonet-helm-charts/commit/21320512f274b4a252cc1670590e7829b5bcabca))
* **deps:** update helm release common to v2.1.1 ([#58](https://github.com/teutonet/teutonet-helm-charts/issues/58)) ([ddd7aae](https://github.com/teutonet/teutonet-helm-charts/commit/ddd7aae39d83927f7242857a174d444bb55a7ffc))
* **deps:** update helm release common to v2.1.2 ([#62](https://github.com/teutonet/teutonet-helm-charts/issues/62)) ([113fa69](https://github.com/teutonet/teutonet-helm-charts/commit/113fa699140eca0867112fc3e9094340b2b0f09a))

## [0.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-0.1.3...base-cluster-v0.2.0) (2022-10-21)


### Features

* **base-cluster:** add teuto-net HelmRepository ([#29](https://github.com/teutonet/teutonet-helm-charts/issues/29)) ([05bb335](https://github.com/teutonet/teutonet-helm-charts/commit/05bb335615d686d477fb26f5f19b1367678dba1e))


### Bug Fixes

* **base-cluster:** depend on kube-prometheus-stack ([#25](https://github.com/teutonet/teutonet-helm-charts/issues/25)) ([e9d390f](https://github.com/teutonet/teutonet-helm-charts/commit/e9d390ff36ad32c7292a8f7ed17d15d5d35edf6e))
