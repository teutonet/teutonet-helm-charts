# Changelog

## [9.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.3.1...t8s-cluster-v9.4.0) (2025-09-26)


### Features

* **t8s-cluster/auth:** add staff authentication ([#1703](https://github.com/teutonet/teutonet-helm-charts/issues/1703)) ([0fbd753](https://github.com/teutonet/teutonet-helm-charts/commit/0fbd753f58e14338077626c43bbd784544eb9371))
* **t8s-cluster:** implement autoscaling ([#1686](https://github.com/teutonet/teutonet-helm-charts/issues/1686)) ([b5de270](https://github.com/teutonet/teutonet-helm-charts/commit/b5de2705b345fb5ff5d54d94e8ca7d8a92eb2505))


### Miscellaneous Chores

* **t8s-cluster:** migrate config, ignore-volume-az is not enough ([#1679](https://github.com/teutonet/teutonet-helm-charts/issues/1679)) ([55b14c6](https://github.com/teutonet/teutonet-helm-charts/commit/55b14c69d2990c8de2afa640423315e1da29221b))

## [9.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.3.0...t8s-cluster-v9.3.1) (2025-07-11)


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update common docker tag to v1.5.0 ([#1534](https://github.com/teutonet/teutonet-helm-charts/issues/1534)) ([155472e](https://github.com/teutonet/teutonet-helm-charts/commit/155472ed4877261e120502c7654bd632b940fdc8))
* **t8s-cluster/management-cluster:** remove `cloud-provider` flag &gt;= 1.33.0 ([#1579](https://github.com/teutonet/teutonet-helm-charts/issues/1579)) ([5e4c562](https://github.com/teutonet/teutonet-helm-charts/commit/5e4c562f2885249e2ce3cd8824f7631c7f5bcf7f))

## [9.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.2.1...t8s-cluster-v9.3.0) (2025-06-06)


### Features

* **t8s-cluster:** add rbac for teuto staff ([#1498](https://github.com/teutonet/teutonet-helm-charts/issues/1498)) ([9e0a9e2](https://github.com/teutonet/teutonet-helm-charts/commit/9e0a9e2c4be2830fd1835bb949a963f047659a4e))
* **t8s-cluster:** enable audit logging ([#1440](https://github.com/teutonet/teutonet-helm-charts/issues/1440)) ([dcb28ca](https://github.com/teutonet/teutonet-helm-charts/commit/dcb28ca09156ad20f1f19fdad8a370aab02861db))
* **t8s-cluster:** make apiserver resources configurable ([#1485](https://github.com/teutonet/teutonet-helm-charts/issues/1485)) ([3126661](https://github.com/teutonet/teutonet-helm-charts/commit/3126661a773e899c56b284546eb4a88a2b620e31))
* **t8s-cluster:** use new pullPolicy template ([#1383](https://github.com/teutonet/teutonet-helm-charts/issues/1383)) ([6b253bd](https://github.com/teutonet/teutonet-helm-charts/commit/6b253bd6ecd6695f85481cff525c676619ae8044))


### Miscellaneous Chores

* **t8s-cluster:** pin versions ([#1482](https://github.com/teutonet/teutonet-helm-charts/issues/1482)) ([372c92b](https://github.com/teutonet/teutonet-helm-charts/commit/372c92bffad50b11d0d0e75c97b36101bd655ca8))

## [9.2.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.2.0...t8s-cluster-v9.2.1) (2025-03-06)


### Bug Fixes

* **t8s-cluster/management-cluster:** invalid volume names ([#1410](https://github.com/teutonet/teutonet-helm-charts/issues/1410)) ([70e81cc](https://github.com/teutonet/teutonet-helm-charts/commit/70e81cc716deb895901f5e544b7f17a1055b6fa4))

## [9.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.1.2...t8s-cluster-v9.2.0) (2025-03-05)


### Features

* **t8s-cluster/management-cluster:** add option to create SecurityGroupRules ([#1404](https://github.com/teutonet/teutonet-helm-charts/issues/1404)) ([895ebcd](https://github.com/teutonet/teutonet-helm-charts/commit/895ebcda0a1b0bc4c0a541d56932ecc2db487478))


### Bug Fixes

* **t8s-cluster/management-cluster:** add missing volumeMounts for apiServer ([#1405](https://github.com/teutonet/teutonet-helm-charts/issues/1405)) ([db91a8e](https://github.com/teutonet/teutonet-helm-charts/commit/db91a8e027487beeb960df964a607616c7ea91db))

## [9.1.2](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.1.1...t8s-cluster-v9.1.2) (2025-03-04)


### Bug Fixes

* **t8s-cluster/management-cluster:** renamed parameter ([#1402](https://github.com/teutonet/teutonet-helm-charts/issues/1402)) ([8999a5c](https://github.com/teutonet/teutonet-helm-charts/commit/8999a5cde9830603d80f27f19e686fe17930092a))

## [9.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.1.0...t8s-cluster-v9.1.1) (2025-03-04)


### Bug Fixes

* **t8s-cluster/management-cluster:** duplicated files ([#1401](https://github.com/teutonet/teutonet-helm-charts/issues/1401)) ([652abab](https://github.com/teutonet/teutonet-helm-charts/commit/652abab6b9ec998b1c9b4f1d8bf0949391db3834))

## [9.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.0.5...t8s-cluster-v9.1.0) (2025-03-04)


### Features

* **t8s-cluster/api-server:** add support for OIDC ([#1272](https://github.com/teutonet/teutonet-helm-charts/issues/1272)) ([164dcec](https://github.com/teutonet/teutonet-helm-charts/commit/164dcecf2754ca52d4d2de654b6fdae056cdd2a0))
* **t8s-cluster:** implement node-type specific securityGroupRules ([#1344](https://github.com/teutonet/teutonet-helm-charts/issues/1344)) ([c739f76](https://github.com/teutonet/teutonet-helm-charts/commit/c739f76a4e011d5b7c8541caf7013bfea5154cc5))


### Bug Fixes

* **t8s-cluster/management-cluster:** new spelling of field ([#1399](https://github.com/teutonet/teutonet-helm-charts/issues/1399)) ([9acca02](https://github.com/teutonet/teutonet-helm-charts/commit/9acca02ebe9e7acaa8cdf28e38d8406176ec6e17))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update common docker tag to v1.3.0 ([#1361](https://github.com/teutonet/teutonet-helm-charts/issues/1361)) ([d400b9c](https://github.com/teutonet/teutonet-helm-charts/commit/d400b9cc3118614dc520d166182c4a9c620bd19b))
* **t8s-cluster/dependencies:** update common docker tag to v1.4.0 ([#1393](https://github.com/teutonet/teutonet-helm-charts/issues/1393)) ([a3f5331](https://github.com/teutonet/teutonet-helm-charts/commit/a3f5331198af46c8be9f031d34a34f79fe08eac7))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.31.4-debian-12-r1 ([#1225](https://github.com/teutonet/teutonet-helm-charts/issues/1225)) ([9f62cfa](https://github.com/teutonet/teutonet-helm-charts/commit/9f62cfa658948a446cbac554c50cfc270b6a17f3))

## [9.0.5](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.0.4...t8s-cluster-v9.0.5) (2025-02-10)


### Bug Fixes

* **t8s-cluster/management-cluster:** add securityGroupRules for monitoring ([#1338](https://github.com/teutonet/teutonet-helm-charts/issues/1338)) ([1bf3c0f](https://github.com/teutonet/teutonet-helm-charts/commit/1bf3c0fba41e66b085137aaf5dfadd9144390f92))

## [9.0.4](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.0.3...t8s-cluster-v9.0.4) (2025-02-05)


### Bug Fixes

* **t8s-cluster/workload-cluster:** turn off bpf.masquerade ([#1332](https://github.com/teutonet/teutonet-helm-charts/issues/1332)) ([c8cfa12](https://github.com/teutonet/teutonet-helm-charts/commit/c8cfa1292f7836b9786225f36f62327c7559e471))

## [9.0.3](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.0.2...t8s-cluster-v9.0.3) (2025-01-31)


### Bug Fixes

* **t8s-cluster/workload-cluster:** allow all protocols for DNS ([#1305](https://github.com/teutonet/teutonet-helm-charts/issues/1305)) ([8e4caa2](https://github.com/teutonet/teutonet-helm-charts/commit/8e4caa28c926648cab5a24ccf87bb06be83eec0a))
* **t8s-cluster:** me be stupid I guess ([#1327](https://github.com/teutonet/teutonet-helm-charts/issues/1327)) ([d908dcc](https://github.com/teutonet/teutonet-helm-charts/commit/d908dccb9eafac4c815fcf9466eb98285b338f64))

## [9.0.2](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.0.1...t8s-cluster-v9.0.2) (2025-01-29)


### Bug Fixes

* **t8s-cluster/cni:** otherwise for &gt;=1.30 there is no version ([#1276](https://github.com/teutonet/teutonet-helm-charts/issues/1276)) ([20d0ad8](https://github.com/teutonet/teutonet-helm-charts/commit/20d0ad85974a5c5f640970a2f7d8ce92b000e237))
* **t8s-cluster:** use correct case for field ([#1317](https://github.com/teutonet/teutonet-helm-charts/issues/1317)) ([5861cd6](https://github.com/teutonet/teutonet-helm-charts/commit/5861cd62bd18d81dfa146efcbea0bb524828d7d8))

## [9.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v9.0.0...t8s-cluster-v9.0.1) (2024-12-19)


### Bug Fixes

* **t8s-cluster/management-cluster:** add missing necessary image field ([#1247](https://github.com/teutonet/teutonet-helm-charts/issues/1247)) ([e3910ca](https://github.com/teutonet/teutonet-helm-charts/commit/e3910cafa3bc792f68290ae0e4c03a31b6871f2e))


### Miscellaneous Chores

* **t8s-cluster/docs:** add correct vim modeline ([#1274](https://github.com/teutonet/teutonet-helm-charts/issues/1274)) ([3339f0b](https://github.com/teutonet/teutonet-helm-charts/commit/3339f0b2d560ba5f43cbdeaca44f5831dc7b388c))

## [9.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v8.3.2...t8s-cluster-v9.0.0) (2024-11-18)


### ⚠ BREAKING CHANGES

* **t8s-cluster/management-cluster:** update CAPIO and migrate config ([#1197](https://github.com/teutonet/teutonet-helm-charts/issues/1197))

### Features

* **t8s-cluster/cilium:** enable egressGateway ([#1223](https://github.com/teutonet/teutonet-helm-charts/issues/1223)) ([76fb7b0](https://github.com/teutonet/teutonet-helm-charts/commit/76fb7b045cf83866895d3a89319a796d9c8b8c48))


### Bug Fixes

* **base-cluster:** add missing ciliumNetworkPolicy for cinder-csi-plugin otherwise it can't talk to the openstack api 🤣 ([#1114](https://github.com/teutonet/teutonet-helm-charts/issues/1114)) ([f33e5ad](https://github.com/teutonet/teutonet-helm-charts/commit/f33e5ad2b613eb084c45ece2ef52c453c3c04b5e))
* **t8s-cluster/workload-cluster:** this field is _actually_ used 🙄 ([#1174](https://github.com/teutonet/teutonet-helm-charts/issues/1174)) ([16a5b12](https://github.com/teutonet/teutonet-helm-charts/commit/16a5b1216c895b7896ed4fb437dff9cb67e1489b))
* **t8s-cluster:** create separate etcd defrag jobs per cluster ([#1201](https://github.com/teutonet/teutonet-helm-charts/issues/1201)) ([948868e](https://github.com/teutonet/teutonet-helm-charts/commit/948868e738830e40e3283e90cdc4c590cd833a43))
* **t8s-cluster:** only `toYaml` if field exists ([#1227](https://github.com/teutonet/teutonet-helm-charts/issues/1227)) ([a98420d](https://github.com/teutonet/teutonet-helm-charts/commit/a98420d2467cc672df535518c84f70f2313757d6))
* **t8s-cluster:** remove unnecessary require for openstackImageNamePrefix ([#1229](https://github.com/teutonet/teutonet-helm-charts/issues/1229)) ([b9b2154](https://github.com/teutonet/teutonet-helm-charts/commit/b9b2154eacd0ef0ccff1d3724e1c9dadcdcdde08))
* **t8s-cluster:** up etcd-defrag timeout ([#1178](https://github.com/teutonet/teutonet-helm-charts/issues/1178)) ([292b156](https://github.com/teutonet/teutonet-helm-charts/commit/292b156d176ba652c126dd2da395874e1bed8eb2))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.8 ([#1137](https://github.com/teutonet/teutonet-helm-charts/issues/1137)) ([b343ce2](https://github.com/teutonet/teutonet-helm-charts/commit/b343ce2e97aafc98d280c0fda857db9b008342e8))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.31.0 ([#908](https://github.com/teutonet/teutonet-helm-charts/issues/908)) ([fa57c6e](https://github.com/teutonet/teutonet-helm-charts/commit/fa57c6e77e0054103cf12bbefd1818f1d45acae5))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.31.2 ([#1192](https://github.com/teutonet/teutonet-helm-charts/issues/1192)) ([5edddd7](https://github.com/teutonet/teutonet-helm-charts/commit/5edddd7614e9558d13ae56358efd8dcf23807d61))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl:1.29.6 docker digest to 6f94559 ([#1028](https://github.com/teutonet/teutonet-helm-charts/issues/1028)) ([88ea367](https://github.com/teutonet/teutonet-helm-charts/commit/88ea3678b2c6d3e0cec9b6a46a53c4dbee15691a))
* **t8s-cluster/dependencies:** update registry.k8s.io/etcd docker tag to v3.5.15 ([#1078](https://github.com/teutonet/teutonet-helm-charts/issues/1078)) ([bc79a2a](https://github.com/teutonet/teutonet-helm-charts/commit/bc79a2a6c14dfc5c42d43cfefd69c14c4bcf356f))
* **t8s-cluster/dependencies:** update registry.k8s.io/etcd docker tag to v3.5.16 ([#1211](https://github.com/teutonet/teutonet-helm-charts/issues/1211)) ([969e291](https://github.com/teutonet/teutonet-helm-charts/commit/969e2919d99ee7075df7c0a3a49f12df6d330de5))
* **t8s-cluster/management-cluster:** update CAPIO and migrate config ([#1197](https://github.com/teutonet/teutonet-helm-charts/issues/1197)) ([ff9248b](https://github.com/teutonet/teutonet-helm-charts/commit/ff9248b7b27aa9e03d8a491a6cf0d2ef122418cd))

## [8.3.2](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v8.3.1...t8s-cluster-v8.3.2) (2024-08-09)


### Bug Fixes

* **t8s-cluster/management-cluster:** replace `remove` with `add` `remove` doesn't work when the `path` doesn't exist 🤦 ([#1088](https://github.com/teutonet/teutonet-helm-charts/issues/1088)) ([850e3fd](https://github.com/teutonet/teutonet-helm-charts/commit/850e3fdcb17a1c0e6b8f1765825140f69b11f90d))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update common docker tag to v1.2.1 ([#1081](https://github.com/teutonet/teutonet-helm-charts/issues/1081)) ([88de484](https://github.com/teutonet/teutonet-helm-charts/commit/88de4843d045d0bd38fb75580fce8f5ead24ec36))

## [8.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v8.3.0...t8s-cluster-v8.3.1) (2024-08-09)


### Bug Fixes

* **t8s-cluster/management-cluster:** clean old config before applying new one if the old one stay, they might be incompatible now 🙄 ([#1087](https://github.com/teutonet/teutonet-helm-charts/issues/1087)) ([9ebc0ec](https://github.com/teutonet/teutonet-helm-charts/commit/9ebc0ecca3d6a6ee83766a293f7953d96b06a5a9))

## [8.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v8.2.0...t8s-cluster-v8.3.0) (2024-08-08)


### Features

* **t8s-cluster:** add support for HCP ([#962](https://github.com/teutonet/teutonet-helm-charts/issues/962)) ([4307b0b](https://github.com/teutonet/teutonet-helm-charts/commit/4307b0b5e4deb99698db563b1dca47b427fd8803))

## [8.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v8.1.0...t8s-cluster-v8.2.0) (2024-08-02)


### Features

* **t8s-cluster/workload-cluster:** latch onto legacy cni when used ([#1039](https://github.com/teutonet/teutonet-helm-charts/issues/1039)) ([3513061](https://github.com/teutonet/teutonet-helm-charts/commit/35130617c43764f2d4072ee79648f54c119c5e28))
* **t8s-cluster/workload-cluster:** skip component uninstall ([#1042](https://github.com/teutonet/teutonet-helm-charts/issues/1042)) ([139ac22](https://github.com/teutonet/teutonet-helm-charts/commit/139ac22f38ce2e701e646bf560c4a5cf82eaa74b))


### Bug Fixes

* **t8s-cluster:** use correct condition to include cilium helmrepository ([#1054](https://github.com/teutonet/teutonet-helm-charts/issues/1054)) ([0d1f7f8](https://github.com/teutonet/teutonet-helm-charts/commit/0d1f7f86c0461551f35785d7a16cb163aa8704a4))


### Miscellaneous Chores

* **t8s-cluster:** cleanup random stuff ([#1040](https://github.com/teutonet/teutonet-helm-charts/issues/1040)) ([d75da99](https://github.com/teutonet/teutonet-helm-charts/commit/d75da996cd287f49b64ccc4137f81acdd3aaa434))

## [8.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v8.0.0...t8s-cluster-v8.1.0) (2024-07-12)


### Features

* **t8s-cluster/management-cluster:** set a memory limit for the kube-apiserver, so things like kyverno won't take out the whole node ([#1025](https://github.com/teutonet/teutonet-helm-charts/issues/1025)) ([85dee99](https://github.com/teutonet/teutonet-helm-charts/commit/85dee99e4496f1731d9361ffdb580cd84a8f7b8c))
* **t8s-cluster/raise_api_version:** raise api version for helm.toolk… ([#984](https://github.com/teutonet/teutonet-helm-charts/issues/984)) ([ac8cf96](https://github.com/teutonet/teutonet-helm-charts/commit/ac8cf9691ab94715fd53f59695fdb27cd4ebe4b2))


### Bug Fixes

* **t8s-cluster:** adjust for 1.29 the SeccompDefault featureGate is enabled by default anyways ([#1036](https://github.com/teutonet/teutonet-helm-charts/issues/1036)) ([62078a9](https://github.com/teutonet/teutonet-helm-charts/commit/62078a9c58150fd1fd4586d41b53cdeab9148be7))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update common docker tag to v1.2.0 ([#882](https://github.com/teutonet/teutonet-helm-charts/issues/882)) ([14825a8](https://github.com/teutonet/teutonet-helm-charts/commit/14825a80ff76a4d415d7c55afa65622dc599fe11))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.6 ([#961](https://github.com/teutonet/teutonet-helm-charts/issues/961)) ([455f3e5](https://github.com/teutonet/teutonet-helm-charts/commit/455f3e5116bce1ce33e3b0f7cc8cb5bca592b8cb))
* **t8s-cluster/dependencies:** update registry.k8s.io/etcd docker tag to v3.5.14 ([#1013](https://github.com/teutonet/teutonet-helm-charts/issues/1013)) ([a0f31fd](https://github.com/teutonet/teutonet-helm-charts/commit/a0f31fd1e9326eccab4e4138b473cef2824944df))
* **t8s-cluster:** improve developer experience by providing tab-completion ([#1005](https://github.com/teutonet/teutonet-helm-charts/issues/1005)) ([e01ea6a](https://github.com/teutonet/teutonet-helm-charts/commit/e01ea6ad79d67bcee179ea4ffceccd630ac7b237))

## [8.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v7.0.1...t8s-cluster-v8.0.0) (2024-06-15)


### ⚠ BREAKING CHANGES

* **t8s-cluster:** remove unused gopassName field ([#922](https://github.com/teutonet/teutonet-helm-charts/issues/922))

### Bug Fixes

* **t8s-cluster/management-cluster:** remove uninstall job this should still work and help with the resource orphanage (HelmCharts, ...) ([#929](https://github.com/teutonet/teutonet-helm-charts/issues/929)) ([afbe7f0](https://github.com/teutonet/teutonet-helm-charts/commit/afbe7f00d05bdd4a8f047612be41fa99f630ebd8))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update helm release gpu-operator to v24 ([#920](https://github.com/teutonet/teutonet-helm-charts/issues/920)) ([70b8d59](https://github.com/teutonet/teutonet-helm-charts/commit/70b8d59e4fa699827d4aded52e1c0af9cd873adc))
* **t8s-cluster/dependencies:** update registry.k8s.io/etcd docker tag to v3.5.13 ([#892](https://github.com/teutonet/teutonet-helm-charts/issues/892)) ([5436cfa](https://github.com/teutonet/teutonet-helm-charts/commit/5436cfa3d7ca8f768699abb58d0d151f857545e4))
* **t8s-cluster/management-cluster:** update flux resources they are deprecated ([#930](https://github.com/teutonet/teutonet-helm-charts/issues/930)) ([29a7b8f](https://github.com/teutonet/teutonet-helm-charts/commit/29a7b8fed1124c610d8864689787a16c04f9deea))
* **t8s-cluster:** remove unused gopassName field ([#922](https://github.com/teutonet/teutonet-helm-charts/issues/922)) ([1a222bf](https://github.com/teutonet/teutonet-helm-charts/commit/1a222bf03b19e4f30bef344cc01ac8e95fd1ee2e))

## [7.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v7.0.0...t8s-cluster-v7.0.1) (2024-04-29)


### Miscellaneous Chores

* **t8s-cluster/management-cluster:** remove removed field ([#913](https://github.com/teutonet/teutonet-helm-charts/issues/913)) ([d30cf03](https://github.com/teutonet/teutonet-helm-charts/commit/d30cf038a751cca2b0b781fee1657f31eb132050))

## [7.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v6.0.1...t8s-cluster-v7.0.0) (2024-04-26)


### ⚠ BREAKING CHANGES

* **t8s-cluster/management-cluster:** Revert "feat(t8s-cluster/mana… ([#903](https://github.com/teutonet/teutonet-helm-charts/issues/903))

### Bug Fixes

* **t8s-cluster/workload-cluster:** helmrepository references ([#893](https://github.com/teutonet/teutonet-helm-charts/issues/893)) ([86c314d](https://github.com/teutonet/teutonet-helm-charts/commit/86c314dcc3db35fdc023935122940025b47261aa))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.4 ([#872](https://github.com/teutonet/teutonet-helm-charts/issues/872)) ([fe9037b](https://github.com/teutonet/teutonet-helm-charts/commit/fe9037b432f3bae6d790d1e23cd9dafa75d1f01d))
* **t8s-cluster/management-cluster:** Revert "feat(t8s-cluster/mana… ([#903](https://github.com/teutonet/teutonet-helm-charts/issues/903)) ([d59bc9e](https://github.com/teutonet/teutonet-helm-charts/commit/d59bc9e1dbeae46d10e816b2fcc8d9299f4ac9e4))

## [6.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v6.0.0...t8s-cluster-v6.0.1) (2024-04-15)


### Bug Fixes

* **t8s-cluster/management-cluster:** openstackImageNamePrefix ([#625](https://github.com/teutonet/teutonet-helm-charts/issues/625)) ([3ff1cf4](https://github.com/teutonet/teutonet-helm-charts/commit/3ff1cf43c27dd3a1e90358dcc71658a6a472b2e8))
* **t8s-cluster/management-cluster:** the branch is for pre-release and not for real releases ([#802](https://github.com/teutonet/teutonet-helm-charts/issues/802)) ([a85c39e](https://github.com/teutonet/teutonet-helm-charts/commit/a85c39ed55597cfa1c4314ff8c9381b46cf16db5))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.3 ([#789](https://github.com/teutonet/teutonet-helm-charts/issues/789)) ([d285efb](https://github.com/teutonet/teutonet-helm-charts/commit/d285efb5dcb42eabaee465894f894a267f8ccebb))
* **t8s-cluster/dependencies:** update helm release common to v2.19.0 ([#815](https://github.com/teutonet/teutonet-helm-charts/issues/815)) ([d9115bc](https://github.com/teutonet/teutonet-helm-charts/commit/d9115bc18b45eb70ebdbc19c2a6ad92801d5c9c0))
* **t8s-cluster/dependencies:** update helm release common to v2.19.1 ([#840](https://github.com/teutonet/teutonet-helm-charts/issues/840)) ([61fdd54](https://github.com/teutonet/teutonet-helm-charts/commit/61fdd54fdcc52fd5fb6f4731846ea94f4c69e918))
* **t8s-cluster/dependencies:** update registry.k8s.io/etcd docker tag to v3.5.12 ([#766](https://github.com/teutonet/teutonet-helm-charts/issues/766)) ([4b7a631](https://github.com/teutonet/teutonet-helm-charts/commit/4b7a631f917ce3a759fb413a2732a7749f310ef7))
* **t8s-cluster:** disallow versions above 28 ([#801](https://github.com/teutonet/teutonet-helm-charts/issues/801)) ([dbc02cf](https://github.com/teutonet/teutonet-helm-charts/commit/dbc02cf1944bab575abf6aad96ae48a27425cfd4))
* **t8s-cluster:** remove unneeded comment ([#846](https://github.com/teutonet/teutonet-helm-charts/issues/846)) ([a1119f8](https://github.com/teutonet/teutonet-helm-charts/commit/a1119f870c4ab9cba2e905f943e8ed7d027fe2d2))
* **t8s-cluster:** use teutonet common chart ([#856](https://github.com/teutonet/teutonet-helm-charts/issues/856)) ([7189ddf](https://github.com/teutonet/teutonet-helm-charts/commit/7189ddf7bf9b9b71a216d77696dfd72b3a794f23))

## [6.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v5.0.0...t8s-cluster-v6.0.0) (2024-02-29)


### ⚠ BREAKING CHANGES

* **t8s-cluster/management-cluster:** add environment parameter ([#806](https://github.com/teutonet/teutonet-helm-charts/issues/806))

### Features

* **t8s-cluster/management-cluster:** add environment parameter ([#806](https://github.com/teutonet/teutonet-helm-charts/issues/806)) ([e452f9e](https://github.com/teutonet/teutonet-helm-charts/commit/e452f9ed4317a17418689312fcab8b27e75931a1))
* **t8s-cluster/management-cluster:** automatically roll cluster if certs are going to expire ([#722](https://github.com/teutonet/teutonet-helm-charts/issues/722)) ([6fd3ab1](https://github.com/teutonet/teutonet-helm-charts/commit/6fd3ab163a00bf0c53ac94cc18bfad41f12ed1a3))
* **t8s-cluster:** update all HRs and enable driftDetection ([#774](https://github.com/teutonet/teutonet-helm-charts/issues/774)) ([139d6df](https://github.com/teutonet/teutonet-helm-charts/commit/139d6df254d547817bfa71aa681df24a79cc4612))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update helm release common to v2.16.1 ([#783](https://github.com/teutonet/teutonet-helm-charts/issues/783)) ([fb06ada](https://github.com/teutonet/teutonet-helm-charts/commit/fb06adade8d153c1fdb5998176dc7a57e33f7375))

## [5.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-4.1.0...t8s-cluster-v5.0.0) (2024-02-20)


### ⚠ BREAKING CHANGES

* **t8s-cluster/management-cluster:** migrate to new secret naming ([#795](https://github.com/teutonet/teutonet-helm-charts/issues/795))
* **t8s-cluster:** migrate to new image names ([#787](https://github.com/teutonet/teutonet-helm-charts/issues/787))

### Features

* add helmrelease schemas 😍 ([#792](https://github.com/teutonet/teutonet-helm-charts/issues/792)) ([89ed7eb](https://github.com/teutonet/teutonet-helm-charts/commit/89ed7eb540c647cb3e15b590d20a6a83331a61b7))
* **t8s-cluster/management-cluster:** migrate to new secret naming ([#795](https://github.com/teutonet/teutonet-helm-charts/issues/795)) ([edda640](https://github.com/teutonet/teutonet-helm-charts/commit/edda640e1ce8b5d60a601013b3bd6581dcfc047d))
* **t8s-cluster:** migrate to new image names ([#787](https://github.com/teutonet/teutonet-helm-charts/issues/787)) ([5137557](https://github.com/teutonet/teutonet-helm-charts/commit/513755798d5ae231670195f1f5cd3c6bf28f3fe2))


### Bug Fixes

* helmrelease-schemas ([#794](https://github.com/teutonet/teutonet-helm-charts/issues/794)) ([6544385](https://github.com/teutonet/teutonet-helm-charts/commit/65443857c75d07b245c14e05d1fae76f0c0de479))


### Miscellaneous Chores

* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#734](https://github.com/teutonet/teutonet-helm-charts/issues/734)) ([c5bbe56](https://github.com/teutonet/teutonet-helm-charts/commit/c5bbe5608dbc1274ae42d0d0bf8b753b333fa11e))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#737](https://github.com/teutonet/teutonet-helm-charts/issues/737)) ([829a379](https://github.com/teutonet/teutonet-helm-charts/commit/829a379f43824e1e49b220a871a7b92e53a50492))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#759](https://github.com/teutonet/teutonet-helm-charts/issues/759)) ([71639d0](https://github.com/teutonet/teutonet-helm-charts/commit/71639d0e57263f91b740220dab555f81fcaa0a86))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#790](https://github.com/teutonet/teutonet-helm-charts/issues/790)) ([1bce1a3](https://github.com/teutonet/teutonet-helm-charts/commit/1bce1a3061ecabf50cea46c62960fb0aaca29b10))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.1 ([#727](https://github.com/teutonet/teutonet-helm-charts/issues/727)) ([9727139](https://github.com/teutonet/teutonet-helm-charts/commit/9727139109211237e47f186bb6203e5b1d36b262))
* **t8s-cluster/dependencies:** update helm release common to v2.14.1 ([#693](https://github.com/teutonet/teutonet-helm-charts/issues/693)) ([b5630db](https://github.com/teutonet/teutonet-helm-charts/commit/b5630dba17e57e3d406c6ab18a39c2536cef980f))
* **t8s-cluster:** streamline imagePullPolicy ([#768](https://github.com/teutonet/teutonet-helm-charts/issues/768)) ([4c080a5](https://github.com/teutonet/teutonet-helm-charts/commit/4c080a552e23d08f55d3ffd189804028ef171b9c))

## [4.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-4.0.1...t8s-cluster-v4.1.0) (2024-01-18)


### Features

* **t8s-cluster/cinder-csi-plugin:** allow to run on control-plane ([#679](https://github.com/teutonet/teutonet-helm-charts/issues/679)) ([b7a4831](https://github.com/teutonet/teutonet-helm-charts/commit/b7a4831db903098ba34561df218a71aa124df58d))


### Bug Fixes

* **t8s-cluster:** allow greater than one gpu requests ([#638](https://github.com/teutonet/teutonet-helm-charts/issues/638)) ([a9553e8](https://github.com/teutonet/teutonet-helm-charts/commit/a9553e881db95c7f4db0ba0badf125202268494a))


### Miscellaneous Chores

* **main:** [bot] release t8s-cluster:4.1.0 ([#639](https://github.com/teutonet/teutonet-helm-charts/issues/639)) ([f8becdc](https://github.com/teutonet/teutonet-helm-charts/commit/f8becdca9a56d946ebc13940706b619f28c49d20))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#641](https://github.com/teutonet/teutonet-helm-charts/issues/641)) ([c87eed0](https://github.com/teutonet/teutonet-helm-charts/commit/c87eed01e25370cc4214962ab6f674c1449e425e))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#678](https://github.com/teutonet/teutonet-helm-charts/issues/678)) ([29bde5b](https://github.com/teutonet/teutonet-helm-charts/commit/29bde5b975bd44f28b8e60d0721c0d93f6ae0071))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#707](https://github.com/teutonet/teutonet-helm-charts/issues/707)) ([590321b](https://github.com/teutonet/teutonet-helm-charts/commit/590321b211d996d3726f678fdfdf5b3c02d61fb2))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.28.4 ([#629](https://github.com/teutonet/teutonet-helm-charts/issues/629)) ([0912613](https://github.com/teutonet/teutonet-helm-charts/commit/0912613e812ca4c0f4da995bddb31128808553e3))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.29.0 ([#705](https://github.com/teutonet/teutonet-helm-charts/issues/705)) ([4cfac13](https://github.com/teutonet/teutonet-helm-charts/commit/4cfac1379e132c6d163733a5e87d8139f3a130da))
* **t8s-cluster/dependencies:** update helm release common to v2.13.4 ([#683](https://github.com/teutonet/teutonet-helm-charts/issues/683)) ([3cd4ec4](https://github.com/teutonet/teutonet-helm-charts/commit/3cd4ec48506259c3f6b730399b5f7ace9f757433))
* **t8s-cluster/dependencies:** update registry.k8s.io/etcd docker tag to v3.5.10 ([#630](https://github.com/teutonet/teutonet-helm-charts/issues/630)) ([54a6512](https://github.com/teutonet/teutonet-helm-charts/commit/54a6512ddc6154edb3052587b55ee5d7f5ce5d17))
* **t8s-cluster/dependencies:** update registry.k8s.io/etcd docker tag to v3.5.11 ([#691](https://github.com/teutonet/teutonet-helm-charts/issues/691)) ([33b33f4](https://github.com/teutonet/teutonet-helm-charts/commit/33b33f472ec529272a38123a1b6dddd1054de7c6))

## [4.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-4.0.0...t8s-cluster-v4.0.1) (2023-11-17)


### Bug Fixes

* **t8s-cluster/management-cluster:** adjust containerd config to work with cgroupv2 ([#636](https://github.com/teutonet/teutonet-helm-charts/issues/636)) ([23f6e70](https://github.com/teutonet/teutonet-helm-charts/commit/23f6e70573de46c6c9e4f7162a7778482819069c))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update helm release common to v2.13.3 ([#616](https://github.com/teutonet/teutonet-helm-charts/issues/616)) ([f13471a](https://github.com/teutonet/teutonet-helm-charts/commit/f13471a619d5613863f7a4283a3d57d93a6512da))

## [4.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-3.4.0...t8s-cluster-v4.0.0) (2023-10-23)


### ⚠ BREAKING CHANGES

* **t8s-cluster/clusterClass:** configure static machineDeploymentClasses instead of one per computePlane ([#594](https://github.com/teutonet/teutonet-helm-charts/issues/594))

### Features

* **t8s-cluster/clusterClass:** configure static machineDeploymentClasses instead of one per computePlane ([#594](https://github.com/teutonet/teutonet-helm-charts/issues/594)) ([46aa22d](https://github.com/teutonet/teutonet-helm-charts/commit/46aa22d0581f8e5673aa22078e13d3736b881e7f))

## [3.4.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-3.3.0...t8s-cluster-v3.4.0) (2023-10-23)


### Features

* **t8s-cluster/management-cluster:** up the event ttl ([#611](https://github.com/teutonet/teutonet-helm-charts/issues/611)) ([4f0ed61](https://github.com/teutonet/teutonet-helm-charts/commit/4f0ed619c60f4d1260316c48f6c8fbbbff8559de))


### Bug Fixes

* **t8s-cluster/workload-cluster:** also upgrade gpu-operator CRDs ([#619](https://github.com/teutonet/teutonet-helm-charts/issues/619)) ([1b5b572](https://github.com/teutonet/teutonet-helm-charts/commit/1b5b5724042815a10752329d2b51e0594736dcff))


### Miscellaneous Chores

* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.28.2 ([#614](https://github.com/teutonet/teutonet-helm-charts/issues/614)) ([c875537](https://github.com/teutonet/teutonet-helm-charts/commit/c8755376361b8a64d8ae5ca244eda64b8a5c6f4e))

## [3.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-3.2.0...t8s-cluster-v3.3.0) (2023-09-27)


### Features

* **t8s-cluster/management-cluster:** make field availabilityZone optional ([#592](https://github.com/teutonet/teutonet-helm-charts/issues/592)) ([f94fc7a](https://github.com/teutonet/teutonet-helm-charts/commit/f94fc7a88f367767c751a14f3f1f00b1ac4c4ff7))

## [3.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-3.1.0...t8s-cluster-v3.2.0) (2023-09-26)


### Features

* **t8s-cluster/workload-cluster:** configure gpu time slicing ([#575](https://github.com/teutonet/teutonet-helm-charts/issues/575)) ([32fb616](https://github.com/teutonet/teutonet-helm-charts/commit/32fb61621a122b8b53753b3abbf7c05b655fe165))


### Bug Fixes

* **t8s-cluster/management-cluster:** labels ([#590](https://github.com/teutonet/teutonet-helm-charts/issues/590)) ([de72cbc](https://github.com/teutonet/teutonet-helm-charts/commit/de72cbc8f08b8aa10c40074f06a56cbfc1869a53))

## [3.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-3.0.1...t8s-cluster-v3.1.0) (2023-09-19)


### Features

* **t8s-cluster/workload-cluster:** add a higher timeout for upgrading ([#567](https://github.com/teutonet/teutonet-helm-charts/issues/567)) ([c5cb979](https://github.com/teutonet/teutonet-helm-charts/commit/c5cb979bffe15c8d811fae944df97619ffb83d9a))


### Bug Fixes

* **t8s-cluster/gpu-operator:** fix worker affinity ([#572](https://github.com/teutonet/teutonet-helm-charts/issues/572)) ([e8bc84b](https://github.com/teutonet/teutonet-helm-charts/commit/e8bc84be710b77e1d9cd511a0bba32cfbe95f2c6))


### Miscellaneous Chores

* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#573](https://github.com/teutonet/teutonet-helm-charts/issues/573)) ([8b6f934](https://github.com/teutonet/teutonet-helm-charts/commit/8b6f93459845efeb97953c3df83d71106783f3eb))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.27.6 ([#577](https://github.com/teutonet/teutonet-helm-charts/issues/577)) ([c8f4142](https://github.com/teutonet/teutonet-helm-charts/commit/c8f414209d64193cadfaec86800fc3a59e4d9cd6))
* **t8s-cluster/dependencies:** update helm release common to v2.11.0 ([#569](https://github.com/teutonet/teutonet-helm-charts/issues/569)) ([805eceb](https://github.com/teutonet/teutonet-helm-charts/commit/805eceb14f79e556f572740259a91c64396db9bd))

## [3.0.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-3.0.0...t8s-cluster-v3.0.1) (2023-09-12)


### Bug Fixes

* **t8s-cluster/kubeadmConfigTemplate:** gitlab registry does no play nice with mirrors ([#570](https://github.com/teutonet/teutonet-helm-charts/issues/570)) ([d2230e6](https://github.com/teutonet/teutonet-helm-charts/commit/d2230e606741101a87cd2c24f46fda69c6838f67))


### Miscellaneous Chores

* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#544](https://github.com/teutonet/teutonet-helm-charts/issues/544)) ([f70116e](https://github.com/teutonet/teutonet-helm-charts/commit/f70116e15a76b14a2d52cd5c270bce4b88518081))
* **t8s-cluster/dependencies:** update helm release common to v2.10.1 ([#563](https://github.com/teutonet/teutonet-helm-charts/issues/563)) ([5a479d9](https://github.com/teutonet/teutonet-helm-charts/commit/5a479d986fafb82d5eb237997dce253266f8322a))
* **t8s-cluster/dependencies:** update helm release common to v2.9.2 ([#560](https://github.com/teutonet/teutonet-helm-charts/issues/560)) ([727d5ad](https://github.com/teutonet/teutonet-helm-charts/commit/727d5ad06ff2f026accd0a84b6fec4248651dce1))

## [3.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-2.0.0...t8s-cluster-v3.0.0) (2023-09-11)


### ⚠ BREAKING CHANGES

* **t8s-cluster:** change `proxy` to `mirror` ([#559](https://github.com/teutonet/teutonet-helm-charts/issues/559))

### Features

* **t8s-cluster/management-cluster:** add support for gpu nodes ([#499](https://github.com/teutonet/teutonet-helm-charts/issues/499)) ([7552b66](https://github.com/teutonet/teutonet-helm-charts/commit/7552b667c222fe99c28cffc494f30ec77e72e6f7))
* **t8s-cluster/management-cluster:** don't surge GPU nodes ([#549](https://github.com/teutonet/teutonet-helm-charts/issues/549)) ([a08d394](https://github.com/teutonet/teutonet-helm-charts/commit/a08d39469d68ac739ae79730140603c8ed7a0df4))
* **t8s-cluster/management-cluster:** replace harbor mirror syntax with standard OCI syntax ([#532](https://github.com/teutonet/teutonet-helm-charts/issues/532)) ([7e4af4e](https://github.com/teutonet/teutonet-helm-charts/commit/7e4af4ed2459cf25c9e6825dfe159581519889be))
* **t8s-cluster/management-cluster:** simplify k8s version check ([#548](https://github.com/teutonet/teutonet-helm-charts/issues/548)) ([f0d4b31](https://github.com/teutonet/teutonet-helm-charts/commit/f0d4b3135f806286701e8c6a09f9ebfb45099b08))
* **t8s-cluster/management-cluster:** validate new k8s version before upgrade ([#508](https://github.com/teutonet/teutonet-helm-charts/issues/508)) ([a3922e5](https://github.com/teutonet/teutonet-helm-charts/commit/a3922e533213275b3958b288df271b8dc9aa3ede))
* **t8s-cluster/workload-cluster:** add priorityClassName to critical components ([#540](https://github.com/teutonet/teutonet-helm-charts/issues/540)) ([00f5d9b](https://github.com/teutonet/teutonet-helm-charts/commit/00f5d9b5823140ef5e7812c0c809ea4f36daffe7))
* **t8s-cluster:** change `proxy` to `mirror` ([#559](https://github.com/teutonet/teutonet-helm-charts/issues/559)) ([e405d74](https://github.com/teutonet/teutonet-helm-charts/commit/e405d74bf6a8ee23f08e6eb18372b3319f0f1de3))


### Bug Fixes

* **t8s-cluster/workload-cluster:** cleanup of storageclasses ([#492](https://github.com/teutonet/teutonet-helm-charts/issues/492)) ([138c185](https://github.com/teutonet/teutonet-helm-charts/commit/138c18573854de95807719f9792bdba17c2ff2c2))
* **t8s-cluster/workload-cluster:** dependency on cni helmrelease ([#550](https://github.com/teutonet/teutonet-helm-charts/issues/550)) ([a54108d](https://github.com/teutonet/teutonet-helm-charts/commit/a54108d1d60bf63512b865ad0999460728ada3b2))


### Miscellaneous Chores

* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.4 ([#484](https://github.com/teutonet/teutonet-helm-charts/issues/484)) ([3e73e61](https://github.com/teutonet/teutonet-helm-charts/commit/3e73e61caa0bf590116db7958f34aeff8c231d7e))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#490](https://github.com/teutonet/teutonet-helm-charts/issues/490)) ([4ab441d](https://github.com/teutonet/teutonet-helm-charts/commit/4ab441d6cfdc54bf03561785b3ec79afa43725a6))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#527](https://github.com/teutonet/teutonet-helm-charts/issues/527)) ([9522b32](https://github.com/teutonet/teutonet-helm-charts/commit/9522b32a1876d4517669b8897ed37a57fc9f8ff0))
* **t8s-cluster/dependencies:** update docker.io/bitnami/kubectl docker tag to v1.27.5 ([#536](https://github.com/teutonet/teutonet-helm-charts/issues/536)) ([835d15e](https://github.com/teutonet/teutonet-helm-charts/commit/835d15e927c82cdd4ef7787d6f9e787f0e1f2266))
* **t8s-cluster/dependencies:** update helm release common to v2.9.0 ([#514](https://github.com/teutonet/teutonet-helm-charts/issues/514)) ([01bae27](https://github.com/teutonet/teutonet-helm-charts/commit/01bae271440a3e694c687d08ce4cb7f65f4f07e8))
* **t8s-cluster/dependencies:** update helm release common to v2.9.1 ([#537](https://github.com/teutonet/teutonet-helm-charts/issues/537)) ([264405b](https://github.com/teutonet/teutonet-helm-charts/commit/264405b33e99c50c463a31dbdacad07c0a8bacff))
* **t8s-cluster/management-cluster:** migrate containerd registry mirror config ([#494](https://github.com/teutonet/teutonet-helm-charts/issues/494)) ([be41141](https://github.com/teutonet/teutonet-helm-charts/commit/be41141e364692df4761ad7b2cc53ed8c9709fc7))
* **t8s-cluster:** remove steutol ([#542](https://github.com/teutonet/teutonet-helm-charts/issues/542)) ([5f6d5fc](https://github.com/teutonet/teutonet-helm-charts/commit/5f6d5fc46c6b94f820ce4623821a9376daadebec))

## [2.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.3.3...t8s-cluster-v2.0.0) (2023-08-15)


### ⚠ BREAKING CHANGES

* **t8s-cluster/management-cluster:** always set ([#422](https://github.com/teutonet/teutonet-helm-charts/issues/422))

### Features

* **t8s-cluster/clusterClass:** adjust machineDeployment rolling ([#445](https://github.com/teutonet/teutonet-helm-charts/issues/445)) ([8adb3e3](https://github.com/teutonet/teutonet-helm-charts/commit/8adb3e3f50163bd5f2529dc79eaa68266d4dde82))
* **t8s-cluster/management-cluster:** add friendlyName field instead of cluster name ([#486](https://github.com/teutonet/teutonet-helm-charts/issues/486)) ([fc2c15d](https://github.com/teutonet/teutonet-helm-charts/commit/fc2c15dd793f771c022a3914224a5e20651971d1))
* **t8s-cluster/management-cluster:** adjust machineHealthCheck ([#466](https://github.com/teutonet/teutonet-helm-charts/issues/466)) ([347bbaa](https://github.com/teutonet/teutonet-helm-charts/commit/347bbaa52245248db626925ff78a4742958331eb))
* **t8s-cluster/management-cluster:** cleanup for uninstallation ([#481](https://github.com/teutonet/teutonet-helm-charts/issues/481)) ([c4a2a57](https://github.com/teutonet/teutonet-helm-charts/commit/c4a2a57e3628f8f0320f60105d642bf68c475ba3))
* **t8s-cluster/workload-cluster:** adjust install order after CNI ([#467](https://github.com/teutonet/teutonet-helm-charts/issues/467)) ([e875f2f](https://github.com/teutonet/teutonet-helm-charts/commit/e875f2fb74058c68bd29e22252afdc3fc1270e84))
* **t8s-cluster:** Allow for parallel image pulling with k8s v1.27 ([#441](https://github.com/teutonet/teutonet-helm-charts/issues/441)) ([e54aaa3](https://github.com/teutonet/teutonet-helm-charts/commit/e54aaa36903383122a8ea65b36c0858f083bd3ae))


### Bug Fixes

* **t8s-cluster/clusterClass:** fix parallel image pulling ([#449](https://github.com/teutonet/teutonet-helm-charts/issues/449)) ([42f5179](https://github.com/teutonet/teutonet-helm-charts/commit/42f517914710eb545a933e01fe90f7874ea9841e))
* **t8s-cluster/clusterClass:** fix redundant rolling of machines ([#443](https://github.com/teutonet/teutonet-helm-charts/issues/443)) ([c025032](https://github.com/teutonet/teutonet-helm-charts/commit/c02503260a4e2793a7f9ff66415f40ae96f6585b))
* **t8s-cluster/management-cluster:** always set ([#422](https://github.com/teutonet/teutonet-helm-charts/issues/422)) ([0364c87](https://github.com/teutonet/teutonet-helm-charts/commit/0364c872d3cfd5d649532784ffc1d41e425c08f5))
* **t8s-cluster/management-cluster:** fix kubelet configuration ([#457](https://github.com/teutonet/teutonet-helm-charts/issues/457)) ([ce68e68](https://github.com/teutonet/teutonet-helm-charts/commit/ce68e68f5056d3d0cbca8782db1d7cf80429be8f))
* **t8s-cluster/workload-cluster:** add pre-upgrade to missing resources ([#399](https://github.com/teutonet/teutonet-helm-charts/issues/399)) ([9a0926c](https://github.com/teutonet/teutonet-helm-charts/commit/9a0926ceea1b0581f6a90cfbb6eb139d65bd19e4))
* **t8s-cluster/workload-cluster:** fix storageclass cleanup ([#465](https://github.com/teutonet/teutonet-helm-charts/issues/465)) ([b56fb73](https://github.com/teutonet/teutonet-helm-charts/commit/b56fb733305142cc276e90ba5ed98fdc908d4d5c))


### Miscellaneous Chores

* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.2 ([#421](https://github.com/teutonet/teutonet-helm-charts/issues/421)) ([4d0fcd7](https://github.com/teutonet/teutonet-helm-charts/commit/4d0fcd7bf5a45cdac602670908b1f8a0de9ce914))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.3 ([#447](https://github.com/teutonet/teutonet-helm-charts/issues/447)) ([dcb099d](https://github.com/teutonet/teutonet-helm-charts/commit/dcb099da6d49ea24aa9208a4834214b6c5967d6b))
* **deps:** update helm release common to v2.4.0 ([#419](https://github.com/teutonet/teutonet-helm-charts/issues/419)) ([a2eef0a](https://github.com/teutonet/teutonet-helm-charts/commit/a2eef0aae49cef3be171c610ff8146b9b2b6fb65))
* **deps:** update helm release common to v2.5.0 ([#462](https://github.com/teutonet/teutonet-helm-charts/issues/462)) ([03b6520](https://github.com/teutonet/teutonet-helm-charts/commit/03b652030040e01dcdef4c5fbe3992b48f781bc8))
* **deps:** update helm release common to v2.6.0 ([#468](https://github.com/teutonet/teutonet-helm-charts/issues/468)) ([ecb2102](https://github.com/teutonet/teutonet-helm-charts/commit/ecb2102b141d0e7d27fb476ca3e102719c461eee))
* **deps:** update registry.k8s.io/etcd docker tag to v3.5.9 ([#406](https://github.com/teutonet/teutonet-helm-charts/issues/406)) ([f29d2fa](https://github.com/teutonet/teutonet-helm-charts/commit/f29d2fa50d201d574d047db89867c8af6f2832ef))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#437](https://github.com/teutonet/teutonet-helm-charts/issues/437)) ([3d03cc1](https://github.com/teutonet/teutonet-helm-charts/commit/3d03cc130bee0bb079a07e185df1c3baba191cf9))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#446](https://github.com/teutonet/teutonet-helm-charts/issues/446)) ([f60a61c](https://github.com/teutonet/teutonet-helm-charts/commit/f60a61c02ce6935e47aa3acdbf23e47a237cf419))

## [1.3.3](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.3.2...t8s-cluster-v1.3.3) (2023-05-10)


### Bug Fixes

* **t8s-cluster/cloud-controller-manager:** Don't use service-account credentials ([#412](https://github.com/teutonet/teutonet-helm-charts/issues/412)) ([151960c](https://github.com/teutonet/teutonet-helm-charts/commit/151960c46af84cd16c29d687e9ed9337d17dbd8d))

## [1.3.2](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.3.1...t8s-cluster-v1.3.2) (2023-05-10)


### Bug Fixes

* **t8s-cluster/management-cluster:** kubeadmConfigTemplate templating ([#414](https://github.com/teutonet/teutonet-helm-charts/issues/414)) ([ef79f61](https://github.com/teutonet/teutonet-helm-charts/commit/ef79f61e6aa8d5dc585711fc396f9012b0499415))

## [1.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.3.0...t8s-cluster-v1.3.1) (2023-05-10)


### Bug Fixes

* **t8s-cluster/management-cluster:** add injected-ca-certs for compute nodes ([#411](https://github.com/teutonet/teutonet-helm-charts/issues/411)) ([0ea4dd3](https://github.com/teutonet/teutonet-helm-charts/commit/0ea4dd3047a7532106f4e22483a83d15202c4446))

## [1.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.2.1...t8s-cluster-v1.3.0) (2023-05-10)


### Features

* **t8s-cluster/management-cluster:** allow managing injectedCertificateAuthorities via flux ([#410](https://github.com/teutonet/teutonet-helm-charts/issues/410)) ([3076eb5](https://github.com/teutonet/teutonet-helm-charts/commit/3076eb5f9fe9f8c322bd403bc3e50aba91d5eec2))


### Bug Fixes

* **t8s-cluster/management-cluster:** only add the supported fields instead of all ([#408](https://github.com/teutonet/teutonet-helm-charts/issues/408)) ([b972067](https://github.com/teutonet/teutonet-helm-charts/commit/b972067c7092ffbd84f78aee7c6ccc991c4548e2))

## [1.2.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.2.0...t8s-cluster-v1.2.1) (2023-05-08)


### Bug Fixes

* **t8s-cluster/management-cluster:** fix conditional patch ([#395](https://github.com/teutonet/teutonet-helm-charts/issues/395)) ([ebb3e69](https://github.com/teutonet/teutonet-helm-charts/commit/ebb3e69744525fd4353eb0845025eec76c3cdfb7))


### Miscellaneous Chores

* **deps:** update helm release common to v2.2.5 ([#383](https://github.com/teutonet/teutonet-helm-charts/issues/383)) ([6205753](https://github.com/teutonet/teutonet-helm-charts/commit/620575318783563c30ae38e436208f3ba24aa203))

## [1.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.1.0...t8s-cluster-v1.2.0) (2023-05-08)


### Features

* **t8s-cluster/ci:** add scripts, deduplicate values ([#356](https://github.com/teutonet/teutonet-helm-charts/issues/356)) ([8dc7ce5](https://github.com/teutonet/teutonet-helm-charts/commit/8dc7ce5d0721897584b385a24f97a5232bce63a8))
* **t8s-cluster/management-cluster:** allow setting the allowedCidrs of the openStackClusterTemplate ([#331](https://github.com/teutonet/teutonet-helm-charts/issues/331)) ([13d0b0a](https://github.com/teutonet/teutonet-helm-charts/commit/13d0b0ac8f03b7f9f0683f11b5a5fe204c23ae3b))


### Bug Fixes

* **t8s-cluster/management-cluster:** bump CAPO apiVersion ([#329](https://github.com/teutonet/teutonet-helm-charts/issues/329)) ([c540ad2](https://github.com/teutonet/teutonet-helm-charts/commit/c540ad2839b4977fda6839993598a2b45a5dbdad))
* **t8s-cluster/workload-cluster:** add `list` to rbac, otherwise job … ([#373](https://github.com/teutonet/teutonet-helm-charts/issues/373)) ([4670eae](https://github.com/teutonet/teutonet-helm-charts/commit/4670eaee1ca0cc20a3fb14c421667c233b36f644))
* **t8s-cluster/workload-cluster:** add missing uninstall job for the storageclasses ([#390](https://github.com/teutonet/teutonet-helm-charts/issues/390)) ([691ebc9](https://github.com/teutonet/teutonet-helm-charts/commit/691ebc929c7e581688d081c9df5de825b9593dad))

## [1.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-1.0.0...t8s-cluster-v1.1.0) (2023-04-24)


### Features

* **t8s-cluster/workload-cluster:** install ccm/csi via helm to inline-reuse the cloud-config secret ([#324](https://github.com/teutonet/teutonet-helm-charts/issues/324)) ([f7e9f6b](https://github.com/teutonet/teutonet-helm-charts/commit/f7e9f6b47dff6264468a314d6c0f8be8e544bacc))
* **t8s-cluster:** prepare for flux drift-detection ([#322](https://github.com/teutonet/teutonet-helm-charts/issues/322)) ([4cccb6d](https://github.com/teutonet/teutonet-helm-charts/commit/4cccb6d4cc33b2b4ab38095af48b6aa6c4007095))


### Miscellaneous Chores

* **deps:** update docker.io/bitnami/kubectl docker tag to v1.27.1 ([#351](https://github.com/teutonet/teutonet-helm-charts/issues/351)) ([3a22fce](https://github.com/teutonet/teutonet-helm-charts/commit/3a22fceb617b8e5f0eb18e104f104070e65649b6))

## [1.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.3.3...t8s-cluster-v1.0.0) (2023-04-05)


### ⚠ BREAKING CHANGES

* **t8s-cluster:** wrong type for customerID, should be int ([#302](https://github.com/teutonet/teutonet-helm-charts/issues/302))

### Features

* **t8s-cluster/etcd-defrag:** refactor image into values.yaml ([#304](https://github.com/teutonet/teutonet-helm-charts/issues/304)) ([b7095c5](https://github.com/teutonet/teutonet-helm-charts/commit/b7095c5c9cffe20f475da74bea081760a43a39ad)), closes [#297](https://github.com/teutonet/teutonet-helm-charts/issues/297)
* **t8s-cluster/management-cluster:** keep retrying installing the ([#292](https://github.com/teutonet/teutonet-helm-charts/issues/292)) ([54e1d5e](https://github.com/teutonet/teutonet-helm-charts/commit/54e1d5ef6b8905e630b779962428df7e19dc1283))
* **t8s-cluster/management-cluster:** use v1alpha6 instead v1alpha5 ([#305](https://github.com/teutonet/teutonet-helm-charts/issues/305)) ([4ff4763](https://github.com/teutonet/teutonet-helm-charts/commit/4ff4763de64e4405c406e59228427c9abfafa5f8))
* **t8s-cluster/workload-cluster:** remove local-storage StorageClass ([#335](https://github.com/teutonet/teutonet-helm-charts/issues/335)) ([fea935f](https://github.com/teutonet/teutonet-helm-charts/commit/fea935fb2a71b930a5402a3edc593414fe5b3749))
* **t8s-cluster:** update CODEOWNERS ([#333](https://github.com/teutonet/teutonet-helm-charts/issues/333)) ([5f445d3](https://github.com/teutonet/teutonet-helm-charts/commit/5f445d3ed56cfbd9f97fc6d84124cf10a2a88c1b))


### Bug Fixes

* **t8s-cluster:** wrong type for customerID, should be int ([#302](https://github.com/teutonet/teutonet-helm-charts/issues/302)) ([7b9e609](https://github.com/teutonet/teutonet-helm-charts/commit/7b9e609d265a10c6ea164ce8ded17351be3fb00d))


### Miscellaneous Chores

* **deps:** update helm release common to v2.2.4 ([#264](https://github.com/teutonet/teutonet-helm-charts/issues/264)) ([4e4f4ed](https://github.com/teutonet/teutonet-helm-charts/commit/4e4f4edcceeec46b2df23f3e2d9d152d296f8933))
* **deps:** update registry.k8s.io/etcd docker tag to v3.5.7 ([#325](https://github.com/teutonet/teutonet-helm-charts/issues/325)) ([9b6ace1](https://github.com/teutonet/teutonet-helm-charts/commit/9b6ace1d70deb6b4fe4d0a21a1e53eee1bc66573))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#315](https://github.com/teutonet/teutonet-helm-charts/issues/315)) ([d479c5e](https://github.com/teutonet/teutonet-helm-charts/commit/d479c5e7e1abc5a6d300a3eac079546df2c599c6))

## [0.3.3](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v0.3.2...t8s-cluster-v0.3.3) (2023-03-14)


### Bug Fixes

* **t8s-cluster/management-cluster:** ignore machine images for artifa… ([#281](https://github.com/teutonet/teutonet-helm-charts/issues/281)) ([47bfe4c](https://github.com/teutonet/teutonet-helm-charts/commit/47bfe4cd48874eedf9cea7d8de798097102cdad9))
* **t8s-cluster/workload-cluster:** change names 😅 *again* ([#240](https://github.com/teutonet/teutonet-helm-charts/issues/240)) ([54198b2](https://github.com/teutonet/teutonet-helm-charts/commit/54198b22045d1e4ea8af2689cbf00a7fb5b670c2))


### Miscellaneous Chores

* **main:** [bot] release t8s-cluster:0.3.2 ([#277](https://github.com/teutonet/teutonet-helm-charts/issues/277)) ([c7e83f0](https://github.com/teutonet/teutonet-helm-charts/commit/c7e83f0894a4b103d93fb4970ead27c64b7771d3))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#272](https://github.com/teutonet/teutonet-helm-charts/issues/272)) ([9b4270a](https://github.com/teutonet/teutonet-helm-charts/commit/9b4270ac347ca676a4c0f07f0d1c1851debf4509))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#287](https://github.com/teutonet/teutonet-helm-charts/issues/287)) ([0ada4a3](https://github.com/teutonet/teutonet-helm-charts/commit/0ada4a3b8167eec758ddaab16ef7f6c3e462ef73))

## [0.3.2](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.3.1...t8s-cluster-v0.3.2) (2023-03-13)


### Bug Fixes

* **t8s-cluster/management-cluster:** ignore machine images for artifa… ([#281](https://github.com/teutonet/teutonet-helm-charts/issues/281)) ([47bfe4c](https://github.com/teutonet/teutonet-helm-charts/commit/47bfe4cd48874eedf9cea7d8de798097102cdad9))


### Miscellaneous Chores

* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#272](https://github.com/teutonet/teutonet-helm-charts/issues/272)) ([9b4270a](https://github.com/teutonet/teutonet-helm-charts/commit/9b4270ac347ca676a4c0f07f0d1c1851debf4509))
* **t8s-cluster/artifacthub-images:** Update ArtifactHUB images ([#287](https://github.com/teutonet/teutonet-helm-charts/issues/287)) ([0ada4a3](https://github.com/teutonet/teutonet-helm-charts/commit/0ada4a3b8167eec758ddaab16ef7f6c3e462ef73))

## [0.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.3.0...t8s-cluster-v0.3.1) (2023-03-08)


### Bug Fixes

* **t8s-cluster/management-cluster:** remove wrong bastion field ([#266](https://github.com/teutonet/teutonet-helm-charts/issues/266)) ([88ce007](https://github.com/teutonet/teutonet-helm-charts/commit/88ce00734802ea862ffd7878929be84a3c79a27f))

## [0.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.2.0...t8s-cluster-v0.3.0) (2023-03-07)


### Features

* **t8s-cluster:** add calico CNI as an option ([#261](https://github.com/teutonet/teutonet-helm-charts/issues/261)) ([61a5087](https://github.com/teutonet/teutonet-helm-charts/commit/61a5087520dc8d8a0402e2e0a56e386e8023a6a0))


### Bug Fixes

* **t8s-cluster/clusterClass:** only patch controlPlaneAvailabilityZones ([#257](https://github.com/teutonet/teutonet-helm-charts/issues/257)) ([da8f3a9](https://github.com/teutonet/teutonet-helm-charts/commit/da8f3a9447b38500917e9c7f100aeb0dafff5d94))

## [0.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.1.3...t8s-cluster-v0.2.0) (2023-03-03)


### Features

* **t8s-cluster/clusterClass:** include clusterClass ([#209](https://github.com/teutonet/teutonet-helm-charts/issues/209)) ([7aaa8b5](https://github.com/teutonet/teutonet-helm-charts/commit/7aaa8b58caecdc4e8c59bf1291e4982a7354e2c7))

## [0.1.3](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.1.2...t8s-cluster-v0.1.3) (2023-02-28)


### Bug Fixes

* **t8s-cluster/workload-cluster:** shorten releaseNames ([#238](https://github.com/teutonet/teutonet-helm-charts/issues/238)) ([f84917f](https://github.com/teutonet/teutonet-helm-charts/commit/f84917ff8b3b45cb99cefac45261cb285ad6a65b))

## [0.1.2](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.1.1...t8s-cluster-v0.1.2) (2023-02-28)


### Bug Fixes

* **t8s-cluster/workload-cluster:** change HelmRelease names to contain ([#229](https://github.com/teutonet/teutonet-helm-charts/issues/229)) ([9811053](https://github.com/teutonet/teutonet-helm-charts/commit/981105389153b43a149f47c2a2661257dc66998d))

## [0.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.1.0...t8s-cluster-v0.1.1) (2023-02-24)


### Bug Fixes

* **t8s-cluster:** use correct kubeConfig secret name ([#223](https://github.com/teutonet/teutonet-helm-charts/issues/223)) ([24a5685](https://github.com/teutonet/teutonet-helm-charts/commit/24a5685a8fd80e8ee954793a3fa7d2e65e883cb4))

## [0.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-v0.0.2...t8s-cluster-v0.1.0) (2023-02-10)


### Features

* **t8s-cluster:** add new helm chart ([#169](https://github.com/teutonet/teutonet-helm-charts/issues/169)) ([9f3f26d](https://github.com/teutonet/teutonet-helm-charts/commit/9f3f26d01e41fb57ba811c33f22766a5644c91e3))


### Bug Fixes

* **t8s-cluster/artifacthub-images:** fix values ([#177](https://github.com/teutonet/teutonet-helm-charts/issues/177)) ([9b775ec](https://github.com/teutonet/teutonet-helm-charts/commit/9b775ec67f73a6c361e4369213b7dc196596995b))
* **t8s-cluster/cni:** fix HelmRepository reference ([#181](https://github.com/teutonet/teutonet-helm-charts/issues/181)) ([0fb2a81](https://github.com/teutonet/teutonet-helm-charts/commit/0fb2a8150b3b745f43a5295eaa500ba7f555c083))
* **t8s-cluster:** remove serviceAccountName for HelmReleases ([#190](https://github.com/teutonet/teutonet-helm-charts/issues/190)) ([23b554e](https://github.com/teutonet/teutonet-helm-charts/commit/23b554ed444e9b57d5720b11b1e26351e954be79))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([b6e37be](https://github.com/teutonet/teutonet-helm-charts/commit/b6e37be298771915ca1b8f8a43c2004fe6cc0f5d))
* **deps:** update helm release common to v2.2.3 ([#189](https://github.com/teutonet/teutonet-helm-charts/issues/189)) ([ea07b8a](https://github.com/teutonet/teutonet-helm-charts/commit/ea07b8a8f68197f55a5d85bcdf881f71c63578ae))
* **main:** [bot] release base-cluster:3.1.0 ([#159](https://github.com/teutonet/teutonet-helm-charts/issues/159)) ([552676f](https://github.com/teutonet/teutonet-helm-charts/commit/552676ff2a7d1a7b8b54101f094f84822ddfae95))
* **main:** [bot] release t8s-cluster:0.0.2 ([#197](https://github.com/teutonet/teutonet-helm-charts/issues/197)) ([ab12e74](https://github.com/teutonet/teutonet-helm-charts/commit/ab12e74e164afe814104dfc82a229a0e793b8b95))

## [0.0.2](https://github.com/teutonet/teutonet-helm-charts/compare/t8s-cluster-0.0.1...t8s-cluster-v0.0.2) (2023-02-10)


### Bug Fixes

* **t8s-cluster:** remove serviceAccountName for HelmReleases ([#190](https://github.com/teutonet/teutonet-helm-charts/issues/190)) ([23b554e](https://github.com/teutonet/teutonet-helm-charts/commit/23b554ed444e9b57d5720b11b1e26351e954be79))


### Miscellaneous Chores

* **base-cluster:** Update images in 'Chart.yaml' ([b6e37be](https://github.com/teutonet/teutonet-helm-charts/commit/b6e37be298771915ca1b8f8a43c2004fe6cc0f5d))
* **deps:** update helm release common to v2.2.3 ([#189](https://github.com/teutonet/teutonet-helm-charts/issues/189)) ([ea07b8a](https://github.com/teutonet/teutonet-helm-charts/commit/ea07b8a8f68197f55a5d85bcdf881f71c63578ae))
