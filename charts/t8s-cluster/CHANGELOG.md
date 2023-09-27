# Changelog

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
