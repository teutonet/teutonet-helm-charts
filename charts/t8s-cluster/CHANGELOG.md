# Changelog

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
