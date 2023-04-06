# t8s-cluster

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

t8s-operator cluster with necessary addons

**Homepage:** <https://teuto.net>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| steutol | <sl@teuto.net> |  |

## Source Code

* <https://github.com/teutonet/teutonet-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.2.4 |

## Migration

When switching from cilium to calico, which is not recommended, the cilium CRDs are left behind

# t8s cluster configuration

**Title:** t8s cluster configuration

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                             | Pattern | Type             | Deprecated | Definition | Title/Description    |
| ---------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | -------------------- |
| - [global](#global )                                 | No      | object           | No         | -          | -                    |
| + [metadata](#metadata )                             | No      | object           | No         | -          | -                    |
| + [controlPlane](#controlPlane )                     | No      | object           | No         | -          | -                    |
| - [cloud](#cloud )                                   | No      | string           | No         | -          | -                    |
| + [version](#version )                               | No      | object           | No         | -          | -                    |
| + [workers](#workers )                               | No      | object           | No         | -          | -                    |
| - [bastion](#bastion )                               | No      | object           | No         | -          | -                    |
| - [containerRegistryProxy](#containerRegistryProxy ) | No      | object           | No         | -          | -                    |
| - [sshKeyName](#sshKeyName )                         | No      | string or null   | No         | -          | -                    |
| - [cni](#cni )                                       | No      | enum (of string) | No         | -          | -                    |
| - [common](#common )                                 | No      | object           | No         | -          | Values for sub-chart |

## <a name="global"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > global`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

## <a name="metadata"></a>2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > metadata`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                    | Pattern | Type             | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| + [serviceLevelAgreement](#metadata_serviceLevelAgreement ) | No      | enum (of string) | No         | -          | -                 |
| - [customerID](#metadata_customerID )                       | No      | integer          | No         | -          | -                 |
| - [customerName](#metadata_customerName )                   | No      | string           | No         | -          | -                 |
| - [supportProjectUrl](#metadata_supportProjectUrl )         | No      | string           | No         | -          | -                 |
| - [configGroupUrl](#metadata_configGroupUrl )               | No      | string           | No         | -          | -                 |
| - [gopassName](#metadata_gopassName )                       | No      | string           | No         | -          | -                 |
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

### <a name="metadata_supportProjectUrl"></a>2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > supportProjectUrl`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_configGroupUrl"></a>2.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > configGroupUrl`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_gopassName"></a>2.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > gopassName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_remarks"></a>2.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > remarks`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="controlPlane"></a>3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > controlPlane`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                              | Pattern | Type            | Deprecated | Definition                  | Title/Description |
| ----------------------------------------------------- | ------- | --------------- | ---------- | --------------------------- | ----------------- |
| + [flavor](#controlPlane_flavor )                     | No      | string          | No         | -                           | -                 |
| - [singleNode](#controlPlane_singleNode )             | No      | boolean         | No         | -                           | -                 |
| - [securityGroups](#controlPlane_securityGroups )     | No      | array of string | No         | In #/$defs/securityGroups   | -                 |
| - [nodeDrainTimeout](#controlPlane_nodeDrainTimeout ) | No      | string          | No         | In #/$defs/nodeDrainTimeout | -                 |

### <a name="controlPlane_flavor"></a>3.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > controlPlane > flavor`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="controlPlane_singleNode"></a>3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > singleNode`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="controlPlane_securityGroups"></a>3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > securityGroups`

|                |                        |
| -------------- | ---------------------- |
| **Type**       | `array of string`      |
| **Defined in** | #/$defs/securityGroups |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | True               |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                            | Description |
| ---------------------------------------------------------- | ----------- |
| [securityGroups items](#controlPlane_securityGroups_items) | -           |

#### <a name="autogenerated_heading_2"></a>3.3.1. t8s cluster configuration > controlPlane > securityGroups > securityGroups items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="controlPlane_nodeDrainTimeout"></a>3.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > nodeDrainTimeout`

|                |                          |
| -------------- | ------------------------ |
| **Type**       | `string`                 |
| **Default**    | `"3m"`                   |
| **Defined in** | #/$defs/nodeDrainTimeout |

| Restrictions                      |                                                                             |
| --------------------------------- | --------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+[smh]``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%5Bsmh%5D) |

## <a name="cloud"></a>4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > cloud`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="version"></a>5. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                   | Pattern | Type    | Deprecated | Definition | Title/Description |
| -------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [major](#version_major ) | No      | integer | No         | -          | -                 |
| + [minor](#version_minor ) | No      | integer | No         | -          | -                 |
| + [patch](#version_patch ) | No      | integer | No         | -          | -                 |

### <a name="version_major"></a>5.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > major`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

### <a name="version_minor"></a>5.2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > minor`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

### <a name="version_patch"></a>5.3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > patch`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

## <a name="workers"></a>6. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers`

|                           |                                                                                                                                                                      |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#workers_additionalProperties "Each additional property must conform to the following schema") |

| Property                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#workers_additionalProperties ) | No      | object | No         | -          | -                 |

### <a name="workers_additionalProperties"></a>6.1. Property `t8s cluster configuration > workers > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                              | Pattern | Type            | Deprecated | Definition                                                  | Title/Description |
| --------------------------------------------------------------------- | ------- | --------------- | ---------- | ----------------------------------------------------------- | ----------------- |
| + [replicas](#workers_additionalProperties_replicas )                 | No      | integer         | No         | -                                                           | -                 |
| + [availabilityZone](#workers_additionalProperties_availabilityZone ) | No      | string          | No         | -                                                           | -                 |
| + [flavor](#workers_additionalProperties_flavor )                     | No      | string          | No         | -                                                           | -                 |
| - [securityGroups](#workers_additionalProperties_securityGroups )     | No      | array of string | No         | Same as [securityGroups](#controlPlane_securityGroups )     | -                 |
| - [nodeDrainTimeout](#workers_additionalProperties_nodeDrainTimeout ) | No      | string          | No         | Same as [nodeDrainTimeout](#controlPlane_nodeDrainTimeout ) | -                 |

#### <a name="workers_additionalProperties_replicas"></a>6.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers > additionalProperties > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 0 |

#### <a name="workers_additionalProperties_availabilityZone"></a>6.1.2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers > additionalProperties > availabilityZone`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="workers_additionalProperties_flavor"></a>6.1.3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers > additionalProperties > flavor`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="workers_additionalProperties_securityGroups"></a>6.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > workers > additionalProperties > securityGroups`

|                        |                                                |
| ---------------------- | ---------------------------------------------- |
| **Type**               | `array of string`                              |
| **Same definition as** | [securityGroups](#controlPlane_securityGroups) |

#### <a name="workers_additionalProperties_nodeDrainTimeout"></a>6.1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > workers > additionalProperties > nodeDrainTimeout`

|                        |                                                    |
| ---------------------- | -------------------------------------------------- |
| **Type**               | `string`                                           |
| **Default**            | `"3m"`                                             |
| **Same definition as** | [nodeDrainTimeout](#controlPlane_nodeDrainTimeout) |

## <a name="bastion"></a>7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                         | Pattern | Type           | Deprecated | Definition | Title/Description |
| ------------------------------------------------ | ------- | -------------- | ---------- | ---------- | ----------------- |
| - [enabled](#bastion_enabled )                   | No      | boolean        | No         | -          | -                 |
| - [availabilityZone](#bastion_availabilityZone ) | No      | null or string | No         | -          | -                 |
| - [sshKeyName](#bastion_sshKeyName )             | No      | null or string | No         | -          | -                 |

### <a name="bastion_enabled"></a>7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="bastion_availabilityZone"></a>7.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion > availabilityZone`

|          |                  |
| -------- | ---------------- |
| **Type** | `null or string` |

### <a name="bastion_sshKeyName"></a>7.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > bastion > sshKeyName`

|          |                  |
| -------- | ---------------- |
| **Type** | `null or string` |

## <a name="containerRegistryProxy"></a>8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > containerRegistryProxy`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                                                  | Pattern | Type            | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [additionallyProxiedRegistries](#containerRegistryProxy_additionallyProxiedRegistries ) | No      | array of string | No         | -          | -                 |
| - [proxyRegistryEndpoint](#containerRegistryProxy_proxyRegistryEndpoint )                 | No      | string          | No         | -          | -                 |

### <a name="containerRegistryProxy_additionallyProxiedRegistries"></a>8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > containerRegistryProxy > additionallyProxiedRegistries`

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

| Each item of this array must be                                                                    | Description |
| -------------------------------------------------------------------------------------------------- | ----------- |
| [additionallyProxiedRegistries items](#containerRegistryProxy_additionallyProxiedRegistries_items) | -           |

#### <a name="autogenerated_heading_3"></a>8.1.1. t8s cluster configuration > containerRegistryProxy > additionallyProxiedRegistries > additionallyProxiedRegistries items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="containerRegistryProxy_proxyRegistryEndpoint"></a>8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > containerRegistryProxy > proxyRegistryEndpoint`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="sshKeyName"></a>9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > sshKeyName`

|          |                  |
| -------- | ---------------- |
| **Type** | `string or null` |

## <a name="cni"></a>10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > cni`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "cilium"
* "calico"

## <a name="common"></a>11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > common`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

**Description:** Values for sub-chart

----------------------------------------------------------------------------------------------------------------------------

