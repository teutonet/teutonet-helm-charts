<!-- vim: set ft=markdown: -->
# t8s-cluster

![Version: 9.1.0](https://img.shields.io/badge/Version-9.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

t8s-operator cluster with necessary addons

**Homepage:** <https://teuto.net>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| tasches | <st@teuto.net> |  |

## Source Code

* <https://github.com/teutonet/teutonet-helm-charts/tree/t8s-cluster-v9.1.0/charts/t8s-cluster>
* <https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/t8s-cluster>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/teutonet/teutonet-helm-charts | common | 1.4.0 |

## Initial installation

Take care to do the same steps as in [the first migration](#0xx---100)

## Migration

When switching from cilium to calico, which is not recommended, the cilium CRDs are left behind

### 0.x.x -> 1.x.x

The resources of the ccm and the csi are now managed via helm instead of
kustomize, which means that you have to either manually add the required labels to
everything or, which we would recommend, just uninstall the ccm, the csi and
delete the cloud-config secret, as these will just be recreated during installation.

### 5.x.x -> 7.x.x

Just skip version 6.x.x, as there was a mistake and it has been reverted.

### 7.x.x -> 8.x.x

Removed the unused `.metadata.gopassName` field.

# t8s cluster configuration

**Title:** t8s cluster configuration

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                         | Pattern | Type             | Deprecated | Definition                                                                  | Title/Description                                                                              |
| -------------------------------------------------------------------------------- | ------- | ---------------- | ---------- | --------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| - [global](#global )                                                             | No      | object           | No         | -                                                                           | -                                                                                              |
| + [metadata](#metadata )                                                         | No      | object           | No         | -                                                                           | -                                                                                              |
| + [controlPlane](#controlPlane )                                                 | No      | object           | No         | -                                                                           | -                                                                                              |
| - [cloud](#cloud )                                                               | No      | string           | No         | -                                                                           | -                                                                                              |
| + [version](#version )                                                           | No      | object           | No         | -                                                                           | -                                                                                              |
| + [nodePools](#nodePools )                                                       | No      | object           | No         | -                                                                           | -                                                                                              |
| - [additionalComputePlaneSecurityGroups](#additionalComputePlaneSecurityGroups ) | No      | array of string  | No         | Same as [additionalSecurityGroups](#controlPlane_additionalSecurityGroups ) | -                                                                                              |
| - [bastion](#bastion )                                                           | No      | object           | No         | -                                                                           | -                                                                                              |
| - [containerRegistryMirror](#containerRegistryMirror )                           | No      | object           | No         | -                                                                           | -                                                                                              |
| - [sshKeyName](#sshKeyName )                                                     | No      | string or null   | No         | -                                                                           | -                                                                                              |
| - [cni](#cni )                                                                   | No      | enum (of string) | No         | -                                                                           | The CNI plugin to use. \`auto\` means to keep the current one or use cilium for a new cluster. |
| - [openstackImageNamePrefix](#openstackImageNamePrefix )                         | No      | string           | No         | -                                                                           | -                                                                                              |
| - [common](#common )                                                             | No      | object           | No         | -                                                                           | Values for sub-chart                                                                           |

## <a name="global"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                                    | Pattern | Type   | Deprecated | Definition | Title/Description                                        |
| --------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | -------------------------------------------------------- |
| - [helmRepositories](#global_helmRepositories )                             | No      | object | No         | -          | A map of helmRepositories to create, the key is the name |
| - [kubectl](#global_kubectl )                                               | No      | object | No         | -          | Image with \`kubectl\` binary                            |
| - [etcd](#global_etcd )                                                     | No      | object | No         | -          | Image with \`etcdctl\` binary                            |
| - [injectedCertificateAuthorities](#global_injectedCertificateAuthorities ) | No      | string | No         | -          | -                                                        |
| - [kubeletExtraConfig](#global_kubeletExtraConfig )                         | No      | object | No         | -          | Additional kubelet configuration                         |

### <a name="global_helmRepositories"></a>1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > helmRepositories`

|                           |                                                                                                                      |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_helmRepositories_additionalProperties) |

**Description:** A map of helmRepositories to create, the key is the name

| Property                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_helmRepositories_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_helmRepositories_additionalProperties"></a>1.1.1. Property `t8s cluster configuration > global > helmRepositories > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                | Pattern | Type   | Deprecated | Definition           | Title/Description                                                                                            |
| ----------------------------------------------------------------------- | ------- | ------ | ---------- | -------------------- | ------------------------------------------------------------------------------------------------------------ |
| - [url](#global_helmRepositories_additionalProperties_url )             | No      | string | No         | -                    | -                                                                                                            |
| - [charts](#global_helmRepositories_additionalProperties_charts )       | No      | object | No         | -                    | Which charts are deployed in which version using this repo, used internally                                  |
| - [condition](#global_helmRepositories_additionalProperties_condition ) | No      | string | No         | In #/$defs/condition | A condition with which to decide to include the resource. This will be templated. Must return a truthy value |

##### <a name="global_helmRepositories_additionalProperties_url"></a>1.1.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > helmRepositories > additionalProperties > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                         |
| --------------------------------- | ----------------------------------------------------------------------- |
| **Must match regular expression** | ```https://.+``` [Test](https://regex101.com/?regex=https%3A%2F%2F.%2B) |

##### <a name="global_helmRepositories_additionalProperties_charts"></a>1.1.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > helmRepositories > additionalProperties > charts`

|                           |                                                                                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                                         |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_helmRepositories_additionalProperties_charts_additionalProperties) |

**Description:** Which charts are deployed in which version using this repo, used internally

| Property                                                                         | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_helmRepositories_additionalProperties_charts_additionalProperties ) | No      | string | No         | -          | -                 |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties"></a>1.1.1.2.1. Property `t8s cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_helmRepositories_additionalProperties_condition"></a>1.1.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > helmRepositories > additionalProperties > condition`

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

### <a name="global_kubectl"></a>1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubectl`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Image with `kubectl` binary

| Property                          | Pattern | Type   | Deprecated | Definition       | Title/Description |
| --------------------------------- | ------- | ------ | ---------- | ---------------- | ----------------- |
| - [image](#global_kubectl_image ) | No      | object | No         | In #/$defs/image | -                 |

#### <a name="global_kubectl_image"></a>1.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubectl > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Defined in**            | #/$defs/image                                                  |

| Property                                          | Pattern | Type   | Deprecated | Definition | Title/Description              |
| ------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------ |
| - [registry](#global_kubectl_image_registry )     | No      | string | No         | -          | The host of the registry       |
| - [repository](#global_kubectl_image_repository ) | No      | string | No         | -          | The image path in the registry |
| - [tag](#global_kubectl_image_tag )               | No      | string | No         | -          | -                              |
| - [digest](#global_kubectl_image_digest )         | No      | string | No         | -          | -                              |

##### <a name="global_kubectl_image_registry"></a>1.2.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubectl > image > registry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The host of the registry

**Example:**

```yaml
docker.io
```

##### <a name="global_kubectl_image_repository"></a>1.2.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubectl > image > repository`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The image path in the registry

**Example:**

```yaml
bitnami/kubectl
```

##### <a name="global_kubectl_image_tag"></a>1.2.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubectl > image > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_kubectl_image_digest"></a>1.2.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubectl > image > digest`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_etcd"></a>1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > etcd`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Image with `etcdctl` binary

| Property                       | Pattern | Type   | Deprecated | Definition                              | Title/Description |
| ------------------------------ | ------- | ------ | ---------- | --------------------------------------- | ----------------- |
| - [image](#global_etcd_image ) | No      | object | No         | Same as [image](#global_kubectl_image ) | -                 |

#### <a name="global_etcd_image"></a>1.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > etcd > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Same definition as**    | [image](#global_kubectl_image)                                 |

### <a name="global_injectedCertificateAuthorities"></a>1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > injectedCertificateAuthorities`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_kubeletExtraConfig"></a>1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubeletExtraConfig`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Additional kubelet configuration

| Property                                                                     | Pattern | Type    | Deprecated | Definition | Title/Description                                                                    |
| ---------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ------------------------------------------------------------------------------------ |
| - [maxParallelImagePulls](#global_kubeletExtraConfig_maxParallelImagePulls ) | No      | integer | No         | -          | Only valid for k8s version 1.27 and later. The number of images to pull in parallel. |

#### <a name="global_kubeletExtraConfig_maxParallelImagePulls"></a>1.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global > kubeletExtraConfig > maxParallelImagePulls`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

**Description:** Only valid for k8s version 1.27 and later. The number of images to pull in parallel.

## <a name="metadata"></a>2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > metadata`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                    | Pattern | Type             | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| + [serviceLevelAgreement](#metadata_serviceLevelAgreement ) | No      | enum (of string) | No         | -          | -                 |
| - [customerID](#metadata_customerID )                       | No      | integer          | No         | -          | -                 |
| - [customerName](#metadata_customerName )                   | No      | string           | No         | -          | -                 |
| - [friendlyName](#metadata_friendlyName )                   | No      | string           | No         | -          | -                 |
| - [supportProjectUrl](#metadata_supportProjectUrl )         | No      | string           | No         | -          | -                 |
| - [configGroupUrl](#metadata_configGroupUrl )               | No      | string           | No         | -          | -                 |
| - [remarks](#metadata_remarks )                             | No      | string           | No         | -          | -                 |

### <a name="metadata_serviceLevelAgreement"></a>2.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > metadata > serviceLevelAgreement`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "None"
* "24x7"
* "WorkingHours"

### <a name="metadata_customerID"></a>2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > customerID`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

### <a name="metadata_customerName"></a>2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > customerName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_friendlyName"></a>2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > friendlyName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_supportProjectUrl"></a>2.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > supportProjectUrl`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_configGroupUrl"></a>2.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > configGroupUrl`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_remarks"></a>2.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > remarks`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="controlPlane"></a>3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > controlPlane`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                              | Pattern | Type            | Deprecated | Definition                | Title/Description                                             |
| --------------------------------------------------------------------- | ------- | --------------- | ---------- | ------------------------- | ------------------------------------------------------------- |
| - [hosted](#controlPlane_hosted )                                     | No      | boolean         | No         | -                         | Whether the control plane is hosted on the management cluster |
| + [flavor](#controlPlane_flavor )                                     | No      | string          | No         | -                         | -                                                             |
| - [singleNode](#controlPlane_singleNode )                             | No      | boolean         | No         | -                         | -                                                             |
| - [additionalSecurityGroups](#controlPlane_additionalSecurityGroups ) | No      | array of string | No         | In #/$defs/securityGroups | -                                                             |
| - [allowedCIDRs](#controlPlane_allowedCIDRs )                         | No      | array of string | No         | -                         | -                                                             |

### <a name="controlPlane_hosted"></a>3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > hosted`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

**Description:** Whether the control plane is hosted on the management cluster

### <a name="controlPlane_flavor"></a>3.2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > controlPlane > flavor`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="controlPlane_singleNode"></a>3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > singleNode`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="controlPlane_additionalSecurityGroups"></a>3.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > additionalSecurityGroups`

|                |                        |
| -------------- | ---------------------- |
| **Type**       | `array of string`      |
| **Defined in** | #/$defs/securityGroups |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | True               |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                | Description |
| ------------------------------------------------------------------------------ | ----------- |
| [additionalSecurityGroups items](#controlPlane_additionalSecurityGroups_items) | -           |

#### <a name="controlPlane_additionalSecurityGroups_items"></a>3.4.1. t8s cluster configuration > controlPlane > additionalSecurityGroups > additionalSecurityGroups items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="controlPlane_allowedCIDRs"></a>3.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > allowedCIDRs`

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

| Each item of this array must be                        | Description |
| ------------------------------------------------------ | ----------- |
| [allowedCIDRs items](#controlPlane_allowedCIDRs_items) | -           |

#### <a name="controlPlane_allowedCIDRs_items"></a>3.5.1. t8s cluster configuration > controlPlane > allowedCIDRs > allowedCIDRs items

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                                                                                                                                                                                                                                                                                                                   |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```^((25[0-5]\|2[0-4]\d\|1\d\d\|[1-9]?\d)\.){3}(25[0-5]\|2[0-4]\d\|1\d\d\|[1-9]?\d)(/([0-9]\|[1-2][0-9]\|3[0-2]))?$``` [Test](https://regex101.com/?regex=%5E%28%2825%5B0-5%5D%7C2%5B0-4%5D%5Cd%7C1%5Cd%5Cd%7C%5B1-9%5D%3F%5Cd%29%5C.%29%7B3%7D%2825%5B0-5%5D%7C2%5B0-4%5D%5Cd%7C1%5Cd%5Cd%7C%5B1-9%5D%3F%5Cd%29%28%2F%28%5B0-9%5D%7C%5B1-2%5D%5B0-9%5D%7C3%5B0-2%5D%29%29%3F%24) |

## <a name="cloud"></a>4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > cloud`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="version"></a>5. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                   | Pattern | Type    | Deprecated | Definition | Title/Description                     |
| -------------------------- | ------- | ------- | ---------- | ---------- | ------------------------------------- |
| + [major](#version_major ) | No      | const   | No         | -          | -                                     |
| + [minor](#version_minor ) | No      | integer | No         | -          | The minor version of the k8s cluster. |
| + [patch](#version_patch ) | No      | integer | No         | -          | -                                     |

### <a name="version_major"></a>5.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > major`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `1`

### <a name="version_minor"></a>5.2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > minor`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

**Description:** The minor version of the k8s cluster.

| Restrictions |         |
| ------------ | ------- |
| **Minimum**  | &ge; 25 |

### <a name="version_patch"></a>5.3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > patch`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

## <a name="nodePools"></a>6. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > nodePools`

|                           |                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                               |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#nodePools_additionalProperties) |

| Property                               | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#nodePools_additionalProperties ) | No      | object | No         | -          | -                 |

### <a name="nodePools_additionalProperties"></a>6.1. Property `t8s cluster configuration > nodePools > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [replicas](#nodePools_additionalProperties_replicas )                 | No      | integer | No         | -          | -                 |
| - [availabilityZone](#nodePools_additionalProperties_availabilityZone ) | No      | string  | No         | -          | -                 |
| + [flavor](#nodePools_additionalProperties_flavor )                     | No      | string  | No         | -          | -                 |

#### <a name="nodePools_additionalProperties_replicas"></a>6.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > nodePools > additionalProperties > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 0 |

#### <a name="nodePools_additionalProperties_availabilityZone"></a>6.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > nodePools > additionalProperties > availabilityZone`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="nodePools_additionalProperties_flavor"></a>6.1.3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > nodePools > additionalProperties > flavor`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="additionalComputePlaneSecurityGroups"></a>7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > additionalComputePlaneSecurityGroups`

|                        |                                                                    |
| ---------------------- | ------------------------------------------------------------------ |
| **Type**               | `array of string`                                                  |
| **Same definition as** | [additionalSecurityGroups](#controlPlane_additionalSecurityGroups) |

## <a name="bastion"></a>8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                         | Pattern | Type           | Deprecated | Definition | Title/Description |
| ------------------------------------------------ | ------- | -------------- | ---------- | ---------- | ----------------- |
| - [enabled](#bastion_enabled )                   | No      | boolean        | No         | -          | -                 |
| - [availabilityZone](#bastion_availabilityZone ) | No      | null or string | No         | -          | -                 |
| - [sshKeyName](#bastion_sshKeyName )             | No      | null or string | No         | -          | -                 |

### <a name="bastion_enabled"></a>8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="bastion_availabilityZone"></a>8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion > availabilityZone`

|          |                  |
| -------- | ---------------- |
| **Type** | `null or string` |

### <a name="bastion_sshKeyName"></a>8.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion > sshKeyName`

|          |                  |
| -------- | ---------------- |
| **Type** | `null or string` |

## <a name="containerRegistryMirror"></a>9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > containerRegistryMirror`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                     | Pattern | Type            | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [additionallyMirroredRegistries](#containerRegistryMirror_additionallyMirroredRegistries ) | No      | array of string | No         | -          | -                 |
| - [mirrorEndpoint](#containerRegistryMirror_mirrorEndpoint )                                 | No      | string          | No         | -          | -                 |

### <a name="containerRegistryMirror_additionallyMirroredRegistries"></a>9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > containerRegistryMirror > additionallyMirroredRegistries`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                                       | Description |
| ----------------------------------------------------------------------------------------------------- | ----------- |
| [additionallyMirroredRegistries items](#containerRegistryMirror_additionallyMirroredRegistries_items) | -           |

#### <a name="containerRegistryMirror_additionallyMirroredRegistries_items"></a>9.1.1. t8s cluster configuration > containerRegistryMirror > additionallyMirroredRegistries > additionallyMirroredRegistries items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="containerRegistryMirror_mirrorEndpoint"></a>9.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > containerRegistryMirror > mirrorEndpoint`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="sshKeyName"></a>10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > sshKeyName`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

## <a name="cni"></a>11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > cni`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

**Description:** The CNI plugin to use. `auto` means to keep the current one or use cilium for a new cluster.

Must be one of:
* "cilium"
* "auto"
* "calico"

## <a name="openstackImageNamePrefix"></a>12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > openstackImageNamePrefix`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="common"></a>13. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > common`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** Values for sub-chart

----------------------------------------------------------------------------------------------------------------------------

