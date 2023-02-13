# Changelog

## [4.0.0](https://github.com/teutonet/teutonet-helm-charts/compare/base-cluster-v3.3.0...base-cluster-v4.0.0) (2023-02-13)


### ⚠ BREAKING CHANGES

* **base-cluster:** Revert "feat(base-cluster)!: use flux as a direct… ([#152](https://github.com/teutonet/teutonet-helm-charts/issues/152))
* **base-cluster:** use flux as a direct helm dependency ([#145](https://github.com/teutonet/teutonet-helm-charts/issues/145))
* **base-cluster:** migrate `.dns.email` to `.certManager.email`, ([#120](https://github.com/teutonet/teutonet-helm-charts/issues/120))

### Features

* **base-cluster/ClusterIssuer:** rename old ClusterIssuer and add ([#184](https://github.com/teutonet/teutonet-helm-charts/issues/184)) ([6f18200](https://github.com/teutonet/teutonet-helm-charts/commit/6f1820048ddef5399a3bcc77185386f5987c2ee5)), closes [#183](https://github.com/teutonet/teutonet-helm-charts/issues/183)
* **base-cluster/kube-prometheus-stack:** bump version ([#192](https://github.com/teutonet/teutonet-helm-charts/issues/192)) ([47d22f5](https://github.com/teutonet/teutonet-helm-charts/commit/47d22f525c1628fc5ba31d3177b2b4daae7f767f))
* **base-cluster/monitoring:** switch etcd scraping to http ([#178](https://github.com/teutonet/teutonet-helm-charts/issues/178)) ([d86a6ac](https://github.com/teutonet/teutonet-helm-charts/commit/d86a6acfb9ce4bffeac040c10eed730961139625))
* **base-cluster/storageclass:** prepare deletion by leaving them aft… ([#193](https://github.com/teutonet/teutonet-helm-charts/issues/193)) ([983bfc8](https://github.com/teutonet/teutonet-helm-charts/commit/983bfc8cab94561aa56381444092ecd46a2469c2))
* **base-cluster:** add [@marvin](https://github.com/marvin)Wolff as maintainer ([#36](https://github.com/teutonet/teutonet-helm-charts/issues/36)) ([82f2a03](https://github.com/teutonet/teutonet-helm-charts/commit/82f2a034cbcfa71a771a4801b420d95b2ca40d9e))
* **base-cluster:** add ci values for artifacthub ([#46](https://github.com/teutonet/teutonet-helm-charts/issues/46)) ([5b4e657](https://github.com/teutonet/teutonet-helm-charts/commit/5b4e65722a9a6d7f53387b77c401ac625c75d563))
* **base-cluster:** add more info for the installation ([#117](https://github.com/teutonet/teutonet-helm-charts/issues/117)) ([d408283](https://github.com/teutonet/teutonet-helm-charts/commit/d4082835a0e007d0f2f4138aa3fadc8afae9d00c))
* **base-cluster:** add option to use a specific IP ([#82](https://github.com/teutonet/teutonet-helm-charts/issues/82)) ([345aa5b](https://github.com/teutonet/teutonet-helm-charts/commit/345aa5b68ca3caa1155adacd52febb6de8d7a9ea)), closes [#66](https://github.com/teutonet/teutonet-helm-charts/issues/66)
* **base-cluster:** add rbac configuration options ([#100](https://github.com/teutonet/teutonet-helm-charts/issues/100)) ([e851d34](https://github.com/teutonet/teutonet-helm-charts/commit/e851d340f3202a7ebaf1f94aabb7c03e2db56ea1))
* **base-cluster:** add README ([4728a65](https://github.com/teutonet/teutonet-helm-charts/commit/4728a65a05706f13e8b69f2bd2fffe8ea439452a))
* **base-cluster:** add ref selection ([#85](https://github.com/teutonet/teutonet-helm-charts/issues/85)) ([34a5cf7](https://github.com/teutonet/teutonet-helm-charts/commit/34a5cf74f08816d211b92c88831a5ee72af196bd)), closes [#84](https://github.com/teutonet/teutonet-helm-charts/issues/84)
* **base-cluster:** add securityContexts to all pods ([#75](https://github.com/teutonet/teutonet-helm-charts/issues/75)) ([2094c99](https://github.com/teutonet/teutonet-helm-charts/commit/2094c9945d9a6624aabcc2b8a675a0a835ba9264)), closes [#68](https://github.com/teutonet/teutonet-helm-charts/issues/68)
* **base-cluster:** add support for flux sops decryption ([#86](https://github.com/teutonet/teutonet-helm-charts/issues/86)) ([029668d](https://github.com/teutonet/teutonet-helm-charts/commit/029668d9d3ce777cd7345e48f1c47eb7f9d576bf))
* **base-cluster:** add teuto-net HelmRepository ([#29](https://github.com/teutonet/teutonet-helm-charts/issues/29)) ([05bb335](https://github.com/teutonet/teutonet-helm-charts/commit/05bb335615d686d477fb26f5f19b1367678dba1e))
* **base-cluster:** allow configuration of dns nameservers for cert-manager ([1c406ff](https://github.com/teutonet/teutonet-helm-charts/commit/1c406ff963e45825e73892fe358cd8ecf12d9fe2))
* **base-cluster:** allow configuring the tools domains ([#130](https://github.com/teutonet/teutonet-helm-charts/issues/130)) ([85b127f](https://github.com/teutonet/teutonet-helm-charts/commit/85b127f6d407a9d9f9b81168445a47d406f0563a))
* **base-cluster:** auto-generate ssh keys when using SSH git URLs ([a8175ef](https://github.com/teutonet/teutonet-helm-charts/commit/a8175ef0fb112d14f81b96d6c87513e90b435769))
* **base-cluster:** bump kube-prometheus-stack version ([#142](https://github.com/teutonet/teutonet-helm-charts/issues/142)) ([42bf980](https://github.com/teutonet/teutonet-helm-charts/commit/42bf98095573174f2204daf65def2a1d9a61f2b8))
* **base-cluster:** disable PrometheusNotConnectedToAlertman… ([#163](https://github.com/teutonet/teutonet-helm-charts/issues/163)) ([9669349](https://github.com/teutonet/teutonet-helm-charts/commit/9669349745b50091dff888ddd473c76d85131e77))
* **base-cluster:** enable brotli and gzip ([#124](https://github.com/teutonet/teutonet-helm-charts/issues/124)) ([6322dcf](https://github.com/teutonet/teutonet-helm-charts/commit/6322dcf9e44a7d39215580726283d0486c6b4337))
* **base-cluster:** enrich schema with documentation ([e9fdd9f](https://github.com/teutonet/teutonet-helm-charts/commit/e9fdd9f8739d3e0ce97bfd0610a98ef16723b2ce))
* **base-cluster:** improve secret-sync ([2edd282](https://github.com/teutonet/teutonet-helm-charts/commit/2edd282c4f86a1cb186db97b841a752c5c08ab7a))
* **base-cluster:** initial commit ([998a39b](https://github.com/teutonet/teutonet-helm-charts/commit/998a39b2fd0cc67f6dc7a44348092579c5d95c8f))
* **base-cluster:** lower base resource requests ([#151](https://github.com/teutonet/teutonet-helm-charts/issues/151)) ([f280d57](https://github.com/teutonet/teutonet-helm-charts/commit/f280d57278fdf3efa77aae2ade7fe89c503c737e))
* **base-cluster:** make `global.baseDomain` optional ([#34](https://github.com/teutonet/teutonet-helm-charts/issues/34)) ([7feb507](https://github.com/teutonet/teutonet-helm-charts/commit/7feb507a46eb61ce1546c0f585eb1e48e6301818)), closes [#32](https://github.com/teutonet/teutonet-helm-charts/issues/32)
* **base-cluster:** make `helm install --dry-run` work with default values ([080863f](https://github.com/teutonet/teutonet-helm-charts/commit/080863f4dfde2cdc2f6c8480ba9c614f9137be9b))
* **base-cluster:** miscellaneous adjustments ([#89](https://github.com/teutonet/teutonet-helm-charts/issues/89)) ([e5d2f4a](https://github.com/teutonet/teutonet-helm-charts/commit/e5d2f4a3b93592b8f0631fe79ae00606365d8f1a))
* **base-cluster:** remove keyserver ([#96](https://github.com/teutonet/teutonet-helm-charts/issues/96)) ([10c7a1a](https://github.com/teutonet/teutonet-helm-charts/commit/10c7a1a376631988e4aacec30e8da97fb755772a))
* **base-cluster:** replace custom secret sync with reflector ([#94](https://github.com/teutonet/teutonet-helm-charts/issues/94)) ([47c67de](https://github.com/teutonet/teutonet-helm-charts/commit/47c67dee85a418e43ba7367d8e08b9549813b963))
* **base-cluster:** replace etcd secret job hook with a daemonset ([#71](https://github.com/teutonet/teutonet-helm-charts/issues/71)) ([79b673c](https://github.com/teutonet/teutonet-helm-charts/commit/79b673c7e9ed60f64cf9e641e52b0a8c9ccdc051))
* **base-cluster:** replace sleep with pause container ([#110](https://github.com/teutonet/teutonet-helm-charts/issues/110)) ([7776ce5](https://github.com/teutonet/teutonet-helm-charts/commit/7776ce5880f2a28e97b02c7ca6ad62be2b5cb4cd))
* **base-cluster:** update bootstrap documentation ([#113](https://github.com/teutonet/teutonet-helm-charts/issues/113)) ([65e2073](https://github.com/teutonet/teutonet-helm-charts/commit/65e2073be3cdcf9a5e453b86d8ee5e4a9aa07ee2))
* **base-cluster:** update charts to their latest major version ([#101](https://github.com/teutonet/teutonet-helm-charts/issues/101)) ([6b57915](https://github.com/teutonet/teutonet-helm-charts/commit/6b57915243c7d5769ea8e3fab06c1b715ee32d29))
* **base-cluster:** use flux as a direct helm dependency ([#145](https://github.com/teutonet/teutonet-helm-charts/issues/145)) ([0a906e8](https://github.com/teutonet/teutonet-helm-charts/commit/0a906e837da70360805f13d4219810c4f3b7b2ba)), closes [#109](https://github.com/teutonet/teutonet-helm-charts/issues/109)
* **base-cluster:** wait a minute before reporting over-provisioning of the nfs storage ([62895cb](https://github.com/teutonet/teutonet-helm-charts/commit/62895cb9932e7c0c3df1bb17bb388369b96906f1))


### Bug Fixes

* **base-cluster:** _always_ sort lists 😉 ([cfd7c1b](https://github.com/teutonet/teutonet-helm-charts/commit/cfd7c1ba8d8244e79aa46a43a1b69d4ee293e86c))
* **base-cluster:** add check to disallow secrets in the release namespace ([8f191fc](https://github.com/teutonet/teutonet-helm-charts/commit/8f191fc31d4f55ffae824943bc74572683da2058))
* **base-cluster:** Add checksum annotation to external-dns pod for apiKey rotation ([f4a0e0b](https://github.com/teutonet/teutonet-helm-charts/commit/f4a0e0b186f018123819c23d2f6cb873fa217369))
* **base-cluster:** add extraArgs so nginx LISTENs on the correct ports ([#114](https://github.com/teutonet/teutonet-helm-charts/issues/114)) ([30a8153](https://github.com/teutonet/teutonet-helm-charts/commit/30a8153c605a05562263291ac221bafb43ead9ce))
* **base-cluster:** add missing type parameter ([#108](https://github.com/teutonet/teutonet-helm-charts/issues/108)) ([bf28366](https://github.com/teutonet/teutonet-helm-charts/commit/bf2836612422220e68bd04a53dffb10487c9f983))
* **base-cluster:** add status selector for namespaces ([#81](https://github.com/teutonet/teutonet-helm-charts/issues/81)) ([c67efd2](https://github.com/teutonet/teutonet-helm-charts/commit/c67efd243b8767bf3d90cc41739b65f3da6f9c52))
* **base-cluster:** adjust whitespace ([#35](https://github.com/teutonet/teutonet-helm-charts/issues/35)) ([0d64cc1](https://github.com/teutonet/teutonet-helm-charts/commit/0d64cc1fc7361a3fe3f03e736718abe7c1e2fc25))
* **base-cluster:** also implement grafana! and alertmanager ([#132](https://github.com/teutonet/teutonet-helm-charts/issues/132)) ([fa86162](https://github.com/teutonet/teutonet-helm-charts/commit/fa861627511b915b133ca81f577fc4445b3129fb))
* **base-cluster:** change url to the "new" correct one ([#49](https://github.com/teutonet/teutonet-helm-charts/issues/49)) ([b892f7a](https://github.com/teutonet/teutonet-helm-charts/commit/b892f7a2af93bccc7ee67fbe25e9120b2a038b91))
* **base-cluster:** check for boolean instead of string ([#131](https://github.com/teutonet/teutonet-helm-charts/issues/131)) ([f6d45ae](https://github.com/teutonet/teutonet-helm-charts/commit/f6d45aea02d4812c90cac10271a8ec3dcc30bc5b))
* **base-cluster:** correctly configure prometheus to scrape etcd via ([#88](https://github.com/teutonet/teutonet-helm-charts/issues/88)) ([677e446](https://github.com/teutonet/teutonet-helm-charts/commit/677e44698fe9fe76965d37927b07c9d41efac7ea))
* **base-cluster:** depend on kube-prometheus-stack ([#25](https://github.com/teutonet/teutonet-helm-charts/issues/25)) ([e9d390f](https://github.com/teutonet/teutonet-helm-charts/commit/e9d390ff36ad32c7292a8f7ed17d15d5d35edf6e))
* **base-cluster:** disable nginx admissionwebhook ([1194eda](https://github.com/teutonet/teutonet-helm-charts/commit/1194eda0644847a57db6dc7846b2cd076ed151ef))
* **base-cluster:** fix certificates templating ([#112](https://github.com/teutonet/teutonet-helm-charts/issues/112)) ([6111e7b](https://github.com/teutonet/teutonet-helm-charts/commit/6111e7b4eb84bc6f82540b4f3b4ff560e521ecf8))
* **base-cluster:** fix logic for selection latest version ([#166](https://github.com/teutonet/teutonet-helm-charts/issues/166)) ([c30382b](https://github.com/teutonet/teutonet-helm-charts/commit/c30382b2e9767a6c89cd5e2b129a8d8683509e95))
* **base-cluster:** fix secret-sync cronjob ([#72](https://github.com/teutonet/teutonet-helm-charts/issues/72)) ([aa89dce](https://github.com/teutonet/teutonet-helm-charts/commit/aa89dce8a01178abc068f98797aa79755fa50bb2))
* **base-cluster:** fix templating of kyverno policies ([#50](https://github.com/teutonet/teutonet-helm-charts/issues/50)) ([04aa9ab](https://github.com/teutonet/teutonet-helm-charts/commit/04aa9abdd17278febd32c2ad69e7652fe60d1fa9))
* **base-cluster:** fix token retrieval ([#138](https://github.com/teutonet/teutonet-helm-charts/issues/138)) ([ac7dc9d](https://github.com/teutonet/teutonet-helm-charts/commit/ac7dc9d46f08e066bfb50b86a3793c47ece2bdbd))
* **base-cluster:** ingress tls annotation ([#133](https://github.com/teutonet/teutonet-helm-charts/issues/133)) ([086930d](https://github.com/teutonet/teutonet-helm-charts/commit/086930dd2b3233fd1677f54a689f78df34d85738))
* **base-cluster:** linting ([7ef30e2](https://github.com/teutonet/teutonet-helm-charts/commit/7ef30e28a2a255eb1f7b548398e1bcbf38733550))
* **base-cluster:** multiple rules trigger wrong yaml ([#105](https://github.com/teutonet/teutonet-helm-charts/issues/105)) ([d4740fe](https://github.com/teutonet/teutonet-helm-charts/commit/d4740feb8c780d22bc0f5473586a2108dd7f3865))
* **base-cluster:** remove bad whitespace 😕 ([#135](https://github.com/teutonet/teutonet-helm-charts/issues/135)) ([193223b](https://github.com/teutonet/teutonet-helm-charts/commit/193223b63b79bda337b12437f1674aca2d9c2a94))
* **base-cluster:** remove empy annotations and fix typo ([a1f97d1](https://github.com/teutonet/teutonet-helm-charts/commit/a1f97d1d8eade47d91525c183649acdefab39484))
* **base-cluster:** remove unused file ([98a298b](https://github.com/teutonet/teutonet-helm-charts/commit/98a298bba2e192e98accd68da0b068c110998589))
* **base-cluster:** Revert "feat(base-cluster)!: use flux as a direct… ([#152](https://github.com/teutonet/teutonet-helm-charts/issues/152)) ([10191a3](https://github.com/teutonet/teutonet-helm-charts/commit/10191a32dec2241bad62c3f2404b79e6d0fba1c4))
* **base-cluster:** trivy yaml duplicate key ([#90](https://github.com/teutonet/teutonet-helm-charts/issues/90)) ([b3f83d0](https://github.com/teutonet/teutonet-helm-charts/commit/b3f83d033b947a996ee4bd2c14b892c8855a41a7))
* **base-cluster:** up timeout of prometheus-operator ([24608f1](https://github.com/teutonet/teutonet-helm-charts/commit/24608f138d4e9f7c0e5c6491e450616897e05679))
* **base-cluster:** validation ([#111](https://github.com/teutonet/teutonet-helm-charts/issues/111)) ([0b592b9](https://github.com/teutonet/teutonet-helm-charts/commit/0b592b956c64694e7aef84127bc3ecfbe2014163))
* **base-cluster:** wrong whitespace removal ([#157](https://github.com/teutonet/teutonet-helm-charts/issues/157)) ([1985ade](https://github.com/teutonet/teutonet-helm-charts/commit/1985ade1edc2fbaea0a0860de62128d6fee8e457))


### refactor

* **base-cluster:** migrate `.dns.email` to `.certManager.email`, ([#120](https://github.com/teutonet/teutonet-helm-charts/issues/120)) ([31fb6dd](https://github.com/teutonet/teutonet-helm-charts/commit/31fb6dd5311976b0a6ed18ba55e2bac714b7dee3)), closes [#119](https://github.com/teutonet/teutonet-helm-charts/issues/119)


### Miscellaneous Chores

* **base-cluster:** [bot] release 0.3.0 ([#40](https://github.com/teutonet/teutonet-helm-charts/issues/40)) ([b88ac93](https://github.com/teutonet/teutonet-helm-charts/commit/b88ac93fd2a10738ed3366e7a2a65a60bf25eaf9))
* **base-cluster:** bump version ([774e058](https://github.com/teutonet/teutonet-helm-charts/commit/774e058fc86643a023a9e609e17af7a5914bb1ea))
* **base-cluster:** bump version ([7bb80ff](https://github.com/teutonet/teutonet-helm-charts/commit/7bb80ffe64aa2b3fcc0abcfc87f1b187cdfc9c94))
* **base-cluster:** bump version ([8308a15](https://github.com/teutonet/teutonet-helm-charts/commit/8308a1517b3116a45520296da6c391c94d15aa73))
* **base-cluster:** formatting ([39cb4e9](https://github.com/teutonet/teutonet-helm-charts/commit/39cb4e9526265b6a82a0f4dc289043195d2ac186))
* **base-cluster:** Update images in 'Chart.yaml' ([700fe07](https://github.com/teutonet/teutonet-helm-charts/commit/700fe07a5706c974fd5e608c1d67678bf8126b28))
* **base-cluster:** Update images in 'Chart.yaml' ([b6e37be](https://github.com/teutonet/teutonet-helm-charts/commit/b6e37be298771915ca1b8f8a43c2004fe6cc0f5d))
* **base-cluster:** Update images in 'Chart.yaml' ([d88cde3](https://github.com/teutonet/teutonet-helm-charts/commit/d88cde358cbe31d566504c172d44e1bee9e61930))
* **base-cluster:** Update images in 'Chart.yaml' ([895dfbf](https://github.com/teutonet/teutonet-helm-charts/commit/895dfbf97ca5cf5c26e6dba74d6a0e277772ffed))
* **base-cluster:** Update images in 'Chart.yaml' ([c885b28](https://github.com/teutonet/teutonet-helm-charts/commit/c885b282bd7f142f18b7b241c764652acfa221a5))
* **base-cluster:** Update images in 'Chart.yaml' ([d2a9bcb](https://github.com/teutonet/teutonet-helm-charts/commit/d2a9bcb5618e7f83fcd68f13a7b1b88277889d81))
* **base-cluster:** Update images in 'Chart.yaml' ([f8f4db3](https://github.com/teutonet/teutonet-helm-charts/commit/f8f4db3478c2ee878ab833cbd417638f506b4336))
* **base-cluster:** Update images in 'Chart.yaml' ([a14eb67](https://github.com/teutonet/teutonet-helm-charts/commit/a14eb67ffe08181080c4c63f66f8600d0f65c80b))
* **base-cluster:** Update images in 'Chart.yaml' ([d27ce7e](https://github.com/teutonet/teutonet-helm-charts/commit/d27ce7e87af7a1c14c963c6567dec8ac45b03211))
* **base-cluster:** Update images in 'Chart.yaml' ([fc3c072](https://github.com/teutonet/teutonet-helm-charts/commit/fc3c0726a4534478e8536cd9b3f3acd60fc7f98e))
* **base-cluster:** Update images in 'Chart.yaml' ([957a2dc](https://github.com/teutonet/teutonet-helm-charts/commit/957a2dc966eedbeffabc47bc9f341f35509baaa5))
* **base-cluster:** Update images in 'Chart.yaml' ([6b67ba0](https://github.com/teutonet/teutonet-helm-charts/commit/6b67ba0a3b5b3350fb2e189757d3ee2784e56575))
* **base-cluster:** Update images in 'Chart.yaml' ([d282f18](https://github.com/teutonet/teutonet-helm-charts/commit/d282f1836ce32f4d185d341f440e1e23c51baf8b))
* **base-cluster:** Update images in 'Chart.yaml' ([c4fe668](https://github.com/teutonet/teutonet-helm-charts/commit/c4fe6687f7fa77ff5b5e9045cf90593513cc3090))
* **base-cluster:** Update images in 'Chart.yaml' ([f341e11](https://github.com/teutonet/teutonet-helm-charts/commit/f341e119918ac5699388be7097b0a1e9b3fb66f9))
* **base-cluster:** Update images in 'Chart.yaml' ([60d2aaa](https://github.com/teutonet/teutonet-helm-charts/commit/60d2aaadcccdef815d09f0b7e8b1c2e59e6bfa78))
* **base-cluster:** Update images in 'Chart.yaml' ([0e92aad](https://github.com/teutonet/teutonet-helm-charts/commit/0e92aad7a9aaaeffe359526925230613246090ca))
* **base-cluster:** Update images in 'Chart.yaml' ([6535b05](https://github.com/teutonet/teutonet-helm-charts/commit/6535b0598a54d6ceecbfd705dc9af57d4a1f702d))
* **base-cluster:** Update images in 'Chart.yaml' ([f0e4b56](https://github.com/teutonet/teutonet-helm-charts/commit/f0e4b56afb5f4f810d63f7fc93c535a467a3c94e))
* **base-cluster:** Update images in 'Chart.yaml' ([24510d2](https://github.com/teutonet/teutonet-helm-charts/commit/24510d2dd13e48321996816b963cf5f6bbd7d425))
* **base-cluster:** Update images in 'Chart.yaml' ([820b050](https://github.com/teutonet/teutonet-helm-charts/commit/820b050e0e93a6cfbce6a21503c6815f85a3a105))
* **base-cluster:** Update images in 'Chart.yaml' ([2132051](https://github.com/teutonet/teutonet-helm-charts/commit/21320512f274b4a252cc1670590e7829b5bcabca))
* **base-cluster:** various little changes ([#16](https://github.com/teutonet/teutonet-helm-charts/issues/16)) ([29b5975](https://github.com/teutonet/teutonet-helm-charts/commit/29b59755e77cecd8143cef52a514a7bb8978fd6d))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.25.3 ([8667228](https://github.com/teutonet/teutonet-helm-charts/commit/8667228f0f474c104b118bd7552983b31c7dfcc2))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.25.4 ([#74](https://github.com/teutonet/teutonet-helm-charts/issues/74)) ([c7fa0ed](https://github.com/teutonet/teutonet-helm-charts/commit/c7fa0ed2321f306b75d091ff8ff1abc5d151010e))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.25.5 ([#102](https://github.com/teutonet/teutonet-helm-charts/issues/102)) ([1325d75](https://github.com/teutonet/teutonet-helm-charts/commit/1325d75f18a4bf17ee46711f3e53920cd148e1e9))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.26.0 ([#139](https://github.com/teutonet/teutonet-helm-charts/issues/139)) ([e981a97](https://github.com/teutonet/teutonet-helm-charts/commit/e981a97361b4cc266a1f8a4394f32f5e4747b879))
* **deps:** update docker.io/bitnami/kubectl docker tag to v1.26.1 ([#141](https://github.com/teutonet/teutonet-helm-charts/issues/141)) ([1f62579](https://github.com/teutonet/teutonet-helm-charts/commit/1f625796e2103b1bcd848c0321867a0d8c0f996c))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.36.0 ([#37](https://github.com/teutonet/teutonet-helm-charts/issues/37)) ([1ccf53d](https://github.com/teutonet/teutonet-helm-charts/commit/1ccf53d87905fd309b613a4e1d8487c79fa964d5))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.37.0 ([#92](https://github.com/teutonet/teutonet-helm-charts/issues/92)) ([03715da](https://github.com/teutonet/teutonet-helm-charts/commit/03715da86c050d1326756d249e4005bfe1981c2e))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.38.2 ([#107](https://github.com/teutonet/teutonet-helm-charts/issues/107)) ([bb5e27a](https://github.com/teutonet/teutonet-helm-charts/commit/bb5e27a3d6d2970c0ff48326963f818f46592f70))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.38.3 ([#126](https://github.com/teutonet/teutonet-helm-charts/issues/126)) ([7911b92](https://github.com/teutonet/teutonet-helm-charts/commit/7911b92d621f781ce014c5ffd27dd9d2480e77a8))
* **deps:** update docker.io/fluxcd/flux-cli docker tag to v0.39.0 ([#180](https://github.com/teutonet/teutonet-helm-charts/issues/180)) ([9b69d1b](https://github.com/teutonet/teutonet-helm-charts/commit/9b69d1b8606e6195ab778a539a06ff96674ef343))
* **deps:** update helm release common to v2.0.4 ([#44](https://github.com/teutonet/teutonet-helm-charts/issues/44)) ([ccddd4a](https://github.com/teutonet/teutonet-helm-charts/commit/ccddd4add2e2d501db63f57e1482c5d42572a1df))
* **deps:** update helm release common to v2.1.1 ([#58](https://github.com/teutonet/teutonet-helm-charts/issues/58)) ([ddd7aae](https://github.com/teutonet/teutonet-helm-charts/commit/ddd7aae39d83927f7242857a174d444bb55a7ffc))
* **deps:** update helm release common to v2.1.2 ([#62](https://github.com/teutonet/teutonet-helm-charts/issues/62)) ([113fa69](https://github.com/teutonet/teutonet-helm-charts/commit/113fa699140eca0867112fc3e9094340b2b0f09a))
* **deps:** update helm release common to v2.2.0 ([#76](https://github.com/teutonet/teutonet-helm-charts/issues/76)) ([60e0b97](https://github.com/teutonet/teutonet-helm-charts/commit/60e0b97560e5512ddaa864ce48403f118a534ce1))
* **deps:** update helm release common to v2.2.1 ([#97](https://github.com/teutonet/teutonet-helm-charts/issues/97)) ([f5bc313](https://github.com/teutonet/teutonet-helm-charts/commit/f5bc31330fd18f94b4657b41867dd6d30cb88399))
* **deps:** update helm release common to v2.2.2 ([#103](https://github.com/teutonet/teutonet-helm-charts/issues/103)) ([21065b3](https://github.com/teutonet/teutonet-helm-charts/commit/21065b308c3f2261cfd2171630d6a1ab0f60b104))
* **deps:** update helm release common to v2.2.3 ([#189](https://github.com/teutonet/teutonet-helm-charts/issues/189)) ([ea07b8a](https://github.com/teutonet/teutonet-helm-charts/commit/ea07b8a8f68197f55a5d85bcdf881f71c63578ae))
* **deps:** update helm release flux2 to v2.5.0 ([#149](https://github.com/teutonet/teutonet-helm-charts/issues/149)) ([d6e637f](https://github.com/teutonet/teutonet-helm-charts/commit/d6e637fec6f81f64089554840be86fc376300ea8))
* **deps:** update k8s.gcr.io/pause docker tag to v3.9 ([#123](https://github.com/teutonet/teutonet-helm-charts/issues/123)) ([0f1a88f](https://github.com/teutonet/teutonet-helm-charts/commit/0f1a88fcb93a0a2d1d6f5cfbb8b9690d8eb780cc))
* **main:** [bot] release base-cluster:0.4.0 ([#78](https://github.com/teutonet/teutonet-helm-charts/issues/78)) ([fd2400a](https://github.com/teutonet/teutonet-helm-charts/commit/fd2400a199be52a0a58086519dd02ba6eb84dd73))
* **main:** [bot] release base-cluster:0.4.1 ([#91](https://github.com/teutonet/teutonet-helm-charts/issues/91)) ([7c8b9ce](https://github.com/teutonet/teutonet-helm-charts/commit/7c8b9ce7c50b3b6bb7211212258c46e268e34a08))
* **main:** [bot] release base-cluster:0.5.0 ([#95](https://github.com/teutonet/teutonet-helm-charts/issues/95)) ([8491a62](https://github.com/teutonet/teutonet-helm-charts/commit/8491a62f900fccd93994e18168a470676b525197))
* **main:** [bot] release base-cluster:0.6.0 ([#98](https://github.com/teutonet/teutonet-helm-charts/issues/98)) ([2fb871d](https://github.com/teutonet/teutonet-helm-charts/commit/2fb871dba78b2f17ad6bd5d9969e5a4b2105395e))
* **main:** [bot] release base-cluster:0.7.0 ([#104](https://github.com/teutonet/teutonet-helm-charts/issues/104)) ([db1576c](https://github.com/teutonet/teutonet-helm-charts/commit/db1576c5fcecc757e991e6872f2451b1c9d59fc3))
* **main:** [bot] release base-cluster:0.7.1 ([#106](https://github.com/teutonet/teutonet-helm-charts/issues/106)) ([9144685](https://github.com/teutonet/teutonet-helm-charts/commit/91446852861b648c5abd8ac8f61b0d9d9b801058))
* **main:** [bot] release base-cluster:0.8.0 ([#115](https://github.com/teutonet/teutonet-helm-charts/issues/115)) ([de2d9e0](https://github.com/teutonet/teutonet-helm-charts/commit/de2d9e0528f6f073fd74a9c045d0bee9b842d9d2))
* **main:** [bot] release base-cluster:1.0.0 ([#122](https://github.com/teutonet/teutonet-helm-charts/issues/122)) ([bae8d93](https://github.com/teutonet/teutonet-helm-charts/commit/bae8d934d7d2e83e2b13165ed4b99972c109a243))
* **main:** [bot] release base-cluster:1.1.0 ([#125](https://github.com/teutonet/teutonet-helm-charts/issues/125)) ([8675990](https://github.com/teutonet/teutonet-helm-charts/commit/8675990fff4799ea9129e5383c84d0f21973ffaf))
* **main:** [bot] release base-cluster:1.2.0 ([#127](https://github.com/teutonet/teutonet-helm-charts/issues/127)) ([ac9ed2c](https://github.com/teutonet/teutonet-helm-charts/commit/ac9ed2c3d2a28b7cf273ee5fb1ca5cee8396aa31))
* **main:** [bot] release base-cluster:1.2.1 ([#134](https://github.com/teutonet/teutonet-helm-charts/issues/134)) ([31ed1d1](https://github.com/teutonet/teutonet-helm-charts/commit/31ed1d1810f59d26924aee8cffb1d4a2966ce266))
* **main:** [bot] release base-cluster:1.2.2 ([#136](https://github.com/teutonet/teutonet-helm-charts/issues/136)) ([154b3d4](https://github.com/teutonet/teutonet-helm-charts/commit/154b3d4eaa87ed8d0a0774b8826806af0c5d6d51))
* **main:** [bot] release base-cluster:2.0.0 ([#140](https://github.com/teutonet/teutonet-helm-charts/issues/140)) ([79598db](https://github.com/teutonet/teutonet-helm-charts/commit/79598db7a9325ceddcc2219419b577a4be96d8c7))
* **main:** [bot] release base-cluster:3.0.0 ([#150](https://github.com/teutonet/teutonet-helm-charts/issues/150)) ([fe9b2f2](https://github.com/teutonet/teutonet-helm-charts/commit/fe9b2f226263781fdc34bd98daae5addfdc2c11c))
* **main:** [bot] release base-cluster:3.0.1 ([#158](https://github.com/teutonet/teutonet-helm-charts/issues/158)) ([b734bb9](https://github.com/teutonet/teutonet-helm-charts/commit/b734bb925220e3c2c524927de911a6cd0d29fcea))
* **main:** [bot] release base-cluster:3.1.0 ([#159](https://github.com/teutonet/teutonet-helm-charts/issues/159)) ([552676f](https://github.com/teutonet/teutonet-helm-charts/commit/552676ff2a7d1a7b8b54101f094f84822ddfae95))
* **main:** [bot] release base-cluster:3.2.0 ([#195](https://github.com/teutonet/teutonet-helm-charts/issues/195)) ([acb79d3](https://github.com/teutonet/teutonet-helm-charts/commit/acb79d3bc38538e1b90f76429990dde761b1baf6))
* **main:** [bot] release base-cluster:3.3.0 ([#198](https://github.com/teutonet/teutonet-helm-charts/issues/198)) ([bc378e4](https://github.com/teutonet/teutonet-helm-charts/commit/bc378e4bf1fc2987d180fc62946182d68027dc7f))
* **main:** release base-cluster 0.2.0 ([#30](https://github.com/teutonet/teutonet-helm-charts/issues/30)) ([493297a](https://github.com/teutonet/teutonet-helm-charts/commit/493297ae5173be7f78ca5c8497bac5549503a752))
* **t8s-cluster:** Update images in 'Chart.yaml' ([91b78ab](https://github.com/teutonet/teutonet-helm-charts/commit/91b78ab382902f078dc8b6b28d0cf3a5842f7776))
* Update 'README.md's ([8fec8f7](https://github.com/teutonet/teutonet-helm-charts/commit/8fec8f7d3f3960d177b9a49143e973757f338d0b))
* Update 'README.md's ([52fd89e](https://github.com/teutonet/teutonet-helm-charts/commit/52fd89e71532b78621aa9bec0e7ad09341446050))
* Update 'README.md's ([2cc3cd4](https://github.com/teutonet/teutonet-helm-charts/commit/2cc3cd4054793f17b6687efef31130b19d25e206))
* Update 'README.md's ([a8175ef](https://github.com/teutonet/teutonet-helm-charts/commit/a8175ef0fb112d14f81b96d6c87513e90b435769))
* Update 'README.md's ([9c88301](https://github.com/teutonet/teutonet-helm-charts/commit/9c88301c741f52be44bab0d337fae2e7d8eedc57))
* Update 'README.md's ([1829423](https://github.com/teutonet/teutonet-helm-charts/commit/1829423b4a856397d308524b4f4e54060664af2f))
* Update 'README.md's ([147d5b7](https://github.com/teutonet/teutonet-helm-charts/commit/147d5b71f4ee71bbd5ee0655715823cd2d1a1bf3))

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
