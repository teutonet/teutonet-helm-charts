# Changelog

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
