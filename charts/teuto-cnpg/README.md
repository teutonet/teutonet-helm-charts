<!-- vim: set ft=markdown: --># teuto-cnpg

![Version: 3.1.0](https://img.shields.io/badge/Version-3.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

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

### 2.x.x -> 3.x.x

Cloudnative-PG made the in-operator backup deprecated.

Therefore a migration has to happen where the Backup block is moved
into the Objectstore.

In the values you need to remove .values.backup.barmanObjectStore block.
Those values now need to be set under .values.backup.s3 like this:

```
values:
  backup:
    s3:
      endpointURL: https://api.ffm3.teutostack.de:6780
      path: s3://backup/
      secret:
        name: backup-credentials
```

accessKeyId and accessSecretKey are set to `ACCESS_KEY_ID` and `accessSecretKeyEY` by default
but can be overwritten with .values.backup.s3.accessKeyId or .values.backup.s3.accessSecretKey.

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
| - [globalExtensions](#globalExtensions ) | No      | object           | No         | -                                                                                                                                                                              | map of PostgreSQL extensions for this database                                                         |
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

## <a name="globalExtensions"></a>3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > globalExtensions`

|                           |                                                                                                               |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                      |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#globalExtensions_additionalProperties) |

**Description:** map of PostgreSQL extensions for this database

| Property                                      | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#globalExtensions_additionalProperties ) | No      | object | No         | -          | -                 |

### <a name="globalExtensions_additionalProperties"></a>3.1. Property `cnpg-wrapper configuration > globalExtensions > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                     | Pattern | Type   | Deprecated | Definition | Title/Description                    |
| ------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ------------------------------------ |
| - [version](#globalExtensions_additionalProperties_version ) | No      | string | No         | -          | optional extension version           |
| - [schema](#globalExtensions_additionalProperties_schema )   | No      | string | No         | -          | name of the schema for the extension |

#### <a name="globalExtensions_additionalProperties_version"></a>3.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > globalExtensions > additionalProperties > version`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** optional extension version

#### <a name="globalExtensions_additionalProperties_schema"></a>3.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > globalExtensions > additionalProperties > schema`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** name of the schema for the extension

## <a name="databases"></a>4. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > databases`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                |
| ----------------------------- |
| [item 0](#databases_oneOf_i0) |
| [item 1](#databases_oneOf_i1) |

### <a name="databases_oneOf_i0"></a>4.1. Property `cnpg-wrapper configuration > databases > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** YAML string representation (used by Flux)

### <a name="databases_oneOf_i1"></a>4.2. Property `cnpg-wrapper configuration > databases > oneOf > item 1`

|                           |                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                        |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#databases_oneOf_i1_additionalProperties) |

**Description:** key is database name; value can be an owner string or an object with owner and extensions

| Property                                        | Pattern | Type        | Deprecated | Definition | Title/Description |
| ----------------------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [](#databases_oneOf_i1_additionalProperties ) | No      | Combination | No         | -          | -                 |

#### <a name="databases_oneOf_i1_additionalProperties"></a>4.2.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                                              |
| ----------------------------------------------------------- |
| [item 0](#databases_oneOf_i1_additionalProperties_oneOf_i0) |
| [item 1](#databases_oneOf_i1_additionalProperties_oneOf_i1) |

##### <a name="databases_oneOf_i1_additionalProperties_oneOf_i0"></a>4.2.1.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** database owner (simple form)

##### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1"></a>4.2.1.2. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                      | Pattern | Type   | Deprecated | Definition | Title/Description                              |
| ----------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ---------------------------------------------- |
| + [owner](#databases_oneOf_i1_additionalProperties_oneOf_i1_owner )           | No      | string | No         | -          | database owner name                            |
| - [extensions](#databases_oneOf_i1_additionalProperties_oneOf_i1_extensions ) | No      | object | No         | -          | map of PostgreSQL extensions for this database |
| - [schemas](#databases_oneOf_i1_additionalProperties_oneOf_i1_schemas )       | No      | object | No         | -          | schemas to be created for the database         |

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_owner"></a>4.2.1.2.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > owner`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** database owner name

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_extensions"></a>4.2.1.2.2. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > extensions`

|                           |                                                                                                                                                          |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                 |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#databases_oneOf_i1_additionalProperties_oneOf_i1_extensions_additionalProperties) |

**Description:** map of PostgreSQL extensions for this database

| Property                                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#databases_oneOf_i1_additionalProperties_oneOf_i1_extensions_additionalProperties ) | No      | object | No         | -          | -                 |

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_extensions_additionalProperties"></a>4.2.1.2.2.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > extensions > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                                | Pattern | Type   | Deprecated | Definition | Title/Description                    |
| ------------------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------ |
| - [version](#databases_oneOf_i1_additionalProperties_oneOf_i1_extensions_additionalProperties_version ) | No      | string | No         | -          | optional extension version           |
| - [schema](#databases_oneOf_i1_additionalProperties_oneOf_i1_extensions_additionalProperties_schema )   | No      | string | No         | -          | name of the schema for the extension |

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_extensions_additionalProperties_version"></a>4.2.1.2.2.1.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > extensions > additionalProperties > version`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** optional extension version

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_extensions_additionalProperties_schema"></a>4.2.1.2.2.1.2. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > extensions > additionalProperties > schema`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** name of the schema for the extension

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_schemas"></a>4.2.1.2.3. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > schemas`

|                           |                                                                                                                                                       |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                              |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#databases_oneOf_i1_additionalProperties_oneOf_i1_schemas_additionalProperties) |

**Description:** schemas to be created for the database

| Property                                                                              | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#databases_oneOf_i1_additionalProperties_oneOf_i1_schemas_additionalProperties ) | No      | object | No         | -          | -                 |

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_schemas_additionalProperties"></a>4.2.1.2.3.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > schemas > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                         | Pattern | Type   | Deprecated | Definition | Title/Description   |
| ------------------------------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ------------------- |
| - [owner](#databases_oneOf_i1_additionalProperties_oneOf_i1_schemas_additionalProperties_owner ) | No      | string | No         | -          | owner of the schema |

###### <a name="databases_oneOf_i1_additionalProperties_oneOf_i1_schemas_additionalProperties_owner"></a>4.2.1.2.3.1.1. Property `cnpg-wrapper configuration > databases > oneOf > item 1 > additionalProperties > oneOf > item 1 > schemas > additionalProperties > owner`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** owner of the schema

## <a name="roles"></a>5. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > roles`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)            |
| ------------------------- |
| [item 0](#roles_oneOf_i0) |
| [item 1](#roles_oneOf_i1) |

### <a name="roles_oneOf_i0"></a>5.1. Property `cnpg-wrapper configuration > roles > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** should only be used by flux

### <a name="roles_oneOf_i1"></a>5.2. Property `cnpg-wrapper configuration > roles > oneOf > item 1`

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

## <a name="logLevel"></a>6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > logLevel`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "error"
* "warning"
* "info"
* "debug"
* "trace"

## <a name="storageSize"></a>7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > storageSize`

|                           |                                                                                                                                                                             |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                                                                 |
| **Defined in**            | https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/_definitions.json#/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity |

| One of(Option)                  |
| ------------------------------- |
| [item 0](#storageSize_oneOf_i0) |
| [item 1](#storageSize_oneOf_i1) |

### <a name="storageSize_oneOf_i0"></a>7.1. Property `cnpg-wrapper configuration > storageSize > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="storageSize_oneOf_i1"></a>7.2. Property `cnpg-wrapper configuration > storageSize > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `number` |

## <a name="backup"></a>8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > backup`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** See: https://cloudnative-pg.io/documentation/1.16/backup_recovery/

| Property                        | Pattern | Type   | Deprecated | Definition | Title/Description  |
| ------------------------------- | ------- | ------ | ---------- | ---------- | ------------------ |
| - [schedule](#backup_schedule ) | No      | string | No         | -          | cron syntax        |
| + [s3](#backup_s3 )             | No      | object | No         | -          | s3 related options |

### <a name="backup_schedule"></a>8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > backup > schedule`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** cron syntax

**Example:**

```yaml
0 0 0 * * *
```

### <a name="backup_s3"></a>8.2. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > backup > s3`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** s3 related options

| Property                                 | Pattern | Type   | Deprecated | Definition | Title/Description         |
| ---------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------- |
| + [path](#backup_s3_path )               | No      | string | No         | -          | s3 path to write files to |
| + [endpointURL](#backup_s3_endpointURL ) | No      | string | No         | -          | url of the api endpoint   |
| - [secret](#backup_s3_secret )           | No      | object | No         | -          | -                         |

#### <a name="backup_s3_path"></a>8.2.1. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > backup > s3 > path`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** s3 path to write files to

#### <a name="backup_s3_endpointURL"></a>8.2.2. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > backup > s3 > endpointURL`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** url of the api endpoint

#### <a name="backup_s3_secret"></a>8.2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > backup > s3 > secret`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [name](#backup_s3_secret_name )                       | No      | string | No         | -          | -                 |
| - [accessKeyId](#backup_s3_secret_accessKeyId )         | No      | string | No         | -          | -                 |
| - [accessSecretKey](#backup_s3_secret_accessSecretKey ) | No      | string | No         | -          | -                 |

##### <a name="backup_s3_secret_name"></a>8.2.3.1. ![Required](https://img.shields.io/badge/Required-blue) Property `cnpg-wrapper configuration > backup > s3 > secret > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="backup_s3_secret_accessKeyId"></a>8.2.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > backup > s3 > secret > accessKeyId`

|             |                   |
| ----------- | ----------------- |
| **Type**    | `string`          |
| **Default** | `"ACCESS_KEY_ID"` |

##### <a name="backup_s3_secret_accessSecretKey"></a>8.2.3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > backup > s3 > secret > accessSecretKey`

|             |                       |
| ----------- | --------------------- |
| **Type**    | `string`              |
| **Default** | `"ACCESS_SECRET_KEY"` |

## <a name="databaseImage"></a>9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage`

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

### <a name="databaseImage_registry"></a>9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > registry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The host of the registry

**Example:**

```yaml
ghcr.io
```

### <a name="databaseImage_repository"></a>9.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > repository`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The image path in the registry

**Example:**

```yaml
cloudnative-pg/postgresql
```

### <a name="databaseImage_tag"></a>9.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > tag`

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

### <a name="databaseImage_digest"></a>9.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `cnpg-wrapper configuration > databaseImage > digest`

|          |          |
| -------- | -------- |
| **Type** | `string` |

----------------------------------------------------------------------------------------------------------------------------

