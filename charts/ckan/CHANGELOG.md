# Changelog

## [1.3.3](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.3.2...ckan-v1.3.3) (2025-06-24)


### Miscellaneous Chores

* **ckan:** change sorl auth in preperation for service metrics ([#1547](https://github.com/teutonet/teutonet-helm-charts/issues/1547)) ([bd10b9c](https://github.com/teutonet/teutonet-helm-charts/commit/bd10b9c139a534a422e84ba2f7b0cb94a53178f7))

## [1.3.2](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.3.1...ckan-v1.3.2) (2025-06-20)


### Bug Fixes

* **ckan:** Revert "chore(ckan): add missing valkey license" ([#1474](https://github.com/teutonet/teutonet-helm-charts/issues/1474)) ([d046bc4](https://github.com/teutonet/teutonet-helm-charts/commit/d046bc4453fa14991578b1faa19de8608f38cb6a))


### Miscellaneous Chores

* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/ckan docker tag to v1.0.15 ([#1516](https://github.com/teutonet/teutonet-helm-charts/issues/1516)) ([0180fe4](https://github.com/teutonet/teutonet-helm-charts/commit/0180fe40c4f6f41ff299bbea0f52b1809dc066b3))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/solr-ckan docker tag to v1.0.27 ([#1517](https://github.com/teutonet/teutonet-helm-charts/issues/1517)) ([2a606f5](https://github.com/teutonet/teutonet-helm-charts/commit/2a606f5fa9bd40cb1d60ffa874d32a8b8ff31389))
* **ckan/dependencies:** update solr docker tag to v9.6.5 ([#1531](https://github.com/teutonet/teutonet-helm-charts/issues/1531)) ([faa2a3a](https://github.com/teutonet/teutonet-helm-charts/commit/faa2a3a7e050ebde5b5d62c5222423fd89b4bf2e))
* **ckan/dependencies:** update valkey docker tag to v3.0.15 ([#1518](https://github.com/teutonet/teutonet-helm-charts/issues/1518)) ([904b201](https://github.com/teutonet/teutonet-helm-charts/commit/904b201019da259c3ce41e433bbe525db2e3b92b))

## [1.3.1](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.3.0...ckan-v1.3.1) (2025-05-21)


### Miscellaneous Chores

* **ckan:** add missing valkey license ([#1472](https://github.com/teutonet/teutonet-helm-charts/issues/1472)) ([2edc78f](https://github.com/teutonet/teutonet-helm-charts/commit/2edc78f31317f7a35d61750cecac1d5aca7ae89a))
* **ckan:** use primary valkey instance ([#1469](https://github.com/teutonet/teutonet-helm-charts/issues/1469)) ([64acca3](https://github.com/teutonet/teutonet-helm-charts/commit/64acca300e408279ac09963b2041d24f17181e39))

## [1.3.0](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.9...ckan-v1.3.0) (2025-05-19)


### Features

* **ckan:** replace redis with valkey ([#1468](https://github.com/teutonet/teutonet-helm-charts/issues/1468)) ([d29d113](https://github.com/teutonet/teutonet-helm-charts/commit/d29d113a9a2bbc945a60487ad048b2fba178b739))


### Miscellaneous Chores

* **ckan/dependencies:** update ckan/ckan-base-datapusher:0.0.21 docker digest to 84d1192 ([#1443](https://github.com/teutonet/teutonet-helm-charts/issues/1443)) ([bcbeef2](https://github.com/teutonet/teutonet-helm-charts/commit/bcbeef25d2b3a38a76c33617d4070427b8e58b90))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/ckan docker tag to v1.0.14 ([#1378](https://github.com/teutonet/teutonet-helm-charts/issues/1378)) ([4fdacdf](https://github.com/teutonet/teutonet-helm-charts/commit/4fdacdfbb78bc24b22b561026b801c898aec355e))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/solr-ckan docker tag to v1.0.25 ([#1379](https://github.com/teutonet/teutonet-helm-charts/issues/1379)) ([2d1713c](https://github.com/teutonet/teutonet-helm-charts/commit/2d1713cf0e2b98eb8f3aa9481584935cae87a91b))
* **ckan/dependencies:** update solr docker tag to v9.5.7 ([#1380](https://github.com/teutonet/teutonet-helm-charts/issues/1380)) ([83b6b68](https://github.com/teutonet/teutonet-helm-charts/commit/83b6b68b0a0bb22b09aa594c634f0e1c16cc4c87))

## [1.2.9](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.8...ckan-v1.2.9) (2025-05-13)


### Miscellaneous Chores

* **ckan:** remove ext postgres config ([#1459](https://github.com/teutonet/teutonet-helm-charts/issues/1459)) ([263b574](https://github.com/teutonet/teutonet-helm-charts/commit/263b574de2a2d41c0ec26061b5395e17ff36af1f))

## [1.2.8](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.7...ckan-v1.2.8) (2025-05-13)


### Miscellaneous Chores

* **ckan:** change psql connection ([#1457](https://github.com/teutonet/teutonet-helm-charts/issues/1457)) ([e001dd3](https://github.com/teutonet/teutonet-helm-charts/commit/e001dd376b245bc021e5900bcacdff8e0860933f))

## [1.2.7](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.6...ckan-v1.2.7) (2025-05-12)


### Miscellaneous Chores

* **ckan:** change env order ([#1455](https://github.com/teutonet/teutonet-helm-charts/issues/1455)) ([135ef05](https://github.com/teutonet/teutonet-helm-charts/commit/135ef05164525f5cb97724dd0943297ecee4a881))

## [1.2.6](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.5...ckan-v1.2.6) (2025-05-12)


### Miscellaneous Chores

* **ckan:** support external db ([#1453](https://github.com/teutonet/teutonet-helm-charts/issues/1453)) ([caa20e8](https://github.com/teutonet/teutonet-helm-charts/commit/caa20e84fbca462359598eba34c2b710cf5158f8))

## [1.2.5](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.4...ckan-v1.2.5) (2025-05-12)


### Miscellaneous Chores

* **ckan:** change env generation ([#1451](https://github.com/teutonet/teutonet-helm-charts/issues/1451)) ([152e075](https://github.com/teutonet/teutonet-helm-charts/commit/152e0751344c6d3709654e9ba4c9efb4e1f1fd9e))

## [1.2.4](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.3...ckan-v1.2.4) (2025-01-22)


### Miscellaneous Chores

* **ckan:** fix postinstall ckan image ([#1308](https://github.com/teutonet/teutonet-helm-charts/issues/1308)) ([a06c51c](https://github.com/teutonet/teutonet-helm-charts/commit/a06c51c8a75f6a5c2fe3aa41be85cc5c58a5a928))

## [1.2.3](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.2...ckan-v1.2.3) (2025-01-22)


### Miscellaneous Chores

* **ckan:** fix imagepullsecrets support ([#1304](https://github.com/teutonet/teutonet-helm-charts/issues/1304)) ([bcef00b](https://github.com/teutonet/teutonet-helm-charts/commit/bcef00b2b0db43091062691156e4595362d8d704))

## [1.2.2](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.1...ckan-v1.2.2) (2025-01-22)


### Miscellaneous Chores

* **ckan/dependencies:** pin dependencies ([#1266](https://github.com/teutonet/teutonet-helm-charts/issues/1266)) ([44f25a5](https://github.com/teutonet/teutonet-helm-charts/commit/44f25a5d835724fad9763c28cb5bfaa42ad72afb))
* **ckan:** add imagepullsecrets support ([#1297](https://github.com/teutonet/teutonet-helm-charts/issues/1297)) ([c612cf2](https://github.com/teutonet/teutonet-helm-charts/commit/c612cf221c0e803c6e6a5c5086d25c169b27d6da))
* **ckan:** update solar and ckan container ([#1277](https://github.com/teutonet/teutonet-helm-charts/issues/1277)) ([fadecb5](https://github.com/teutonet/teutonet-helm-charts/commit/fadecb5693f6f2881c8d7b797cd03e1cab0e79e9))

## [1.2.1](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.2.0...ckan-v1.2.1) (2024-12-03)


### Miscellaneous Chores

* **ckan:** add extra volumes to ckan ([#1263](https://github.com/teutonet/teutonet-helm-charts/issues/1263)) ([bb194dc](https://github.com/teutonet/teutonet-helm-charts/commit/bb194dcdc4535d391f0659a9d6070e578b7d91f5))

## [1.2.0](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.8...ckan-v1.2.0) (2024-11-29)


### Features

* **ckan:** add api creation and perist secrets ([#1238](https://github.com/teutonet/teutonet-helm-charts/issues/1238)) ([#1249](https://github.com/teutonet/teutonet-helm-charts/issues/1249)) ([a42d2f6](https://github.com/teutonet/teutonet-helm-charts/commit/a42d2f6dbd8a241d390a70263ba67d2d69362396))


### Miscellaneous Chores

* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/solr-ckan docker tag to v1.0.12 ([#1210](https://github.com/teutonet/teutonet-helm-charts/issues/1210)) ([6900c0f](https://github.com/teutonet/teutonet-helm-charts/commit/6900c0ff7333e851450eb0b64bee8efcb8cffb5c))

## [1.1.8](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.7...ckan-v1.1.8) (2024-10-21)


### Miscellaneous Chores

* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/ckan docker tag to v1.0.3 ([#1136](https://github.com/teutonet/teutonet-helm-charts/issues/1136)) ([f33c4a6](https://github.com/teutonet/teutonet-helm-charts/commit/f33c4a615b3a0a5d0781c44d270a54bbc670e511))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/ckan docker tag to v1.0.5 ([#1163](https://github.com/teutonet/teutonet-helm-charts/issues/1163)) ([33b1b3e](https://github.com/teutonet/teutonet-helm-charts/commit/33b1b3ef9a5bc94d0420b8eb363c65f266f562c7))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/solr-ckan docker tag to v1.0.11 ([#1164](https://github.com/teutonet/teutonet-helm-charts/issues/1164)) ([445b682](https://github.com/teutonet/teutonet-helm-charts/commit/445b68210aa51e0ab51b597b735a6b174c4ed12f))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/solr-ckan docker tag to v1.0.8 ([#1148](https://github.com/teutonet/teutonet-helm-charts/issues/1148)) ([9dd9824](https://github.com/teutonet/teutonet-helm-charts/commit/9dd98242ca437bf5f8e34df80f1ebbf245241eeb))

## [1.1.7](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.6...ckan-v1.1.7) (2024-08-15)


### Bug Fixes

* **ckan:** fix solr cloud setup ([#1104](https://github.com/teutonet/teutonet-helm-charts/issues/1104)) ([c7cbb31](https://github.com/teutonet/teutonet-helm-charts/commit/c7cbb315268d7c0f289db786f73208c198652847))


### Miscellaneous Chores

* **ckan/dependencies:** pin ghcr.io/teutonet/oci-images/solr-ckan docker tag to fa9824f ([#1105](https://github.com/teutonet/teutonet-helm-charts/issues/1105)) ([59790a9](https://github.com/teutonet/teutonet-helm-charts/commit/59790a91e7916083e0711673900f187732ba7b56))
* **ckan/dependencies:** update common docker tag to v1.2.1 ([#1106](https://github.com/teutonet/teutonet-helm-charts/issues/1106)) ([553e211](https://github.com/teutonet/teutonet-helm-charts/commit/553e211ecbf9d2bc8e7c59073868c8f37ead5124))

## [1.1.6](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.5...ckan-v1.1.6) (2024-08-14)


### Bug Fixes

* **ckan:** init container for volume permissions ([#1098](https://github.com/teutonet/teutonet-helm-charts/issues/1098)) ([c4c45ed](https://github.com/teutonet/teutonet-helm-charts/commit/c4c45ed7aa11d1997f9ccd54cf7f619a6def83c2))

## [1.1.5](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.4...ckan-v1.1.5) (2024-08-14)


### Bug Fixes

* **ckan:** add defaults for datapusher formats defaults ([#1094](https://github.com/teutonet/teutonet-helm-charts/issues/1094)) ([f036735](https://github.com/teutonet/teutonet-helm-charts/commit/f0367357ef1890f32fb6555cb61fce427f46623b))
* **ckan:** volume mount position one level up ([#1095](https://github.com/teutonet/teutonet-helm-charts/issues/1095)) ([a183662](https://github.com/teutonet/teutonet-helm-charts/commit/a18366281613bfa3ed72075c1e5df83f7d9e2e56))

## [1.1.4](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.3...ckan-v1.1.4) (2024-07-06)


### Miscellaneous Chores

* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/solr-ckan docker tag to v1.0.4 ([#1032](https://github.com/teutonet/teutonet-helm-charts/issues/1032)) ([b1250ab](https://github.com/teutonet/teutonet-helm-charts/commit/b1250ab6cae71427da7d533c8786e51f28d8d57c))

## [1.1.3](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.2...ckan-v1.1.3) (2024-07-04)


### Miscellaneous Chores

* **ckan/dependencies:** update ckan/ckan-base-datapusher docker tag to v0.0.21 ([#1008](https://github.com/teutonet/teutonet-helm-charts/issues/1008)) ([303f554](https://github.com/teutonet/teutonet-helm-charts/commit/303f554594ecd465ddb771c1761245a691063eb7))
* **ckan/dependencies:** update common docker tag to v1.2.0 ([#1016](https://github.com/teutonet/teutonet-helm-charts/issues/1016)) ([4eed55b](https://github.com/teutonet/teutonet-helm-charts/commit/4eed55b59495cda6f523b4270e2d484853eb02cd))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/ckan docker tag to v1.0.2 ([#1009](https://github.com/teutonet/teutonet-helm-charts/issues/1009)) ([de6da51](https://github.com/teutonet/teutonet-helm-charts/commit/de6da517b7af07a98b6817e0457c6e64109c5516))
* **ckan/dependencies:** update ghcr.io/teutonet/oci-images/solr-ckan docker tag to v1.0.3 ([#1012](https://github.com/teutonet/teutonet-helm-charts/issues/1012)) ([d49cfdb](https://github.com/teutonet/teutonet-helm-charts/commit/d49cfdb6c8c9745b393f8e027e0ac52d219d4e48))

## [1.1.2](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.1...ckan-v1.1.2) (2024-05-29)


### Bug Fixes

* **ckan:** change images to teutonet image repo ([#976](https://github.com/teutonet/teutonet-helm-charts/issues/976)) ([177d28e](https://github.com/teutonet/teutonet-helm-charts/commit/177d28e34bfa8d41192ef927976e5c3f1e592b78))

## [1.1.1](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.1.0...ckan-v1.1.1) (2024-05-16)


### Bug Fixes

* **ckan:** change ingress tls template ([#968](https://github.com/teutonet/teutonet-helm-charts/issues/968)) ([ccd62ac](https://github.com/teutonet/teutonet-helm-charts/commit/ccd62aca21be53595d398b1ef69bdf3f3bdb8679))

## [1.1.0](https://github.com/teutonet/teutonet-helm-charts/compare/ckan-v1.0.0...ckan-v1.1.0) (2024-05-16)


### Features

* **ckan:** Add ckan values variable ([#958](https://github.com/teutonet/teutonet-helm-charts/issues/958)) ([8c20ab7](https://github.com/teutonet/teutonet-helm-charts/commit/8c20ab74ba33cd297d425396cc6bbcf9b1b5c2ed))


### Miscellaneous Chores

* **ckan/dependencies:** update common docker tag to v1.1.0 ([#940](https://github.com/teutonet/teutonet-helm-charts/issues/940)) ([3980346](https://github.com/teutonet/teutonet-helm-charts/commit/39803463fbecbc84ccbb70cb50e96ff94df5642f))

## 1.0.0 (2024-05-14)


### Features

* **ckan:** add alpha ckan helmchart ([#916](https://github.com/teutonet/teutonet-helm-charts/issues/916)) ([87a1fca](https://github.com/teutonet/teutonet-helm-charts/commit/87a1fcaedf3817f92c63b81a4f9dfbff8f65d9fc))
