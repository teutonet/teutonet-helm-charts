# Changelog

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
