<!-- vim: set ft=markdown: --># teuto-cnpg

![Version: 2.1.0](https://img.shields.io/badge/Version-2.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart to abstract the managing of cnpg-databases from the original resource.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| tasches | <st@teuto.net> |  |

## Migration

### 1.x.x -> 2.0.0

Databases need to be migrated manually:

- stop cnpg-operator
- delete database objects
  - make sure that the cnpg-database objects really are deleted, as they have a finalizer set
- update helmchart
- start cnpg-operator

# cnpg-wrapper configuration

**Title:** cnpg-wrapper configuration

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                 | Pattern | Type             | Deprecated | Definition                                                                                                                                                                     | Title/Description                                                                                      |
| ---------------------------------------- | ------- | ---------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ |
| - [podMonitorLabels](#podMonitorLabels ) | No      | object           | No         | -                                                                                                                                                                              | The labels to set on ServiceMonitor which the prometheus uses to search for                            |
| - [instances](#instances )               | No      | integer          | No         | -                                                                                                                                                                              | -                                                                                                      |
| + [databases](#databases )               | No      | Combination      | No         | -                                                                                                                                                                              | -                                                                                                      |
| + [roles](#roles )                       | No      | Combination      | No         | -                                                                                                                                                                              | -                                                                                                      |
| - [logLevel](#logLevel )                 | No      | enum (of string) | No         | -                                                                                                                                                                              | -                                                                                                      |
| - [storageSize](#storageSize )           | No      | object           | No         | In https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/_definitions.json#/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity | -                                                                                                      |
| - [backup](#backup )                     | No      | object           | No         | -                                                                                                                                                                              | See: https://cloudnative-pg.io/documentation/1.16/backup_recovery/                                     |
| - [databaseImage](#databaseImage )       | No      | object           | No         | -                                                                                                                                                                              | For postgis see this link: https://github.com/cloudnative-pg/postgis-containers/pkgs/container/postgis |

## <a name="podMonitorLabels"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > podMonitorLabels`

|                           |                                                                                                               |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                      |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#podMonitorLabels_additionalProperties) |

**Description:** The labels to set on ServiceMonitor which the prometheus uses to search for

| Property                                      | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#podMonitorLabels_additionalProperties ) | No      | string | No         | -          | -                 |

### <a name="podMonitorLabels_additionalProperties"></a>1.1. Property `cnpg-wrapper configuration > podMonitorLabels > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="instances"></a>2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > instances`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

## <a name="databases"></a>3. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > databases`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                |
| ----------------------------- |
| [item 0](#databases_oneOf_i0) |
| [item 1](#databases_oneOf_i1) |

### <a name="databases_oneOf_i0"></a>3.1. Property `cnpg-wrapper configuration > databases > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** should only be used by flux

### <a name="databases_oneOf_i1"></a>3.2. Property `cnpg-wrapper configuration > databases > oneOf > item 1`

|                           |                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                        |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#databases_oneOf_i1_additionalProperties) |

**Description:** key is database name and value is owner

| Property                                        | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#databases_oneOf_i1_additionalProperties ) | No      | string | No         | -          | -                 |

#### <a name="databases_oneOf_i1_additionalProperties"></a>3.2.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="roles"></a>4. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > roles`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)            |
| ------------------------- |
| [item 0](#roles_oneOf_i0) |
| [item 1](#roles_oneOf_i1) |

### <a name="roles_oneOf_i0"></a>4.1. Property `cnpg-wrapper configuration > roles > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** should only be used by flux

### <a name="roles_oneOf_i1"></a>4.2. Property `cnpg-wrapper configuration > roles > oneOf > item 1`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | True               |
| **Tuple validation** | N/A                |

## <a name="logLevel"></a>5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > logLevel`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "error"
* "warning"
* "info"
* "debug"
* "trace"

## <a name="storageSize"></a>6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > storageSize`

|                           |                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                                                                 |
| **Defined in**            | https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/_definitions.json#/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity |

| One of(Option)                  |
| ------------------------------- |
| [item 0](#storageSize_oneOf_i0) |
| [item 1](#storageSize_oneOf_i1) |

### <a name="storageSize_oneOf_i0"></a>6.1. Property `cnpg-wrapper configuration > storageSize > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="storageSize_oneOf_i1"></a>6.2. Property `cnpg-wrapper configuration > storageSize > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `number` |

## <a name="backup"></a>7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > backup`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** See: https://cloudnative-pg.io/documentation/1.16/backup_recovery/

| Property                        | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [schedule](#backup_schedule ) | No      | string | No         | -          | cron syntax       |

### <a name="backup_schedule"></a>7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > backup > schedule`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** cron syntax

**Example:**

```yaml
0 0 0 * * *
```

## <a name="databaseImage"></a>8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** For postgis see this link: https://github.com/cloudnative-pg/postgis-containers/pkgs/container/postgis

| Property                                   | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                       |
| ------------------------------------------ | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------- |
| - [registry](#databaseImage_registry )     | No      | string | No         | -          | The host of the registry                                                                                |
| - [repository](#databaseImage_repository ) | No      | string | No         | -          | The image path in the registry                                                                          |
| - [tag](#databaseImage_tag )               | No      | string | No         | -          | For available tags see: https://github.com/cloudnative-pg/postgres-containers/pkgs/container/postgresql |
| - [digest](#databaseImage_digest )         | No      | string | No         | -          | -                                                                                                       |

### <a name="databaseImage_registry"></a>8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > registry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The host of the registry

**Example:**

```yaml
ghcr.io
```

### <a name="databaseImage_repository"></a>8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > repository`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The image path in the registry

**Example:**

```yaml
cloudnative-pg/postgresql
```

### <a name="databaseImage_tag"></a>8.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** For available tags see: https://github.com/cloudnative-pg/postgres-containers/pkgs/container/postgresql

**Examples:**

```yaml
15.6
```

```yaml
16.1
```

```yaml
17.2
```

### <a name="databaseImage_digest"></a>8.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > digest`

|          |          |
| -------- | -------- |
| **Type** | `string` |

----------------------------------------------------------------------------------------------------------------------------

