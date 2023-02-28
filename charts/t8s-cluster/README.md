# t8s-cluster

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

t8s-operator cluster with necessary addons

**Homepage:** <https://teuto.net>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |

## Source Code

* <https://github.com/teutonet/teutonet-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.2.3 |

## Migration

# t8s cluster configuration

**Title:** t8s cluster configuration

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                         | Pattern | Type   | Deprecated | Definition | Title/Description    |
| -------------------------------- | ------- | ------ | ---------- | ---------- | -------------------- |
| + [metadata](#metadata )         | No      | object | No         | -          | -                    |
| + [controlPlane](#controlPlane ) | No      | object | No         | -          | -                    |
| - [cloud](#cloud )               | No      | string | No         | -          | -                    |
| + [version](#version )           | No      | object | No         | -          | -                    |
| + [workers](#workers )           | No      | object | No         | -          | -                    |
| - [common](#common )             | No      | object | No         | -          | Values for sub-chart |

## <a name="metadata"></a>1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > metadata`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                    | Pattern | Type             | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| + [serviceLevelAgreement](#metadata_serviceLevelAgreement ) | No      | enum (of string) | No         | -          | -                 |
| - [customerID](#metadata_customerID )                       | No      | string           | No         | -          | -                 |
| - [customerName](#metadata_customerName )                   | No      | string           | No         | -          | -                 |
| - [supportProjectUrl](#metadata_supportProjectUrl )         | No      | string           | No         | -          | -                 |
| - [configGroupUrl](#metadata_configGroupUrl )               | No      | string           | No         | -          | -                 |
| - [gopassName](#metadata_gopassName )                       | No      | string           | No         | -          | -                 |
| - [remarks](#metadata_remarks )                             | No      | string           | No         | -          | -                 |

### <a name="metadata_serviceLevelAgreement"></a>1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > metadata > serviceLevelAgreement`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "None"
* "24x7"
* "Working-Hours"

### <a name="metadata_customerID"></a>1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > customerID`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_customerName"></a>1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > customerName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_supportProjectUrl"></a>1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > supportProjectUrl`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_configGroupUrl"></a>1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > configGroupUrl`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_gopassName"></a>1.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > gopassName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="metadata_remarks"></a>1.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > metadata > remarks`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="controlPlane"></a>2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > controlPlane`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                  | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [flavor](#controlPlane_flavor )         | No      | string  | No         | -          | -                 |
| - [singleNode](#controlPlane_singleNode ) | No      | boolean | No         | -          | -                 |

### <a name="controlPlane_flavor"></a>2.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > controlPlane > flavor`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="controlPlane_singleNode"></a>2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > controlPlane > singleNode`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

## <a name="cloud"></a>3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > cloud`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="version"></a>4. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                   | Pattern | Type    | Deprecated | Definition | Title/Description |
| -------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [major](#version_major ) | No      | integer | No         | -          | -                 |
| + [minor](#version_minor ) | No      | integer | No         | -          | -                 |
| + [patch](#version_patch ) | No      | integer | No         | -          | -                 |

### <a name="version_major"></a>4.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > major`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

### <a name="version_minor"></a>4.2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > minor`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

### <a name="version_patch"></a>4.3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > version > patch`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

## <a name="workers"></a>5. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers`

|                           |                                                                                                                                                                      |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#workers_additionalProperties "Each additional property must conform to the following schema") |

| Property                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#workers_additionalProperties ) | No      | object | No         | -          | -                 |

### <a name="workers_additionalProperties"></a>5.1. Property `t8s cluster configuration > workers > additionalProperties`

|                           |                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                 |
| **Additional properties** | [![Not allowed](https://img.shields.io/badge/Not%20allowed-red)](# "Additional Properties not allowed.") |

| Property                                                              | Pattern | Type    | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [replicas](#workers_additionalProperties_replicas )                 | No      | integer | No         | -          | -                 |
| + [availabilityZone](#workers_additionalProperties_availabilityZone ) | No      | string  | No         | -          | -                 |
| + [flavor](#workers_additionalProperties_flavor )                     | No      | string  | No         | -          | -                 |

#### <a name="workers_additionalProperties_replicas"></a>5.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers > additionalProperties > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 0 |

#### <a name="workers_additionalProperties_availabilityZone"></a>5.1.2. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers > additionalProperties > availabilityZone`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="workers_additionalProperties_flavor"></a>5.1.3. ![Required](https://img.shields.io/badge/Required-blue) Property `t8s cluster configuration > workers > additionalProperties > flavor`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="common"></a>6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `t8s cluster configuration > common`

|                           |                                                                                                                                   |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                          |
| **Additional properties** | [![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)](# "Additional Properties of any type are allowed.") |

**Description:** Values for sub-chart

----------------------------------------------------------------------------------------------------------------------------

