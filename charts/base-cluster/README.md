# base-cluster

![Version: 1.2.2](https://img.shields.io/badge/Version-1.2.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A common base for every kubernetes cluster

**Homepage:** <https://teuto.net>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |

## Cluster bootstrap

```sh
# always be git 😁
git init

# create empty cluster HelmRelease;
flux create helmrelease --export base-cluster -n flux-system --source HelmRepository/teuto-net.flux-system --chart base-cluster --chart-version 0.x.x > cluster.yaml

# maybe use the following name for your cluster;
kubectl get node -o json | jq '.items[0].metadata.annotations["cluster.x-k8s.io/cluster-name"]'

# configure according to your needs, at least `.global.clusterName` is needed
# also, you should configure `.helmRepositories.flux.url=https://fluxcd-community.github.io/helm-charts` so flux can manage itself
# additionally, you should add your git repo to `.flux.gitRepositories`, see [the documentation](https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/base-cluster#81--property-base-cluster-configuration--flux--gitrepositories)
vi cluster.yaml

# create HelmRelease for flux to manage itself
flux create helmrelease --export flux -n flux-system --source HelmRepository/flux.flux-system --chart flux2 --chart-version 2.x.x > flux.yaml

# add, commit and push resources
git add cluster.yaml flux.yaml
git commit cluster.yaml flux.yaml
git push

# we explicitly do not use `flux bootstrap` or `flux install` as this creates kustomization stuff and installs flux manually
helm install -n flux-system flux flux2 --repo https://fluxcd-community.github.io/helm-charts --version 2.x.x --atomic

# manual initial installation of the chart, afterwards the chart takes over
# after the installation finished, follow the on-screen instructions to configure your flux, distribute KUBECONFIGs, ...
helm install -n flux-system base-cluster base-cluster --repo https://teutonet.github.io/teutonet-helm-charts --version 0.x.x --atomic --values <(cat cluster.yaml | yq -y .spec.values)

# you can use this command to get the instructions again
helm -n flux-system get notes base-cluster
```

## Source Code

* <https://github.com/teutonet/teutonet-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.2.2 |

This helm chart requires flux v2 to be installed (https://fluxcd.io/docs/installation)

The various components are automatically updated to the latest minor and patch version.

This excludes:

- descheduler, its version is bound to the k8s version and they have not released 1.0.0

## Migration

# 0.x.x -> 1.0.0

- The field `.dns.email` moves to `.certManager.email`.
- The field `.dns.provider.cloudflare.email` is removed, as only `apiToken`s are supported anyways.

# base cluster configuration

**Title:** base cluster configuration

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                       | Pattern | Type   | Deprecated | Definition | Title/Description    |
| ------------------------------ | ------- | ------ | ---------- | ---------- | -------------------- |
| - [global](#global )           | No      | object | No         | -          | -                    |
| - [kyverno](#kyverno )         | No      | object | No         | -          | -                    |
| - [monitoring](#monitoring )   | No      | object | No         | -          | -                    |
| - [descheduler](#descheduler ) | No      | object | No         | -          | -                    |
| - [dns](#dns )                 | No      | object | No         | -          | -                    |
| - [certManager](#certManager ) | No      | object | No         | -          | -                    |
| - [externalDNS](#externalDNS ) | No      | object | No         | -          | -                    |
| - [flux](#flux )               | No      | object | No         | -          | -                    |
| - [ingress](#ingress )         | No      | object | No         | -          | -                    |
| - [storage](#storage )         | No      | object | No         | -          | -                    |
| - [reflector](#reflector )     | No      | object | No         | -          | -                    |
| - [rbac](#rbac )               | No      | object | No         | -          | -                    |
| - [common](#common )           | No      | object | No         | -          | Values for sub-chart |

## <a name="global"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                  | Pattern | Type             | Deprecated | Definition              | Title/Description                                                                                                                                                |
| --------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| + [serviceLevelAgreement](#global_serviceLevelAgreement ) | No      | enum (of string) | No         | -                       | The ServiceLevelAgreement with teutonet, will be applied to all alerts as label \`teutosla\`                                                                     |
| - [clusterName](#global_clusterName )                     | No      | string or null   | No         | -                       | The name of the cluster, used as subdomain under \`baseDomain\` and as label \`cluster\` on all alerts                                                           |
| - [baseDomain](#global_baseDomain )                       | No      | string or null   | No         | -                       | The base domain to be used for cluster ingress                                                                                                                   |
| - [imageRegistry](#global_imageRegistry )                 | No      | string or null   | No         | -                       | The global container image proxy, e.g. [Nexus](https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager), this needs to support various registries |
| - [imageCredentials](#global_imageCredentials )           | No      | object           | No         | -                       | A map of credentials to be created and synced into namespaces, the key is the secret name                                                                        |
| - [kubectl](#global_kubectl )                             | No      | object           | No         | -                       | Image with \`kubectl\` binary                                                                                                                                    |
| - [pause](#global_pause )                                 | No      | object           | No         | -                       | Image to be used for pause containers                                                                                                                            |
| - [flux](#global_flux )                                   | No      | object           | No         | -                       | Image with \`flux\` binary                                                                                                                                       |
| - [gpg](#global_gpg )                                     | No      | object           | No         | -                       | Image with \`gpg\` binary                                                                                                                                        |
| - [networkPolicy](#global_networkPolicy )                 | No      | object           | No         | -                       | -                                                                                                                                                                |
| - [helmRepositories](#global_helmRepositories )           | No      | object           | No         | -                       | A map of helmRepositories to create, the key is the name                                                                                                         |
| - [certificates](#global_certificates )                   | No      | object           | No         | -                       | A map of cert-manager certificates to create and sync its secrets into namespaces, the key is the name, therefore the secret name will be \`$key\`-certificate   |
| - [storageClass](#global_storageClass )                   | No      | string or null   | No         | In #/$defs/storageClass | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)                                                 |
| - [namespaces](#global_namespaces )                       | No      | object           | No         | -                       | Namespaces to create. AND *delete* if removed                                                                                                                    |

### <a name="global_serviceLevelAgreement"></a>1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > serviceLevelAgreement`

|             |                    |
| ----------- | ------------------ |
| **Type**    | `enum (of string)` |
| **Default** | `"None"`           |

**Description:** The ServiceLevelAgreement with teutonet, will be applied to all alerts as label `teutosla`

Must be one of:
* "None"
* "24x7"
* "Working-Hours"

### <a name="global_clusterName"></a>1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > clusterName`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

**Description:** The name of the cluster, used as subdomain under `baseDomain` and as label `cluster` on all alerts

**Example:**

```yaml
eu-2
```

### <a name="global_baseDomain"></a>1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > baseDomain`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

**Description:** The base domain to be used for cluster ingress

**Example:**

```yaml
teuto.net
```

### <a name="global_imageRegistry"></a>1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > imageRegistry`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

**Description:** The global container image proxy, e.g. [Nexus](https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager), this needs to support various registries

**Example:**

```yaml
nexus.teuto.net
```

### <a name="global_imageCredentials"></a>1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > imageCredentials`

|                           |                                                                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_imageCredentials_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of credentials to be created and synced into namespaces, the key is the secret name

| Property                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#global_imageCredentials_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_imageCredentials_additionalProperties"></a>1.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > imageCredentials > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                              | Pattern | Type   | Deprecated | Definition                  | Title/Description                                                     |
| ------------------------------------------------------------------------------------- | ------- | ------ | ---------- | --------------------------- | --------------------------------------------------------------------- |
| + [host](#global_imageCredentials_additionalProperties_host )                         | No      | string | No         | -                           | -                                                                     |
| + [username](#global_imageCredentials_additionalProperties_username )                 | No      | string | No         | -                           | -                                                                     |
| + [password](#global_imageCredentials_additionalProperties_password )                 | No      | string | No         | -                           | -                                                                     |
| - [targetNamespaces](#global_imageCredentials_additionalProperties_targetNamespaces ) | No      | object | No         | In #/$defs/targetNamespaces | The namespaces to sync the secret into, or \`ALL\` for all namespaces |

##### <a name="global_imageCredentials_additionalProperties_host"></a>1.5.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > imageCredentials > additionalProperties > host`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Example:**

```yaml
docker.io
```

##### <a name="global_imageCredentials_additionalProperties_username"></a>1.5.1.2. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > imageCredentials > additionalProperties > username`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_imageCredentials_additionalProperties_password"></a>1.5.1.3. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > imageCredentials > additionalProperties > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_imageCredentials_additionalProperties_targetNamespaces"></a>1.5.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > imageCredentials > additionalProperties > targetNamespaces`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Default**               | `"ALL"`                                                                                                                           |
| **Defined in**            | #/$defs/targetNamespaces                                                                                                          |

**Description:** The namespaces to sync the secret into, or `ALL` for all namespaces

| One of(Option)                                                                    |
| --------------------------------------------------------------------------------- |
| [item 0](#global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i0) |
| [item 1](#global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i1) |

##### <a name="global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i0"></a>1.5.1.4.1. Property `base cluster configuration > global > imageCredentials > additionalProperties > targetNamespaces > oneOf > item 0`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `"ALL"`

##### <a name="global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i1"></a>1.5.1.4.2. Property `base cluster configuration > global > imageCredentials > additionalProperties > targetNamespaces > oneOf > item 1`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | True               |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                               | Description |
| --------------------------------------------------------------------------------------------- | ----------- |
| [item 1 items](#global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i1_items) | -           |

##### <a name="autogenerated_heading_2"></a>1.5.1.4.2.1. base cluster configuration > global > imageCredentials > additionalProperties > targetNamespaces > oneOf > item 1 > item 1 items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_kubectl"></a>1.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

**Description:** Image with `kubectl` binary

| Property                          | Pattern | Type   | Deprecated | Definition       | Title/Description |
| --------------------------------- | ------- | ------ | ---------- | ---------------- | ----------------- |
| - [image](#global_kubectl_image ) | No      | object | No         | In #/$defs/image | -                 |

#### <a name="global_kubectl_image"></a>1.6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl > image`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |
| **Defined in**            | #/$defs/image                                                                                            |

| Property                                          | Pattern | Type   | Deprecated | Definition | Title/Description              |
| ------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------ |
| - [registry](#global_kubectl_image_registry )     | No      | string | No         | -          | The host of the registry       |
| - [repository](#global_kubectl_image_repository ) | No      | string | No         | -          | The image path in the registry |
| - [tag](#global_kubectl_image_tag )               | No      | string | No         | -          | -                              |
| - [digest](#global_kubectl_image_digest )         | No      | string | No         | -          | -                              |

##### <a name="global_kubectl_image_registry"></a>1.6.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl > image > registry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The host of the registry

**Example:**

```yaml
docker.io
```

##### <a name="global_kubectl_image_repository"></a>1.6.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl > image > repository`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The image path in the registry

**Example:**

```yaml
bitnami/kubectl
```

##### <a name="global_kubectl_image_tag"></a>1.6.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl > image > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_kubectl_image_digest"></a>1.6.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl > image > digest`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_pause"></a>1.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > pause`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

**Description:** Image to be used for pause containers

| Property                        | Pattern | Type   | Deprecated | Definition                              | Title/Description |
| ------------------------------- | ------- | ------ | ---------- | --------------------------------------- | ----------------- |
| - [image](#global_pause_image ) | No      | object | No         | Same as [image](#global_kubectl_image ) | -                 |

#### <a name="global_pause_image"></a>1.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > pause > image`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |
| **Same definition as**    | [image](#global_kubectl_image)                                                                           |

### <a name="global_flux"></a>1.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > flux`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

**Description:** Image with `flux` binary

| Property                       | Pattern | Type   | Deprecated | Definition                              | Title/Description |
| ------------------------------ | ------- | ------ | ---------- | --------------------------------------- | ----------------- |
| - [image](#global_flux_image ) | No      | object | No         | Same as [image](#global_kubectl_image ) | -                 |

#### <a name="global_flux_image"></a>1.8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > flux > image`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |
| **Same definition as**    | [image](#global_kubectl_image)                                                                           |

### <a name="global_gpg"></a>1.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > gpg`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

**Description:** Image with `gpg` binary

| Property                      | Pattern | Type   | Deprecated | Definition                              | Title/Description |
| ----------------------------- | ------- | ------ | ---------- | --------------------------------------- | ----------------- |
| - [image](#global_gpg_image ) | No      | object | No         | Same as [image](#global_kubectl_image ) | -                 |

#### <a name="global_gpg_image"></a>1.9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > gpg > image`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |
| **Same definition as**    | [image](#global_kubectl_image)                                                                           |

### <a name="global_networkPolicy"></a>1.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                | Pattern | Type             | Deprecated | Definition | Title/Description                                                                                             |
| ------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------- |
| - [type](#global_networkPolicy_type )                   | No      | enum (of string) | No         | -          | Which networkPolicy to create, \`auto\` tries to detect the deployed framework, checking first for \`cilium\` |
| - [metricsLabels](#global_networkPolicy_metricsLabels ) | No      | object           | No         | -          | The labels used to allow ingress from the metrics service                                                     |
| - [dnsLabels](#global_networkPolicy_dnsLabels )         | No      | object           | No         | -          | The labels used to allow egress to the DNS service                                                            |

#### <a name="global_networkPolicy_type"></a>1.10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy > type`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

**Description:** Which networkPolicy to create, `auto` tries to detect the deployed framework, checking first for `cilium`

Must be one of:
* "none"
* "auto"
* "cilium"
* "kubernetes"

#### <a name="global_networkPolicy_metricsLabels"></a>1.10.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy > metricsLabels`

|                           |                                                                                                                                                                                                 |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                        |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_networkPolicy_metricsLabels_additionalProperties "Each additional property must conform to the following schema") |

**Description:** The labels used to allow ingress from the metrics service

| Property                                                                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#global_networkPolicy_metricsLabels_additionalProperties ) | No      | string | No         | -          | -                 |

##### <a name="global_networkPolicy_metricsLabels_additionalProperties"></a>1.10.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy > metricsLabels > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="global_networkPolicy_dnsLabels"></a>1.10.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy > dnsLabels`

|                           |                                                                                                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                    |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_networkPolicy_dnsLabels_additionalProperties "Each additional property must conform to the following schema") |

**Description:** The labels used to allow egress to the DNS service

| Property                                                                        | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#global_networkPolicy_dnsLabels_additionalProperties ) | No      | string | No         | -          | -                 |

##### <a name="global_networkPolicy_dnsLabels_additionalProperties"></a>1.10.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy > dnsLabels > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_helmRepositories"></a>1.11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories`

|                           |                                                                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_helmRepositories_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of helmRepositories to create, the key is the name

| Property                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#global_helmRepositories_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_helmRepositories_additionalProperties"></a>1.11.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                | Pattern | Type   | Deprecated | Definition           | Title/Description                                                                                            |
| ----------------------------------------------------------------------- | ------- | ------ | ---------- | -------------------- | ------------------------------------------------------------------------------------------------------------ |
| - [url](#global_helmRepositories_additionalProperties_url )             | No      | string | No         | -                    | -                                                                                                            |
| - [interval](#global_helmRepositories_additionalProperties_interval )   | No      | string | No         | -                    | The interval in which to update the repository                                                               |
| - [condition](#global_helmRepositories_additionalProperties_condition ) | No      | string | No         | In #/$defs/condition | A condition with which to decide to include the resource. This will be templated. Must return a truthy value |

##### <a name="global_helmRepositories_additionalProperties_url"></a>1.11.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                         |
| --------------------------------- | ----------------------------------------------------------------------- |
| **Must match regular expression** | ```https://.+``` [Test](https://regex101.com/?regex=https%3A%2F%2F.%2B) |

##### <a name="global_helmRepositories_additionalProperties_interval"></a>1.11.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties > interval`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The interval in which to update the repository

| Restrictions                      |                                                                             |
| --------------------------------- | --------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+[mhd]``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%5Bmhd%5D) |

##### <a name="global_helmRepositories_additionalProperties_condition"></a>1.11.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties > condition`

|                |                   |
| -------------- | ----------------- |
| **Type**       | `string`          |
| **Defined in** | #/$defs/condition |

**Description:** A condition with which to decide to include the resource. This will be templated. Must return a truthy value

**Examples:**

```yaml
{{ true }}
```

```yaml
{{ eq .Values.global.baseDomain "teuto.net" }}
```

### <a name="global_certificates"></a>1.12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > certificates`

|                           |                                                                                                                                                                                  |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                         |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_certificates_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of cert-manager certificates to create and sync its secrets into namespaces, the key is the name, therefore the secret name will be `$key`-certificate

| Property                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#global_certificates_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_certificates_additionalProperties"></a>1.12.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > certificates > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                          | Pattern | Type        | Deprecated | Definition                                                                                  | Title/Description                                                                                            |
| --------------------------------------------------------------------------------- | ------- | ----------- | ---------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| + [dnsNames](#global_certificates_additionalProperties_dnsNames )                 | No      | Combination | No         | -                                                                                           | The dnsNames to create                                                                                       |
| - [targetNamespaces](#global_certificates_additionalProperties_targetNamespaces ) | No      | object      | No         | Same as [targetNamespaces](#global_imageCredentials_additionalProperties_targetNamespaces ) | The namespaces to sync the secret into, or \`ALL\` for all namespaces                                        |
| - [condition](#global_certificates_additionalProperties_condition )               | No      | string      | No         | Same as [condition](#global_helmRepositories_additionalProperties_condition )               | A condition with which to decide to include the resource. This will be templated. Must return a truthy value |

##### <a name="global_certificates_additionalProperties_dnsNames"></a>1.12.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > certificates > additionalProperties > dnsNames`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

**Description:** The dnsNames to create

**Examples:**

```yaml
test.teuto.net
```

```yaml
*.test.teuto.net
```

| One of(Option)                                                        |
| --------------------------------------------------------------------- |
| [item 0](#global_certificates_additionalProperties_dnsNames_oneOf_i0) |
| [item 1](#global_certificates_additionalProperties_dnsNames_oneOf_i1) |

##### <a name="global_certificates_additionalProperties_dnsNames_oneOf_i0"></a>1.12.1.1.1. Property `base cluster configuration > global > certificates > additionalProperties > dnsNames > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** This will be templated

##### <a name="global_certificates_additionalProperties_dnsNames_oneOf_i1"></a>1.12.1.1.2. Property `base cluster configuration > global > certificates > additionalProperties > dnsNames > oneOf > item 1`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | True               |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                   | Description |
| --------------------------------------------------------------------------------- | ----------- |
| [item 1 items](#global_certificates_additionalProperties_dnsNames_oneOf_i1_items) | -           |

##### <a name="autogenerated_heading_3"></a>1.12.1.1.2.1. base cluster configuration > global > certificates > additionalProperties > dnsNames > oneOf > item 1 > item 1 items

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_certificates_additionalProperties_targetNamespaces"></a>1.12.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > certificates > additionalProperties > targetNamespaces`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Default**               | `"ALL"`                                                                                                                           |
| **Same definition as**    | [targetNamespaces](#global_imageCredentials_additionalProperties_targetNamespaces)                                                |

**Description:** The namespaces to sync the secret into, or `ALL` for all namespaces

##### <a name="global_certificates_additionalProperties_condition"></a>1.12.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > certificates > additionalProperties > condition`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `string`                                                             |
| **Same definition as** | [condition](#global_helmRepositories_additionalProperties_condition) |

**Description:** A condition with which to decide to include the resource. This will be templated. Must return a truthy value

### <a name="global_storageClass"></a>1.13. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > storageClass`

|                |                      |
| -------------- | -------------------- |
| **Type**       | `string or null`     |
| **Defined in** | #/$defs/storageClass |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

### <a name="global_namespaces"></a>1.14. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces`

|                           |                                                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                                                                       |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_namespaces_additionalProperties "Each additional property must conform to the following schema") |

**Description:** Namespaces to create. AND *delete* if removed

| Property                                                           | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#global_namespaces_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_namespaces_additionalProperties"></a>1.14.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                        | Pattern | Type   | Deprecated | Definition                                                                    | Title/Description                                                                                            |
| ------------------------------------------------------------------------------- | ------- | ------ | ---------- | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| - [additionalLabels](#global_namespaces_additionalProperties_additionalLabels ) | No      | object | No         | -                                                                             | -                                                                                                            |
| - [condition](#global_namespaces_additionalProperties_condition )               | No      | string | No         | Same as [condition](#global_helmRepositories_additionalProperties_condition ) | A condition with which to decide to include the resource. This will be templated. Must return a truthy value |

##### <a name="global_namespaces_additionalProperties_additionalLabels"></a>1.14.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > additionalLabels`

|                           |                                                                                                                                                                                                                      |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_namespaces_additionalProperties_additionalLabels_additionalProperties "Each additional property must conform to the following schema") |

| Property                                                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#global_namespaces_additionalProperties_additionalLabels_additionalProperties ) | No      | string | No         | -          | -                 |

##### <a name="global_namespaces_additionalProperties_additionalLabels_additionalProperties"></a>1.14.1.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > additionalLabels > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_namespaces_additionalProperties_condition"></a>1.14.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > condition`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `string`                                                             |
| **Same definition as** | [condition](#global_helmRepositories_additionalProperties_condition) |

**Description:** A condition with which to decide to include the resource. This will be templated. Must return a truthy value

## <a name="kyverno"></a>2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kyverno`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                       | Pattern | Type             | Deprecated | Definition | Title/Description                 |
| -------------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | --------------------------------- |
| - [enabled](#kyverno_enabled )                                 | No      | boolean          | No         | -          | -                                 |
| - [podSecurityStandard](#kyverno_podSecurityStandard )         | No      | enum (of string) | No         | -          | See https://kyverno.io/policies   |
| - [podSecuritySeverity](#kyverno_podSecuritySeverity )         | No      | enum (of string) | No         | -          | -                                 |
| - [validationFailureAction](#kyverno_validationFailureAction ) | No      | enum (of string) | No         | -          | Enforce means to deny the request |

### <a name="kyverno_enabled"></a>2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kyverno > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="kyverno_podSecurityStandard"></a>2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kyverno > podSecurityStandard`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

**Description:** See https://kyverno.io/policies

Must be one of:
* "baseline"
* "restricted"
* "privileged"
* "custom"

### <a name="kyverno_podSecuritySeverity"></a>2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kyverno > podSecuritySeverity`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "low"
* "medium"
* "high"

### <a name="kyverno_validationFailureAction"></a>2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kyverno > validationFailureAction`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

**Description:** Enforce means to deny the request

Must be one of:
* "audit"
* "enforce"

## <a name="monitoring"></a>3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                  | Pattern | Type   | Deprecated | Definition | Title/Description                                                                     |
| --------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------- |
| - [labels](#monitoring_labels )                           | No      | object | No         | -          | The labels to set on ServiceMonitors, ... and which the prometheus uses to search for |
| - [prometheus](#monitoring_prometheus )                   | No      | object | No         | -          | -                                                                                     |
| - [grafana](#monitoring_grafana )                         | No      | object | No         | -          | -                                                                                     |
| - [loki](#monitoring_loki )                               | No      | object | No         | -          | -                                                                                     |
| - [metricsServer](#monitoring_metricsServer )             | No      | object | No         | -          | -                                                                                     |
| - [storageCostAnalysis](#monitoring_storageCostAnalysis ) | No      | object | No         | -          | Configuration of the \`storageCostAnalysis dashboard                                  |
| - [securityScanning](#monitoring_securityScanning )       | No      | object | No         | -          | -                                                                                     |

### <a name="monitoring_labels"></a>3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > labels`

|                           |                                                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                                                                       |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_labels_additionalProperties "Each additional property must conform to the following schema") |

**Description:** The labels to set on ServiceMonitors, ... and which the prometheus uses to search for

| Property                                                           | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#monitoring_labels_additionalProperties ) | No      | string | No         | -          | -                 |

#### <a name="monitoring_labels_additionalProperties"></a>3.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > labels > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="monitoring_prometheus"></a>3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                         | Pattern | Type    | Deprecated | Definition                      | Title/Description                                                 |
| ---------------------------------------------------------------- | ------- | ------- | ---------- | ------------------------------- | ----------------------------------------------------------------- |
| - [enabled](#monitoring_prometheus_enabled )                     | No      | boolean | No         | -                               | -                                                                 |
| - [replicas](#monitoring_prometheus_replicas )                   | No      | integer | No         | -                               | -                                                                 |
| - [resources](#monitoring_prometheus_resources )                 | No      | object  | No         | In #/$defs/resourceRequirements | ResourceRequirements describes the compute resource requirements. |
| - [retentionDuration](#monitoring_prometheus_retentionDuration ) | No      | string  | No         | -                               | -                                                                 |
| - [retentionSize](#monitoring_prometheus_retentionSize )         | No      | string  | No         | -                               | -                                                                 |
| - [persistence](#monitoring_prometheus_persistence )             | No      | object  | No         | -                               | -                                                                 |
| - [operator](#monitoring_prometheus_operator )                   | No      | object  | No         | -                               | -                                                                 |
| - [kubeStateMetrics](#monitoring_prometheus_kubeStateMetrics )   | No      | object  | No         | -                               | -                                                                 |
| - [nodeExporter](#monitoring_prometheus_nodeExporter )           | No      | object  | No         | -                               | -                                                                 |
| - [ingress](#monitoring_prometheus_ingress )                     | No      | object  | No         | In #/$defs/toolIngress          | -                                                                 |
| - [alertmanager](#monitoring_prometheus_alertmanager )           | No      | object  | No         | -                               | -                                                                 |
| - [authentication](#monitoring_prometheus_authentication )       | No      | object  | No         | -                               | -                                                                 |

#### <a name="monitoring_prometheus_enabled"></a>3.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="monitoring_prometheus_replicas"></a>3.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

#### <a name="monitoring_prometheus_resources"></a>3.2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Defined in**            | #/$defs/resourceRequirements                                                                                                      |

**Description:** ResourceRequirements describes the compute resource requirements.

| Property                                                 | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                                                                                                                                                           |
| -------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [limits](#monitoring_prometheus_resources_limits )     | No      | object | No         | -          | Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/                                                                                                                                                 |
| - [requests](#monitoring_prometheus_resources_requests ) | No      | object | No         | -          | Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

##### <a name="monitoring_prometheus_resources_limits"></a>3.2.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > resources > limits`

|                           |                                                                                                                                                                                                     |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                            |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_prometheus_resources_limits_additionalProperties "Each additional property must conform to the following schema") |

**Description:** Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

| Property                                                                                | Pattern | Type   | Deprecated | Definition                                                     | Title/Description |
| --------------------------------------------------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------------------------- | ----------------- |
| - [additionalProperties](#monitoring_prometheus_resources_limits_additionalProperties ) | No      | object | No         | In #/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity | -                 |

##### <a name="monitoring_prometheus_resources_limits_additionalProperties"></a>3.2.3.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > resources > limits > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Defined in**            | #/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity                                                                       |

| One of(Option)                                                                  |
| ------------------------------------------------------------------------------- |
| [item 0](#monitoring_prometheus_resources_limits_additionalProperties_oneOf_i0) |
| [item 1](#monitoring_prometheus_resources_limits_additionalProperties_oneOf_i1) |

##### <a name="monitoring_prometheus_resources_limits_additionalProperties_oneOf_i0"></a>3.2.3.1.1.1. Property `base cluster configuration > monitoring > prometheus > resources > limits > additionalProperties > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="monitoring_prometheus_resources_limits_additionalProperties_oneOf_i1"></a>3.2.3.1.1.2. Property `base cluster configuration > monitoring > prometheus > resources > limits > additionalProperties > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `number` |

##### <a name="monitoring_prometheus_resources_requests"></a>3.2.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > resources > requests`

|                           |                                                                                                                                                                                                       |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                              |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_prometheus_resources_requests_additionalProperties "Each additional property must conform to the following schema") |

**Description:** Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

| Property                                                                                  | Pattern | Type   | Deprecated | Definition                                                                                                                           | Title/Description |
| ----------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ------------------------------------------------------------------------------------------------------------------------------------ | ----------------- |
| - [additionalProperties](#monitoring_prometheus_resources_requests_additionalProperties ) | No      | object | No         | Same as [monitoring_prometheus_resources_limits_additionalProperties](#monitoring_prometheus_resources_limits_additionalProperties ) | -                 |

##### <a name="monitoring_prometheus_resources_requests_additionalProperties"></a>3.2.3.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > resources > requests > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [monitoring_prometheus_resources_limits_additionalProperties](#monitoring_prometheus_resources_limits_additionalProperties)       |

#### <a name="monitoring_prometheus_retentionDuration"></a>3.2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > retentionDuration`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(ms\|s\|m\|h\|d\|w\|y)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28ms%7Cs%7Cm%7Ch%7Cd%7Cw%7Cy%29) |

#### <a name="monitoring_prometheus_retentionSize"></a>3.2.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > retentionSize`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                                                               |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(B\|KB\|MB\|GB\|TB\|PB\|EB)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28B%7CKB%7CMB%7CGB%7CTB%7CPB%7CEB%29) |

#### <a name="monitoring_prometheus_persistence"></a>3.2.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > persistence`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                           | Pattern | Type           | Deprecated | Definition                                    | Title/Description                                                                                                |
| ------------------------------------------------------------------ | ------- | -------------- | ---------- | --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [storageClass](#monitoring_prometheus_persistence_storageClass ) | No      | string or null | No         | Same as [storageClass](#global_storageClass ) | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |
| - [size](#monitoring_prometheus_persistence_size )                 | No      | object         | No         | In #/$defs/quantity                           | -                                                                                                                |

##### <a name="monitoring_prometheus_persistence_storageClass"></a>3.2.6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string or null`                     |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

##### <a name="monitoring_prometheus_persistence_size"></a>3.2.6.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > persistence > size`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Defined in**            | #/$defs/quantity                                                                                                                  |

#### <a name="monitoring_prometheus_operator"></a>3.2.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > operator`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                  | Pattern | Type   | Deprecated | Definition                                             | Title/Description                                                 |
| --------------------------------------------------------- | ------- | ------ | ---------- | ------------------------------------------------------ | ----------------------------------------------------------------- |
| - [resources](#monitoring_prometheus_operator_resources ) | No      | object | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_prometheus_operator_resources"></a>3.2.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > operator > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_prometheus_kubeStateMetrics"></a>3.2.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                                  | Pattern | Type   | Deprecated | Definition                                             | Title/Description                                                         |
| ----------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ------------------------------------------------------ | ------------------------------------------------------------------------- |
| - [resources](#monitoring_prometheus_kubeStateMetrics_resources )                         | No      | object | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements.         |
| - [metricLabelsAllowList](#monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList ) | No      | object | No         | -                                                      | A map of resource/[label] that will be set as labels on the state metrics |

##### <a name="monitoring_prometheus_kubeStateMetrics_resources"></a>3.2.8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

##### <a name="monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList"></a>3.2.8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics > metricLabelsAllowList`

|                           |                                                                                                                                                                                                                           |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                                                  |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of resource/[label] that will be set as labels on the state metrics

| Property                                                                                                      | Pattern | Type            | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [additionalProperties](#monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties ) | No      | array of string | No         | -          | -                 |

##### <a name="monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties"></a>3.2.8.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics > metricLabelsAllowList > additionalProperties`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | True               |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                                                        | Description |
| ---------------------------------------------------------------------------------------------------------------------- | ----------- |
| [additionalProperties items](#monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties_items) | -           |

##### <a name="autogenerated_heading_4"></a>3.2.8.2.1.1. base cluster configuration > monitoring > prometheus > kubeStateMetrics > metricLabelsAllowList > additionalProperties > additionalProperties items

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_prometheus_nodeExporter"></a>3.2.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > nodeExporter`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                      | Pattern | Type   | Deprecated | Definition                                             | Title/Description                                                 |
| ------------------------------------------------------------- | ------- | ------ | ---------- | ------------------------------------------------------ | ----------------------------------------------------------------- |
| - [resources](#monitoring_prometheus_nodeExporter_resources ) | No      | object | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_prometheus_nodeExporter_resources"></a>3.2.9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > nodeExporter > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_prometheus_ingress"></a>3.2.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |
| **Defined in**            | #/$defs/toolIngress                                                                                      |

| Property                                                       | Pattern | Type           | Deprecated | Definition | Title/Description                                                          |
| -------------------------------------------------------------- | ------- | -------------- | ---------- | ---------- | -------------------------------------------------------------------------- |
| - [enabled](#monitoring_prometheus_ingress_enabled )           | No      | boolean        | No         | -          | -                                                                          |
| - [host](#monitoring_prometheus_ingress_host )                 | No      | string         | No         | -          | The subdomain to use under \`.global.customerName\`.\`.global.baseDomain\` |
| - [customDomain](#monitoring_prometheus_ingress_customDomain ) | No      | string or null | No         | -          | The full custom domain to use                                              |

##### <a name="monitoring_prometheus_ingress_enabled"></a>3.2.10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="monitoring_prometheus_ingress_host"></a>3.2.10.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress > host`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The subdomain to use under `.global.customerName`.`.global.baseDomain`

##### <a name="monitoring_prometheus_ingress_customDomain"></a>3.2.10.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress > customDomain`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

**Description:** The full custom domain to use

#### <a name="monitoring_prometheus_alertmanager"></a>3.2.11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                      | Pattern | Type    | Deprecated | Definition                                         | Title/Description |
| ----------------------------------------------------------------------------- | ------- | ------- | ---------- | -------------------------------------------------- | ----------------- |
| - [ingress](#monitoring_prometheus_alertmanager_ingress )                     | No      | object  | No         | Same as [ingress](#monitoring_prometheus_ingress ) | -                 |
| - [replicas](#monitoring_prometheus_alertmanager_replicas )                   | No      | integer | No         | -                                                  | -                 |
| - [retentionDuration](#monitoring_prometheus_alertmanager_retentionDuration ) | No      | string  | No         | -                                                  | -                 |
| - [persistence](#monitoring_prometheus_alertmanager_persistence )             | No      | object  | No         | -                                                  | -                 |

##### <a name="monitoring_prometheus_alertmanager_ingress"></a>3.2.11.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > ingress`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |
| **Same definition as**    | [ingress](#monitoring_prometheus_ingress)                                                                |

##### <a name="monitoring_prometheus_alertmanager_replicas"></a>3.2.11.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

##### <a name="monitoring_prometheus_alertmanager_retentionDuration"></a>3.2.11.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > retentionDuration`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(ms\|s\|m\|h\|d\|w\|y)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28ms%7Cs%7Cm%7Ch%7Cd%7Cw%7Cy%29) |

##### <a name="monitoring_prometheus_alertmanager_persistence"></a>3.2.11.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > persistence`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                        | Pattern | Type           | Deprecated | Definition                                               | Title/Description                                                                                                |
| ------------------------------------------------------------------------------- | ------- | -------------- | ---------- | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [storageClass](#monitoring_prometheus_alertmanager_persistence_storageClass ) | No      | string or null | No         | Same as [storageClass](#global_storageClass )            | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |
| - [size](#monitoring_prometheus_alertmanager_persistence_size )                 | No      | object         | No         | Same as [size](#monitoring_prometheus_persistence_size ) | -                                                                                                                |

##### <a name="monitoring_prometheus_alertmanager_persistence_storageClass"></a>3.2.11.4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string or null`                     |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

##### <a name="monitoring_prometheus_alertmanager_persistence_size"></a>3.2.11.4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > persistence > size`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [size](#monitoring_prometheus_persistence_size)                                                                                   |

#### <a name="monitoring_prometheus_authentication"></a>3.2.12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > authentication`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                    | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#monitoring_prometheus_authentication_enabled ) | No      | boolean | No         | -          | -                 |

##### <a name="monitoring_prometheus_authentication_enabled"></a>3.2.12.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > authentication > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="monitoring_grafana"></a>3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                            | Pattern | Type            | Deprecated | Definition                                             | Title/Description                                                       |
| ------------------------------------------------------------------- | ------- | --------------- | ---------- | ------------------------------------------------------ | ----------------------------------------------------------------------- |
| - [adminPassword](#monitoring_grafana_adminPassword )               | No      | string or null  | No         | -                                                      | -                                                                       |
| - [ingress](#monitoring_grafana_ingress )                           | No      | object          | No         | Same as [ingress](#monitoring_prometheus_ingress )     | -                                                                       |
| - [additionalDashboards](#monitoring_grafana_additionalDashboards ) | No      | object          | No         | -                                                      | -                                                                       |
| - [config](#monitoring_grafana_config )                             | No      | object          | No         | -                                                      | -                                                                       |
| - [notifiers](#monitoring_grafana_notifiers )                       | No      | array of object | No         | -                                                      | See https://grafana.com/docs/grafana/latest/administration/provisioning |
| - [additionalPlugins](#monitoring_grafana_additionalPlugins )       | No      | array of string | No         | -                                                      | -                                                                       |
| - [resources](#monitoring_grafana_resources )                       | No      | object          | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements.       |
| - [sidecar](#monitoring_grafana_sidecar )                           | No      | object          | No         | -                                                      | -                                                                       |

#### <a name="monitoring_grafana_adminPassword"></a>3.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > adminPassword`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

#### <a name="monitoring_grafana_ingress"></a>3.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > ingress`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |
| **Same definition as**    | [ingress](#monitoring_prometheus_ingress)                                                                |

#### <a name="monitoring_grafana_additionalDashboards"></a>3.3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalDashboards`

|                           |                                                                                                                                                                                                      |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_grafana_additionalDashboards_additionalProperties "Each additional property must conform to the following schema") |

| Property                                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#monitoring_grafana_additionalDashboards_additionalProperties ) | No      | object | No         | -          | -                 |

##### <a name="monitoring_grafana_additionalDashboards_additionalProperties"></a>3.3.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                                  | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [gnetId](#monitoring_grafana_additionalDashboards_additionalProperties_gnetId )         | No      | integer | No         | -          | -                 |
| - [revision](#monitoring_grafana_additionalDashboards_additionalProperties_revision )     | No      | integer | No         | -          | -                 |
| - [datasource](#monitoring_grafana_additionalDashboards_additionalProperties_datasource ) | No      | string  | No         | -          | -                 |

##### <a name="monitoring_grafana_additionalDashboards_additionalProperties_gnetId"></a>3.3.3.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties > gnetId`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

##### <a name="monitoring_grafana_additionalDashboards_additionalProperties_revision"></a>3.3.3.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties > revision`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

##### <a name="monitoring_grafana_additionalDashboards_additionalProperties_datasource"></a>3.3.3.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties > datasource`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_grafana_config"></a>3.3.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > config`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

#### <a name="monitoring_grafana_notifiers"></a>3.3.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > notifiers`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of object` |

**Description:** See https://grafana.com/docs/grafana/latest/administration/provisioning

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                        | Description |
| ------------------------------------------------------ | ----------- |
| [notifiers items](#monitoring_grafana_notifiers_items) | -           |

##### <a name="autogenerated_heading_5"></a>3.3.5.1. base cluster configuration > monitoring > grafana > notifiers > notifiers items

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                              | Pattern | Type    | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [name](#monitoring_grafana_notifiers_items_name )                   | No      | string  | No         | -          | -                 |
| + [type](#monitoring_grafana_notifiers_items_type )                   | No      | string  | No         | -          | -                 |
| - [uid](#monitoring_grafana_notifiers_items_uid )                     | No      | string  | No         | -          | -                 |
| - [org_id](#monitoring_grafana_notifiers_items_org_id )               | No      | integer | No         | -          | -                 |
| - [is_default](#monitoring_grafana_notifiers_items_is_default )       | No      | boolean | No         | -          | -                 |
| - [send_reminder](#monitoring_grafana_notifiers_items_send_reminder ) | No      | boolean | No         | -          | -                 |
| - [frequency](#monitoring_grafana_notifiers_items_frequency )         | No      | string  | No         | -          | -                 |
| - [settings](#monitoring_grafana_notifiers_items_settings )           | No      | object  | No         | -          | -                 |

##### <a name="monitoring_grafana_notifiers_items_name"></a>3.3.5.1.1. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="monitoring_grafana_notifiers_items_type"></a>3.3.5.1.2. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > type`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="monitoring_grafana_notifiers_items_uid"></a>3.3.5.1.3. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > uid`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="monitoring_grafana_notifiers_items_org_id"></a>3.3.5.1.4. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > org_id`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

##### <a name="monitoring_grafana_notifiers_items_is_default"></a>3.3.5.1.5. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > is_default`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="monitoring_grafana_notifiers_items_send_reminder"></a>3.3.5.1.6. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > send_reminder`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="monitoring_grafana_notifiers_items_frequency"></a>3.3.5.1.7. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > frequency`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="monitoring_grafana_notifiers_items_settings"></a>3.3.5.1.8. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > settings`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

#### <a name="monitoring_grafana_additionalPlugins"></a>3.3.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalPlugins`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | True               |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                        | Description |
| ---------------------------------------------------------------------- | ----------- |
| [additionalPlugins items](#monitoring_grafana_additionalPlugins_items) | -           |

##### <a name="autogenerated_heading_6"></a>3.3.6.1. base cluster configuration > monitoring > grafana > additionalPlugins > additionalPlugins items

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_grafana_resources"></a>3.3.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_grafana_sidecar"></a>3.3.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > sidecar`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                              | Pattern | Type   | Deprecated | Definition                                             | Title/Description                                                 |
| ----------------------------------------------------- | ------- | ------ | ---------- | ------------------------------------------------------ | ----------------------------------------------------------------- |
| - [resources](#monitoring_grafana_sidecar_resources ) | No      | object | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_grafana_sidecar_resources"></a>3.3.8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > sidecar > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="monitoring_loki"></a>3.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                       | Pattern | Type    | Deprecated | Definition                                             | Title/Description                                                 |
| ---------------------------------------------- | ------- | ------- | ---------- | ------------------------------------------------------ | ----------------------------------------------------------------- |
| - [enabled](#monitoring_loki_enabled )         | No      | boolean | No         | -                                                      | -                                                                 |
| - [persistence](#monitoring_loki_persistence ) | No      | object  | No         | -                                                      | -                                                                 |
| - [replicas](#monitoring_loki_replicas )       | No      | integer | No         | -                                                      | -                                                                 |
| - [resources](#monitoring_loki_resources )     | No      | object  | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements. |
| - [promtail](#monitoring_loki_promtail )       | No      | object  | No         | -                                                      | -                                                                 |

#### <a name="monitoring_loki_enabled"></a>3.4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="monitoring_loki_persistence"></a>3.4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > persistence`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                     | Pattern | Type           | Deprecated | Definition                                               | Title/Description                                                                                                |
| ------------------------------------------------------------ | ------- | -------------- | ---------- | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [size](#monitoring_loki_persistence_size )                 | No      | object         | No         | Same as [size](#monitoring_prometheus_persistence_size ) | -                                                                                                                |
| - [storageClass](#monitoring_loki_persistence_storageClass ) | No      | string or null | No         | Same as [storageClass](#global_storageClass )            | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |

##### <a name="monitoring_loki_persistence_size"></a>3.4.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > persistence > size`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [size](#monitoring_prometheus_persistence_size)                                                                                   |

##### <a name="monitoring_loki_persistence_storageClass"></a>3.4.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string or null`                     |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

#### <a name="monitoring_loki_replicas"></a>3.4.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

#### <a name="monitoring_loki_resources"></a>3.4.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_loki_promtail"></a>3.4.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > promtail`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                            | Pattern | Type   | Deprecated | Definition                                             | Title/Description                                                 |
| --------------------------------------------------- | ------- | ------ | ---------- | ------------------------------------------------------ | ----------------------------------------------------------------- |
| - [resources](#monitoring_loki_promtail_resources ) | No      | object | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_loki_promtail_resources"></a>3.4.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > promtail > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="monitoring_metricsServer"></a>3.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > metricsServer`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                        | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#monitoring_metricsServer_enabled ) | No      | boolean | No         | -          | -                 |

#### <a name="monitoring_metricsServer_enabled"></a>3.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > metricsServer > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="monitoring_storageCostAnalysis"></a>3.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

**Description:** Configuration of the `storageCostAnalysis dashboard

| Property                                                                      | Pattern | Type   | Deprecated | Definition | Title/Description                                     |
| ----------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------------------------------------------- |
| - [period](#monitoring_storageCostAnalysis_period )                           | No      | string | No         | -          | The billing period                                    |
| - [currency](#monitoring_storageCostAnalysis_currency )                       | No      | string | No         | -          | -                                                     |
| - [storageClassMapping](#monitoring_storageCostAnalysis_storageClassMapping ) | No      | object | No         | -          | A map of storageClasses to their cost per GiB/$period |

#### <a name="monitoring_storageCostAnalysis_period"></a>3.6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis > period`

|             |          |
| ----------- | -------- |
| **Type**    | `string` |
| **Default** | `"Day"`  |

**Description:** The billing period

**Examples:**

```yaml
Day
```

```yaml
Month
```

#### <a name="monitoring_storageCostAnalysis_currency"></a>3.6.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis > currency`

|             |                 |
| ----------- | --------------- |
| **Type**    | `string`        |
| **Default** | `"currencyEUR"` |

**Examples:**

```yaml
currencyUSD
```

```yaml
currencyEUR
```

#### <a name="monitoring_storageCostAnalysis_storageClassMapping"></a>3.6.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis > storageClassMapping`

|                           |                                                                                                                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                                        |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_storageCostAnalysis_storageClassMapping_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of storageClasses to their cost per GiB/$period

| Property                                                                                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#monitoring_storageCostAnalysis_storageClassMapping_additionalProperties ) | No      | number | No         | -          | -                 |

##### <a name="monitoring_storageCostAnalysis_storageClassMapping_additionalProperties"></a>3.6.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis > storageClassMapping > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `number` |

### <a name="monitoring_securityScanning"></a>3.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > securityScanning`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                           | Pattern | Type    | Deprecated | Definition | Title/Description |
| -------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#monitoring_securityScanning_enabled ) | No      | boolean | No         | -          | -                 |

#### <a name="monitoring_securityScanning_enabled"></a>3.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > securityScanning > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

## <a name="descheduler"></a>4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                 | Pattern | Type    | Deprecated | Definition | Title/Description                                                                                    |
| ---------------------------------------- | ------- | ------- | ---------- | ---------- | ---------------------------------------------------------------------------------------------------- |
| - [enabled](#descheduler_enabled )       | No      | boolean | No         | -          | -                                                                                                    |
| - [strategies](#descheduler_strategies ) | No      | object  | No         | -          | See https://github.com/kubernetes-sigs/descheduler#policy-and-strategies. The key is the policy name |

### <a name="descheduler_enabled"></a>4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="descheduler_strategies"></a>4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > strategies`

|                           |                                                                                                                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                            |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#descheduler_strategies_additionalProperties "Each additional property must conform to the following schema") |

**Description:** See https://github.com/kubernetes-sigs/descheduler#policy-and-strategies. The key is the policy name

| Property                                                                | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#descheduler_strategies_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="descheduler_strategies_additionalProperties"></a>4.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > strategies > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                           | Pattern | Type    | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------ | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#descheduler_strategies_additionalProperties_enabled ) | No      | boolean | No         | -          | -                 |
| - [params](#descheduler_strategies_additionalProperties_params )   | No      | object  | No         | -          | -                 |

##### <a name="descheduler_strategies_additionalProperties_enabled"></a>4.2.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > strategies > additionalProperties > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="descheduler_strategies_additionalProperties_params"></a>4.2.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > strategies > additionalProperties > params`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#descheduler_strategies_additionalProperties_params_additionalProperties ) | No      | object | No         | -          | -                 |

## <a name="dns"></a>5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > dns`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                     | Pattern | Type            | Deprecated | Definition | Title/Description                                                                                           |
| ---------------------------- | ------- | --------------- | ---------- | ---------- | ----------------------------------------------------------------------------------------------------------- |
| - [provider](#dns_provider ) | No      | Combination     | No         | -          | Setting a provider enabled various DNS based features, such as \`external-dns\`, wildcard certificates, ... |
| - [domains](#dns_domains )   | No      | array of string | No         | -          | -                                                                                                           |

### <a name="dns_provider"></a>5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > dns > provider`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

**Description:** Setting a provider enabled various DNS based features, such as `external-dns`, wildcard certificates, ...

| One of(Option)                   |
| -------------------------------- |
| [item 0](#dns_provider_oneOf_i0) |
| [item 1](#dns_provider_oneOf_i1) |

#### <a name="dns_provider_oneOf_i0"></a>5.1.1. Property `base cluster configuration > dns > provider > oneOf > item 0`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                           | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [cloudflare](#dns_provider_oneOf_i0_cloudflare ) | No      | object | No         | -          | -                 |

##### <a name="dns_provider_oneOf_i0_cloudflare"></a>5.1.1.1. Property `base cluster configuration > dns > provider > oneOf > item 0 > cloudflare`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                  | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [apiToken](#dns_provider_oneOf_i0_cloudflare_apiToken ) | No      | string | No         | -          | -                 |

##### <a name="dns_provider_oneOf_i0_cloudflare_apiToken"></a>5.1.1.1.1. Property `base cluster configuration > dns > provider > oneOf > item 0 > cloudflare > apiToken`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="dns_provider_oneOf_i1"></a>5.1.2. Property `base cluster configuration > dns > provider > oneOf > item 1`

|          |        |
| -------- | ------ |
| **Type** | `null` |

### <a name="dns_domains"></a>5.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > dns > domains`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | True               |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be     | Description |
| ----------------------------------- | ----------- |
| [domains items](#dns_domains_items) | -           |

#### <a name="autogenerated_heading_7"></a>5.2.1. base cluster configuration > dns > domains > domains items

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="certManager"></a>6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                           | Pattern | Type           | Deprecated | Definition                                                                                                         | Title/Description                                                                      |
| ------------------------------------------------------------------ | ------- | -------------- | ---------- | ------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| - [resources](#certManager_resources )                             | No      | object         | No         | In https://kubernetesjsonschema.dev/v1.18.1/_definitions.json#/definitions/io.k8s.api.core.v1.ResourceRequirements | ResourceRequirements describes the compute resource requirements.                      |
| - [email](#certManager_email )                                     | No      | string or null | No         | In #/$defs/email                                                                                                   | Setting an email enables cert-manager's IngressShim and will be used for Let's Encrypt |
| - [webhook](#certManager_webhook )                                 | No      | object         | No         | -                                                                                                                  | -                                                                                      |
| - [caInjector](#certManager_caInjector )                           | No      | object         | No         | -                                                                                                                  | -                                                                                      |
| - [dnsChallengeNameservers](#certManager_dnsChallengeNameservers ) | No      | object         | No         | -                                                                                                                  | -                                                                                      |

### <a name="certManager_resources"></a>6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Defined in**            | https://kubernetesjsonschema.dev/v1.18.1/_definitions.json#/definitions/io.k8s.api.core.v1.ResourceRequirements                   |

**Description:** ResourceRequirements describes the compute resource requirements.

| Property                                       | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                                                                                                                                                                  |
| ---------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| - [limits](#certManager_resources_limits )     | No      | object | No         | -          | Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/                                                                                                                                                 |
| - [requests](#certManager_resources_requests ) | No      | object | No         | -          | Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/ |

#### <a name="certManager_resources_limits"></a>6.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > resources > limits`

|                           |                                                                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                  |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#certManager_resources_limits_additionalProperties "Each additional property must conform to the following schema") |

**Description:** Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/

| Property                                                                      | Pattern | Type   | Deprecated | Definition                                                     | Title/Description |
| ----------------------------------------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------------------------- | ----------------- |
| - [additionalProperties](#certManager_resources_limits_additionalProperties ) | No      | object | No         | In #/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity | -                 |

##### <a name="certManager_resources_limits_additionalProperties"></a>6.1.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > resources > limits > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Defined in**            | #/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity                                                                       |

| One of(Option)                                                        |
| --------------------------------------------------------------------- |
| [item 0](#certManager_resources_limits_additionalProperties_oneOf_i0) |
| [item 1](#certManager_resources_limits_additionalProperties_oneOf_i1) |

##### <a name="certManager_resources_limits_additionalProperties_oneOf_i0"></a>6.1.1.1.1. Property `base cluster configuration > certManager > resources > limits > additionalProperties > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="certManager_resources_limits_additionalProperties_oneOf_i1"></a>6.1.1.1.2. Property `base cluster configuration > certManager > resources > limits > additionalProperties > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `number` |

#### <a name="certManager_resources_requests"></a>6.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > resources > requests`

|                           |                                                                                                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                    |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#certManager_resources_requests_additionalProperties "Each additional property must conform to the following schema") |

**Description:** Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/

| Property                                                                        | Pattern | Type   | Deprecated | Definition                                                                                                       | Title/Description |
| ------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------------------------------------------------------------------------------------------------------------- | ----------------- |
| - [additionalProperties](#certManager_resources_requests_additionalProperties ) | No      | object | No         | Same as [certManager_resources_limits_additionalProperties](#certManager_resources_limits_additionalProperties ) | -                 |

##### <a name="certManager_resources_requests_additionalProperties"></a>6.1.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > resources > requests > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [certManager_resources_limits_additionalProperties](#certManager_resources_limits_additionalProperties)                           |

### <a name="certManager_email"></a>6.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > email`

|                |                  |
| -------------- | ---------------- |
| **Type**       | `string or null` |
| **Defined in** | #/$defs/email    |

**Description:** Setting an email enables cert-manager's IngressShim and will be used for Let's Encrypt

| Restrictions                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```(?:[a-z0-9!#$%&'*+/=?^_`{\|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{\|}~-]+)*\|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\|\[(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\.){3}(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])``` [Test](https://regex101.com/?regex=%28%3F%3A%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%28%3F%3A%5C.%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%29%2A%7C%22%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21%5Cx23-%5Cx5b%5Cx5d-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2A%22%29%40%28%3F%3A%28%3F%3A%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%5C.%29%2B%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%7C%5C%5B%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%5C.%29%7B3%7D%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%7C%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%3A%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21-%5Cx5a%5Cx53-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2B%29%5C%5D%29) |

### <a name="certManager_webhook"></a>6.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > webhook`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                       | Pattern | Type   | Deprecated | Definition                                   | Title/Description                                                 |
| ---------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------- | ----------------------------------------------------------------- |
| - [resources](#certManager_webhook_resources ) | No      | object | No         | Same as [resources](#certManager_resources ) | ResourceRequirements describes the compute resource requirements. |

#### <a name="certManager_webhook_resources"></a>6.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > webhook > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#certManager_resources)                                                                                               |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="certManager_caInjector"></a>6.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > caInjector`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                          | Pattern | Type   | Deprecated | Definition                                   | Title/Description                                                 |
| ------------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------- | ----------------------------------------------------------------- |
| - [resources](#certManager_caInjector_resources ) | No      | object | No         | Same as [resources](#certManager_resources ) | ResourceRequirements describes the compute resource requirements. |

#### <a name="certManager_caInjector_resources"></a>6.4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > caInjector > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#certManager_resources)                                                                                               |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="certManager_dnsChallengeNameservers"></a>6.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > dnsChallengeNameservers`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                                            | Pattern | Type    | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [^((25[0-5]\|(2[0-4]\|1\d\|[1-9]\|)\d)\.?\b){4}$](#certManager_dnsChallengeNameservers_pattern1 ) | Yes     | integer | No         | -          | -                 |

#### <a name="certManager_dnsChallengeNameservers_pattern1"></a>6.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Pattern Property `base cluster configuration > certManager > dnsChallengeNameservers > ^((25[0-5]\|(2[0-4]\|1\d\|[1-9]\|)\d)\.?\b){4}$`
> All properties whose name matches the regular expression
```^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$``` ([Test](https://regex101.com/?regex=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%24))
must respect the following conditions

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |            |
| ------------ | ---------- |
| **Minimum**  | &ge; 1     |
| **Maximum**  | &le; 65535 |

## <a name="externalDNS"></a>7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > externalDNS`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                               | Pattern | Type   | Deprecated | Definition                                   | Title/Description                                                 |
| -------------------------------------- | ------- | ------ | ---------- | -------------------------------------------- | ----------------------------------------------------------------- |
| - [resources](#externalDNS_resources ) | No      | object | No         | Same as [resources](#certManager_resources ) | ResourceRequirements describes the compute resource requirements. |

### <a name="externalDNS_resources"></a>7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > externalDNS > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#certManager_resources)                                                                                               |

**Description:** ResourceRequirements describes the compute resource requirements.

## <a name="flux"></a>8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                    | Pattern | Type   | Deprecated | Definition | Title/Description                  |
| ------------------------------------------- | ------- | ------ | ---------- | ---------- | ---------------------------------- |
| - [gitRepositories](#flux_gitRepositories ) | No      | object | No         | -          | A map of gitRepositories to create |

### <a name="flux_gitRepositories"></a>8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories`

|                           |                                                                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                          |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#flux_gitRepositories_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of gitRepositories to create

| Property                                                              | Pattern | Type        | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [additionalProperties](#flux_gitRepositories_additionalProperties ) | No      | Combination | No         | -          | -                 |

#### <a name="flux_gitRepositories_additionalProperties"></a>8.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description                            |
| ------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | -------------------------------------------- |
| - [gitInterval](#flux_gitRepositories_additionalProperties_gitInterval ) | No      | string | No         | -          | The interval in which to sync the repository |
| - [decryption](#flux_gitRepositories_additionalProperties_decryption )   | No      | object | No         | -          | -                                            |

| All of(Requirement)                                           |
| ------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i1) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0"></a>8.1.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| One of(Option)                                                         |
| ---------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1) |
| [item 2](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i2) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0"></a>8.1.1.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [url](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_url )           | No      | string | No         | -          | -                 |
| - [username](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_username ) | No      | const  | No         | -          | -                 |
| - [password](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_password ) | No      | const  | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_url"></a>8.1.1.1.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                         |
| --------------------------------- | ----------------------------------------------------------------------- |
| **Must match regular expression** | ```https://.+``` [Test](https://regex101.com/?regex=https%3A%2F%2F.%2B) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_username"></a>8.1.1.1.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > username`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `{
    "description": "😅 ERROR in schema generation, a referenced schema could not be loaded, no documentation here unfortunately 🏜️"
}`

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_password"></a>8.1.1.1.1.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > password`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `{
    "description": "😅 ERROR in schema generation, a referenced schema could not be loaded, no documentation here unfortunately 🏜️"
}`

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1"></a>8.1.1.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [url](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_url )           | No      | string | No         | -          | -                 |
| + [password](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_password ) | No      | string | No         | -          | -                 |
| + [username](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_username ) | No      | string | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_url"></a>8.1.1.1.2.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1 > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                         |
| --------------------------------- | ----------------------------------------------------------------------- |
| **Must match regular expression** | ```https://.+``` [Test](https://regex101.com/?regex=https%3A%2F%2F.%2B) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_password"></a>8.1.1.1.2.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1 > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_username"></a>8.1.1.1.2.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1 > username`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i2"></a>8.1.1.1.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 2`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [url](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i2_url ) | No      | string | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i2_url"></a>8.1.1.1.3.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 2 > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                               |
| --------------------------------- | ----------------------------------------------------------------------------- |
| **Must match regular expression** | ```ssh://.+@.+``` [Test](https://regex101.com/?regex=ssh%3A%2F%2F.%2B%40.%2B) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1"></a>8.1.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| One of(Option)                                                         |
| ---------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i1) |
| [item 2](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i2) |
| [item 3](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i3) |
| [item 4](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i0"></a>8.1.1.2.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 0`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                         | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [branch](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i0_branch ) | No      | string | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i0_branch"></a>8.1.1.2.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 0 > branch`

|             |            |
| ----------- | ---------- |
| **Type**    | `string`   |
| **Default** | `"master"` |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i1"></a>8.1.1.2.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 1`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                         | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [commit](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i1_commit ) | No      | string | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i1_commit"></a>8.1.1.2.2.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 1 > commit`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i2"></a>8.1.1.2.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 2`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                         | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [semver](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i2_semver ) | No      | string | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i2_semver"></a>8.1.1.2.3.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 2 > semver`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i3"></a>8.1.1.2.4. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 3`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [tag](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i3_tag ) | No      | string | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i3_tag"></a>8.1.1.2.4.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 3 > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4"></a>8.1.1.2.5. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| Property                                                                         | Pattern | Type  | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------- | ------- | ----- | ---------- | ---------- | ----------------- |
| - [branch](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_branch ) | No      | const | No         | -          | -                 |
| - [commit](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_commit ) | No      | const | No         | -          | -                 |
| - [semver](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_semver ) | No      | const | No         | -          | -                 |
| - [tag](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_tag )       | No      | const | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_branch"></a>8.1.1.2.5.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > branch`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `{
    "description": "😅 ERROR in schema generation, a referenced schema could not be loaded, no documentation here unfortunately 🏜️"
}`

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_commit"></a>8.1.1.2.5.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > commit`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `{
    "description": "😅 ERROR in schema generation, a referenced schema could not be loaded, no documentation here unfortunately 🏜️"
}`

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_semver"></a>8.1.1.2.5.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > semver`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `{
    "description": "😅 ERROR in schema generation, a referenced schema could not be loaded, no documentation here unfortunately 🏜️"
}`

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_tag"></a>8.1.1.2.5.4. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > tag`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `{
    "description": "😅 ERROR in schema generation, a referenced schema could not be loaded, no documentation here unfortunately 🏜️"
}`

##### <a name="autogenerated_heading_8"></a>8.1.1.3. The following properties are required
* url

##### <a name="flux_gitRepositories_additionalProperties_gitInterval"></a>8.1.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > gitInterval`

|             |          |
| ----------- | -------- |
| **Type**    | `string` |
| **Default** | `"1m"`   |

**Description:** The interval in which to sync the repository

| Restrictions                      |                                                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(ms\|s\|m\|h\|d\|w\|y)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28ms%7Cs%7Cm%7Ch%7Cd%7Cw%7Cy%29) |

##### <a name="flux_gitRepositories_additionalProperties_decryption"></a>8.1.1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > decryption`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                      | Pattern | Type             | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| + [provider](#flux_gitRepositories_additionalProperties_decryption_provider ) | No      | enum (of string) | No         | -          | -                 |

##### <a name="flux_gitRepositories_additionalProperties_decryption_provider"></a>8.1.1.5.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > flux > gitRepositories > additionalProperties > decryption > provider`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "sops"

## <a name="ingress"></a>9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                           | Pattern | Type           | Deprecated | Definition                                             | Title/Description                                                 |
| ---------------------------------- | ------- | -------------- | ---------- | ------------------------------------------------------ | ----------------------------------------------------------------- |
| - [replicas](#ingress_replicas )   | No      | integer        | No         | -                                                      | -                                                                 |
| - [resources](#ingress_resources ) | No      | object         | No         | Same as [resources](#monitoring_prometheus_resources ) | ResourceRequirements describes the compute resource requirements. |
| - [IP](#ingress_IP )               | No      | string or null | No         | -                                                      | Try to use specified IP as loadbalancer IP                        |

### <a name="ingress_replicas"></a>9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

### <a name="ingress_resources"></a>9.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > resources`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [resources](#monitoring_prometheus_resources)                                                                                     |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="ingress_IP"></a>9.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > IP`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

**Description:** Try to use specified IP as loadbalancer IP

| Restrictions                      |                                                                                                                                                                                         |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```^((25[0-5]\|(2[0-4]\|1\d\|[1-9]\|)\d)\.?\b){4}$``` [Test](https://regex101.com/?regex=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%24) |

## <a name="storage"></a>10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                   | Pattern | Type   | Deprecated | Definition | Title/Description                                                    |
| ------------------------------------------ | ------- | ------ | ---------- | ---------- | -------------------------------------------------------------------- |
| - [readWriteMany](#storage_readWriteMany ) | No      | object | No         | -          | NFS based ReadWriteMany storage, requires \`mount.nfs\` on the hosts |

### <a name="storage_readWriteMany"></a>10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

**Description:** NFS based ReadWriteMany storage, requires `mount.nfs` on the hosts

| Property                                               | Pattern | Type    | Deprecated | Definition | Title/Description |
| ------------------------------------------------------ | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#storage_readWriteMany_enabled )           | No      | boolean | No         | -          | -                 |
| - [storageClass](#storage_readWriteMany_storageClass ) | No      | object  | No         | -          | -                 |
| - [persistence](#storage_readWriteMany_persistence )   | No      | object  | No         | -          | -                 |

#### <a name="storage_readWriteMany_enabled"></a>10.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="storage_readWriteMany_storageClass"></a>10.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > storageClass`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [name](#storage_readWriteMany_storageClass_name ) | No      | string | No         | -          | -                 |

##### <a name="storage_readWriteMany_storageClass_name"></a>10.1.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > storageClass > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="storage_readWriteMany_persistence"></a>10.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > persistence`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                           | Pattern | Type           | Deprecated | Definition                                               | Title/Description                                                                                                |
| ------------------------------------------------------------------ | ------- | -------------- | ---------- | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [size](#storage_readWriteMany_persistence_size )                 | No      | object         | No         | Same as [size](#monitoring_prometheus_persistence_size ) | -                                                                                                                |
| - [storageClass](#storage_readWriteMany_persistence_storageClass ) | No      | string or null | No         | Same as [storageClass](#global_storageClass )            | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |

##### <a name="storage_readWriteMany_persistence_size"></a>10.1.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > persistence > size`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |
| **Same definition as**    | [size](#monitoring_prometheus_persistence_size)                                                                                   |

##### <a name="storage_readWriteMany_persistence_storageClass"></a>10.1.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string or null`                     |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

## <a name="reflector"></a>11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > reflector`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                         | Pattern | Type        | Deprecated | Definition | Title/Description |
| -------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [enabled](#reflector_enabled ) | No      | Combination | No         | -          | -                 |

### <a name="reflector_enabled"></a>11.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > reflector > enabled`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                       |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

| One of(Option)                        |
| ------------------------------------- |
| [item 0](#reflector_enabled_oneOf_i0) |
| [item 1](#reflector_enabled_oneOf_i1) |

#### <a name="reflector_enabled_oneOf_i0"></a>11.1.1. Property `base cluster configuration > reflector > enabled > oneOf > item 0`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `"auto"`

#### <a name="reflector_enabled_oneOf_i1"></a>11.1.2. Property `base cluster configuration > reflector > enabled > oneOf > item 1`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

## <a name="rbac"></a>12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                      | Pattern | Type   | Deprecated | Definition | Title/Description                           |
| ----------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------- |
| - [roles](#rbac_roles )       | No      | object | No         | -          | A map of a ClusterRole name to it's rules   |
| - [accounts](#rbac_accounts ) | No      | object | No         | -          | A map of an account to it's (Cluster-)Roles |

### <a name="rbac_roles"></a>12.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > roles`

|                           |                                                                                                                                                                         |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#rbac_roles_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of a ClusterRole name to it's rules

| Property                                                    | Pattern | Type  | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------- | ------- | ----- | ---------- | ---------- | ----------------- |
| - [additionalProperties](#rbac_roles_additionalProperties ) | No      | array | No         | -          | -                 |

#### <a name="rbac_roles_additionalProperties"></a>12.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > roles > additionalProperties`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | N/A                |

### <a name="rbac_accounts"></a>12.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts`

|                           |                                                                                                                                                                            |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                   |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#rbac_accounts_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of an account to it's (Cluster-)Roles

| Property                                                       | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [additionalProperties](#rbac_accounts_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="rbac_accounts_additionalProperties"></a>12.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                            | Pattern | Type   | Deprecated | Definition | Title/Description                           |
| ------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------- |
| - [roles](#rbac_accounts_additionalProperties_roles )               | No      | object | No         | -          | A map of a role to it's intended namespaces |
| - [clusterRoles](#rbac_accounts_additionalProperties_clusterRoles ) | No      | array  | No         | -          | -                                           |

##### <a name="rbac_accounts_additionalProperties_roles"></a>12.2.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts > additionalProperties > roles`

|                           |                                                                                                                                                                                                       |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                                                              |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#rbac_accounts_additionalProperties_roles_additionalProperties "Each additional property must conform to the following schema") |

**Description:** A map of a role to it's intended namespaces

| Property                                                                                  | Pattern | Type  | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------------------- | ------- | ----- | ---------- | ---------- | ----------------- |
| - [additionalProperties](#rbac_accounts_additionalProperties_roles_additionalProperties ) | No      | array | No         | -          | -                 |

##### <a name="rbac_accounts_additionalProperties_roles_additionalProperties"></a>12.2.1.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts > additionalProperties > roles > additionalProperties`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | N/A                |

##### <a name="rbac_accounts_additionalProperties_clusterRoles"></a>12.2.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts > additionalProperties > clusterRoles`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | N/A                |

## <a name="common"></a>13. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > common`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

**Description:** Values for sub-chart

----------------------------------------------------------------------------------------------------------------------------

