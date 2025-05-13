[modeline]: # ( vim: set ft=markdown: )
# ckan

![Version: 1.2.8](https://img.shields.io/badge/Version-1.2.8-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.11.0](https://img.shields.io/badge/AppVersion-2.11.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| syeklu | <sk@teuto.net> |  |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| tasches | <st@teuto.net> |  |

# ckan configuration

**Title:** ckan configuration

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                       | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [global](#global )           | No      | object | No         | -          | -                 |
| - [ckan](#ckan )               | No      | object | No         | -          | -                 |
| - [datapuscher](#datapuscher ) | No      | object | No         | -          | -                 |
| - [postgresql](#postgresql )   | No      | object | No         | -          | -                 |
| - [redis](#redis )             | No      | object | No         | -          | -                 |
| - [solr](#solr )               | No      | object | No         | -          | -                 |

## <a name="global"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > global`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                        | Pattern | Type            | Deprecated | Definition              | Title/Description                                                                                                                                                |
| ----------------------------------------------- | ------- | --------------- | ---------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [imageRegistry](#global_imageRegistry )       | No      | string          | No         | -                       | The global container image proxy, e.g. [Nexus](https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager), this needs to support various registries |
| - [imagePullSecrets](#global_imagePullSecrets ) | No      | array of object | No         | -                       | -                                                                                                                                                                |
| - [storageClass](#global_storageClass )         | No      | string          | No         | In #/$defs/storageClass | The storageClass to use for persistence, otherwise use the cluster default (e.g. teutostack-ssd)                                                                 |

### <a name="global_imageRegistry"></a>1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > global > imageRegistry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The global container image proxy, e.g. [Nexus](https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager), this needs to support various registries

**Example:**

```yaml
nexus.teuto.net
```

### <a name="global_imagePullSecrets"></a>1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > global > imagePullSecrets`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of object` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                          | Description |
| -------------------------------------------------------- | ----------- |
| [imagePullSecrets items](#global_imagePullSecrets_items) | -           |

#### <a name="global_imagePullSecrets_items"></a>1.2.1. ckan configuration > global > imagePullSecrets > imagePullSecrets items

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                       | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [name](#global_imagePullSecrets_items_name ) | No      | string | No         | -          | -                 |

##### <a name="global_imagePullSecrets_items_name"></a>1.2.1.1. Property `ckan configuration > global > imagePullSecrets > imagePullSecrets items > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_storageClass"></a>1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > global > storageClass`

|                |                      |
| -------------- | -------------------- |
| **Type**       | `string`             |
| **Defined in** | #/$defs/storageClass |

**Description:** The storageClass to use for persistence, otherwise use the cluster default (e.g. teutostack-ssd)

## <a name="ckan"></a>2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                          | Pattern | Type            | Deprecated | Definition       | Title/Description                                                                                                                                                                                                                |
| ------------------------------------------------- | ------- | --------------- | ---------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [postInstall](#ckan_postInstall )               | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [locales](#ckan_locales )                       | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [extraEnvVars](#ckan_extraEnvVars )             | No      | array or string | No         | -                | Array with extra environment variables to add to CKAN                                                                                                                                                                            |
| - [extraVolumeMounts](#ckan_extraVolumeMounts )   | No      | array or string | No         | -                | Array with extra volume mounts variables to add to CKAN                                                                                                                                                                          |
| - [extraVolumes](#ckan_extraVolumes )             | No      | array or string | No         | -                | Array with extra volumes variables to add to CKAN                                                                                                                                                                                |
| - [siteId](#ckan_siteId )                         | No      | string          | No         | -                | The search index is linked to the value of the ckan.site_id, so if you have more than one CKAN instance using the same solr_url, they will each have a separate search index as long as their ckan.site_id values are different. |
| - [siteTitle](#ckan_siteTitle )                   | No      | string          | No         | -                | This sets the name of the site, as displayed in the CKAN web interface.                                                                                                                                                          |
| - [plugins](#ckan_plugins )                       | No      | array           | No         | -                | The enabled plugins in the Ckan instance.                                                                                                                                                                                        |
| - [defaultViews](#ckan_defaultViews )             | No      | array           | No         | -                | The enabled plugins in the Ckan instance.                                                                                                                                                                                        |
| - [datapusher](#ckan_datapusher )                 | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [image](#ckan_image )                           | No      | object          | No         | In #/$defs/image | -                                                                                                                                                                                                                                |
| - [ingress](#ckan_ingress )                       | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [persistence](#ckan_persistence )               | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [sysadmin](#ckan_sysadmin )                     | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [smtp](#ckan_smtp )                             | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [podSecurityContext](#ckan_podSecurityContext ) | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [securityContext](#ckan_securityContext )       | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [resources](#ckan_resources )                   | No      | object          | No         | -                | -                                                                                                                                                                                                                                |
| - [readiness\|liveness](#ckan_pattern1 )          | Yes     | object          | No         | -                | -                                                                                                                                                                                                                                |

### <a name="ckan_postInstall"></a>2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > postInstall`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                          | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [postgresInit](#ckan_postInstall_postgresInit ) | No      | object | No         | -          | -                 |

#### <a name="ckan_postInstall_postgresInit"></a>2.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > postInstall > postgresInit`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                       | Pattern | Type            | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [enabled](#ckan_postInstall_postgresInit_enabled )           | No      | boolean         | No         | -          | -                 |
| - [extraEnvVars](#ckan_postInstall_postgresInit_extraEnvVars ) | No      | array or string | No         | -          | -                 |

##### <a name="ckan_postInstall_postgresInit_enabled"></a>2.1.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > postInstall > postgresInit > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="ckan_postInstall_postgresInit_extraEnvVars"></a>2.1.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > postInstall > postgresInit > extraEnvVars`

|             |                   |
| ----------- | ----------------- |
| **Type**    | `array or string` |
| **Default** | `[]`              |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                         | Description |
| ----------------------------------------------------------------------- | ----------- |
| [extraEnvVars items](#ckan_postInstall_postgresInit_extraEnvVars_items) | -           |

###### <a name="ckan_postInstall_postgresInit_extraEnvVars_items"></a>2.1.1.2.1. ckan configuration > ckan > postInstall > postgresInit > extraEnvVars > extraEnvVars items

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_locales"></a>2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > locales`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [default](#ckan_locales_default ) | No      | string | No         | -          | -                 |
| - [offered](#ckan_locales_offered ) | No      | string | No         | -          | -                 |

#### <a name="ckan_locales_default"></a>2.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > locales > default`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_locales_offered"></a>2.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > locales > offered`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="ckan_extraEnvVars"></a>2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > extraEnvVars`

|             |                   |
| ----------- | ----------------- |
| **Type**    | `array or string` |
| **Default** | `[]`              |

**Description:** Array with extra environment variables to add to CKAN

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                | Description |
| ---------------------------------------------- | ----------- |
| [extraEnvVars items](#ckan_extraEnvVars_items) | -           |

#### <a name="ckan_extraEnvVars_items"></a>2.3.1. ckan configuration > ckan > extraEnvVars > extraEnvVars items

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_extraVolumeMounts"></a>2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > extraVolumeMounts`

|             |                   |
| ----------- | ----------------- |
| **Type**    | `array or string` |
| **Default** | `[]`              |

**Description:** Array with extra volume mounts variables to add to CKAN

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                          | Description |
| -------------------------------------------------------- | ----------- |
| [extraVolumeMounts items](#ckan_extraVolumeMounts_items) | -           |

#### <a name="ckan_extraVolumeMounts_items"></a>2.4.1. ckan configuration > ckan > extraVolumeMounts > extraVolumeMounts items

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_extraVolumes"></a>2.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > extraVolumes`

|             |                   |
| ----------- | ----------------- |
| **Type**    | `array or string` |
| **Default** | `[]`              |

**Description:** Array with extra volumes variables to add to CKAN

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                | Description |
| ---------------------------------------------- | ----------- |
| [extraVolumes items](#ckan_extraVolumes_items) | -           |

#### <a name="ckan_extraVolumes_items"></a>2.5.1. ckan configuration > ckan > extraVolumes > extraVolumes items

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_siteId"></a>2.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > siteId`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The search index is linked to the value of the ckan.site_id, so if you have more than one CKAN instance using the same solr_url, they will each have a separate search index as long as their ckan.site_id values are different.

### <a name="ckan_siteTitle"></a>2.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > siteTitle`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** This sets the name of the site, as displayed in the CKAN web interface.

### <a name="ckan_plugins"></a>2.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > plugins`

|          |         |
| -------- | ------- |
| **Type** | `array` |

**Description:** The enabled plugins in the Ckan instance.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be      | Description |
| ------------------------------------ | ----------- |
| [plugins items](#ckan_plugins_items) | -           |

#### <a name="ckan_plugins_items"></a>2.8.1. ckan configuration > ckan > plugins > plugins items

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_defaultViews"></a>2.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > defaultViews`

|          |         |
| -------- | ------- |
| **Type** | `array` |

**Description:** The enabled plugins in the Ckan instance.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                | Description |
| ---------------------------------------------- | ----------- |
| [defaultViews items](#ckan_defaultViews_items) | -           |

#### <a name="ckan_defaultViews_items"></a>2.9.1. ckan configuration > ckan > defaultViews > defaultViews items

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_datapusher"></a>2.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > datapusher`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                               | Pattern | Type  | Deprecated | Definition | Title/Description                       |
| -------------------------------------- | ------- | ----- | ---------- | ---------- | --------------------------------------- |
| - [formats](#ckan_datapusher_formats ) | No      | array | No         | -          | The enabled formats for the datapusher. |

#### <a name="ckan_datapusher_formats"></a>2.10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > datapusher > formats`

|          |         |
| -------- | ------- |
| **Type** | `array` |

**Description:** The enabled formats for the datapusher.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                 | Description |
| ----------------------------------------------- | ----------- |
| [formats items](#ckan_datapusher_formats_items) | -           |

##### <a name="ckan_datapusher_formats_items"></a>2.10.1.1. ckan configuration > ckan > datapusher > formats > formats items

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_image"></a>2.11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Defined in**            | #/$defs/image                                                  |

| Property                                  | Pattern | Type            | Deprecated | Definition             | Title/Description              |
| ----------------------------------------- | ------- | --------------- | ---------- | ---------------------- | ------------------------------ |
| - [registry](#ckan_image_registry )       | No      | string          | No         | -                      | The host of the registry       |
| - [pullPolicy](#ckan_image_pullPolicy )   | No      | string          | No         | -                      | -                              |
| - [repository](#ckan_image_repository )   | No      | string          | No         | -                      | The image path in the registry |
| - [tag](#ckan_image_tag )                 | No      | string          | No         | -                      | -                              |
| - [digest](#ckan_image_digest )           | No      | string          | No         | -                      | -                              |
| - [pullSecrets](#ckan_image_pullSecrets ) | No      | array of string | No         | In #/$defs/pullSecrets | -                              |

#### <a name="ckan_image_registry"></a>2.11.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > image > registry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The host of the registry

**Example:**

```yaml
docker.io
```

#### <a name="ckan_image_pullPolicy"></a>2.11.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > image > pullPolicy`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Example:**

```yaml
Always
```

#### <a name="ckan_image_repository"></a>2.11.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > image > repository`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The image path in the registry

**Example:**

```yaml
bitnami/kubectl
```

#### <a name="ckan_image_tag"></a>2.11.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > image > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_image_digest"></a>2.11.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > image > digest`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_image_pullSecrets"></a>2.11.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > image > pullSecrets`

|                |                     |
| -------------- | ------------------- |
| **Type**       | `array of string`   |
| **Defined in** | #/$defs/pullSecrets |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                    | Description |
| -------------------------------------------------- | ----------- |
| [pullSecrets items](#ckan_image_pullSecrets_items) | -           |

##### <a name="ckan_image_pullSecrets_items"></a>2.11.6.1. ckan configuration > ckan > image > pullSecrets > pullSecrets items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="ckan_ingress"></a>2.12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                              | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [ingressClassName](#ckan_ingress_ingressClassName ) | No      | string  | No         | -          | -                 |
| - [annotations](#ckan_ingress_annotations )           | No      | object  | No         | -          | -                 |
| - [hostname](#ckan_ingress_hostname )                 | No      | string  | No         | -          | -                 |
| - [selfSigned](#ckan_ingress_selfSigned )             | No      | boolean | No         | -          | -                 |
| - [tls](#ckan_ingress_tls )                           | No      | object  | No         | -          | -                 |
| - [existingSecret](#ckan_ingress_existingSecret )     | No      | string  | No         | -          | -                 |

#### <a name="ckan_ingress_ingressClassName"></a>2.12.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress > ingressClassName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_ingress_annotations"></a>2.12.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress > annotations`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

#### <a name="ckan_ingress_hostname"></a>2.12.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress > hostname`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_ingress_selfSigned"></a>2.12.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress > selfSigned`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="ckan_ingress_tls"></a>2.12.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress > tls`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                              | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [existingSecret](#ckan_ingress_tls_existingSecret ) | No      | string | No         | -          | -                 |

##### <a name="ckan_ingress_tls_existingSecret"></a>2.12.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress > tls > existingSecret`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_ingress_existingSecret"></a>2.12.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > ingress > existingSecret`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="ckan_persistence"></a>2.13. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > persistence`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                          | Pattern | Type             | Deprecated | Definition                                    | Title/Description                                                                                |
| ------------------------------------------------- | ------- | ---------------- | ---------- | --------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| - [accessMode](#ckan_persistence_accessMode )     | No      | enum (of string) | No         | -                                             | -                                                                                                |
| - [storageClass](#ckan_persistence_storageClass ) | No      | string           | No         | Same as [storageClass](#global_storageClass ) | The storageClass to use for persistence, otherwise use the cluster default (e.g. teutostack-ssd) |
| - [size](#ckan_persistence_size )                 | No      | object           | No         | In #/$defs/quantity                           | -                                                                                                |

#### <a name="ckan_persistence_accessMode"></a>2.13.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > persistence > accessMode`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "ReadWriteOnce"
* "ReadOnlyMany"
* "ReadWriteMany"
* "ReadWriteOncePod"

#### <a name="ckan_persistence_storageClass"></a>2.13.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string`                             |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, otherwise use the cluster default (e.g. teutostack-ssd)

#### <a name="ckan_persistence_size"></a>2.13.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > persistence > size`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/$defs/quantity                                                            |

| One of(Option)                            |
| ----------------------------------------- |
| [item 0](#ckan_persistence_size_oneOf_i0) |
| [item 1](#ckan_persistence_size_oneOf_i1) |

##### <a name="ckan_persistence_size_oneOf_i0"></a>2.13.3.1. Property `ckan configuration > ckan > persistence > size > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="ckan_persistence_size_oneOf_i1"></a>2.13.3.2. Property `ckan configuration > ckan > persistence > size > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `number` |

### <a name="ckan_sysadmin"></a>2.14. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > sysadmin`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                               | Pattern | Type   | Deprecated | Definition       | Title/Description |
| -------------------------------------- | ------- | ------ | ---------- | ---------------- | ----------------- |
| - [name](#ckan_sysadmin_name )         | No      | string | No         | -                | -                 |
| - [password](#ckan_sysadmin_password ) | No      | string | No         | -                | -                 |
| - [email](#ckan_sysadmin_email )       | No      | object | No         | In #/$defs/email | -                 |

#### <a name="ckan_sysadmin_name"></a>2.14.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > sysadmin > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_sysadmin_password"></a>2.14.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > sysadmin > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_sysadmin_email"></a>2.14.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > sysadmin > email`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/$defs/email                                                               |

| Restrictions                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```(?:[a-z0-9!#$%&'*+/=?^_`{\|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{\|}~-]+)*\|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\|\[(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\.){3}(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])``` [Test](https://regex101.com/?regex=%28%3F%3A%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%28%3F%3A%5C.%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%29%2A%7C%22%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21%5Cx23-%5Cx5b%5Cx5d-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2A%22%29%40%28%3F%3A%28%3F%3A%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%5C.%29%2B%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%7C%5C%5B%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%5C.%29%7B3%7D%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%7C%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%3A%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21-%5Cx5a%5Cx53-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2B%29%5C%5D%29) |

### <a name="ckan_smtp"></a>2.15. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > smtp`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                           | Pattern | Type    | Deprecated | Definition                             | Title/Description |
| ---------------------------------- | ------- | ------- | ---------- | -------------------------------------- | ----------------- |
| - [server](#ckan_smtp_server )     | No      | string  | No         | -                                      | -                 |
| - [user](#ckan_smtp_user )         | No      | string  | No         | -                                      | -                 |
| - [password](#ckan_smtp_password ) | No      | string  | No         | -                                      | -                 |
| - [mailFrom](#ckan_smtp_mailFrom ) | No      | object  | No         | Same as [email](#ckan_sysadmin_email ) | -                 |
| - [starttls](#ckan_smtp_starttls ) | No      | boolean | No         | -                                      | -                 |

#### <a name="ckan_smtp_server"></a>2.15.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > smtp > server`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_smtp_user"></a>2.15.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > smtp > user`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_smtp_password"></a>2.15.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > smtp > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="ckan_smtp_mailFrom"></a>2.15.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > smtp > mailFrom`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [email](#ckan_sysadmin_email)                                               |

#### <a name="ckan_smtp_starttls"></a>2.15.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > smtp > starttls`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="ckan_podSecurityContext"></a>2.16. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > podSecurityContext`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_securityContext"></a>2.17. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > securityContext`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_resources"></a>2.18. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="ckan_pattern1"></a>2.19. ![Optional](https://img.shields.io/badge/Optional-yellow) Pattern Property `ckan configuration > ckan > readiness\|liveness`
> All properties whose name matches the regular expression
```readiness|liveness``` ([Test](https://regex101.com/?regex=readiness%7Cliveness))
must respect the following conditions

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                     | Pattern | Type    | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------ | ------- | ------- | ---------- | ---------- | ----------------- |
| - [initialDelaySeconds](#ckan_pattern1_initialDelaySeconds ) | No      | integer | No         | -          | -                 |
| - [periodSeconds](#ckan_pattern1_periodSeconds )             | No      | integer | No         | -          | -                 |
| - [failureThreshold](#ckan_pattern1_failureThreshold )       | No      | integer | No         | -          | -                 |
| - [timeoutSeconds](#ckan_pattern1_timeoutSeconds )           | No      | integer | No         | -          | -                 |

#### <a name="ckan_pattern1_initialDelaySeconds"></a>2.19.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > readiness\|liveness > initialDelaySeconds`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

#### <a name="ckan_pattern1_periodSeconds"></a>2.19.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > readiness\|liveness > periodSeconds`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

#### <a name="ckan_pattern1_failureThreshold"></a>2.19.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > readiness\|liveness > failureThreshold`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

#### <a name="ckan_pattern1_timeoutSeconds"></a>2.19.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > ckan > readiness\|liveness > timeoutSeconds`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

## <a name="datapuscher"></a>3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > datapuscher`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                 | Pattern | Type   | Deprecated | Definition                    | Title/Description |
| -------------------------------------------------------- | ------- | ------ | ---------- | ----------------------------- | ----------------- |
| - [image](#datapuscher_image )                           | No      | object | No         | Same as [image](#ckan_image ) | -                 |
| - [podSecurityContext](#datapuscher_podSecurityContext ) | No      | object | No         | -                             | -                 |
| - [securityContext](#datapuscher_securityContext )       | No      | object | No         | -                             | -                 |
| - [resources](#datapuscher_resources )                   | No      | object | No         | -                             | -                 |

### <a name="datapuscher_image"></a>3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > datapuscher > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Same definition as**    | [image](#ckan_image)                                           |

### <a name="datapuscher_podSecurityContext"></a>3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > datapuscher > podSecurityContext`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="datapuscher_securityContext"></a>3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > datapuscher > securityContext`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="datapuscher_resources"></a>3.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > datapuscher > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

## <a name="postgresql"></a>4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                          | Pattern | Type    | Deprecated | Definition | Title/Description |
| --------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#postgresql_enabled ) | No      | boolean | No         | -          | -                 |
| - [ckanDbs](#postgresql_ckanDbs ) | No      | object  | No         | -          | -                 |

### <a name="postgresql_enabled"></a>4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="postgresql_ckanDbs"></a>4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql > ckanDbs`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                          | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [postgresPassword](#postgresql_ckanDbs_postgresPassword )       | No      | string | No         | -          | -                 |
| - [replicationPassword](#postgresql_ckanDbs_replicationPassword ) | No      | string | No         | -          | -                 |
| - [datastore\|datapusher\|ckan](#postgresql_ckanDbs_pattern1 )    | Yes     | object | No         | -          | -                 |

#### <a name="postgresql_ckanDbs_postgresPassword"></a>4.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql > ckanDbs > postgresPassword`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="postgresql_ckanDbs_replicationPassword"></a>4.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql > ckanDbs > replicationPassword`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="postgresql_ckanDbs_pattern1"></a>4.2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Pattern Property `ckan configuration > postgresql > ckanDbs > datastore\|datapusher\|ckan`
> All properties whose name matches the regular expression
```datastore|datapusher|ckan``` ([Test](https://regex101.com/?regex=datastore%7Cdatapusher%7Cckan))
must respect the following conditions

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [username](#postgresql_ckanDbs_pattern1_username ) | No      | string | No         | -          | -                 |
| - [password](#postgresql_ckanDbs_pattern1_password ) | No      | string | No         | -          | -                 |
| - [db](#postgresql_ckanDbs_pattern1_db )             | No      | string | No         | -          | -                 |

##### <a name="postgresql_ckanDbs_pattern1_username"></a>4.2.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql > ckanDbs > datastore\|datapusher\|ckan > username`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="postgresql_ckanDbs_pattern1_password"></a>4.2.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql > ckanDbs > datastore\|datapusher\|ckan > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="postgresql_ckanDbs_pattern1_db"></a>4.2.3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > postgresql > ckanDbs > datastore\|datapusher\|ckan > db`

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="redis"></a>5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > redis`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                     | Pattern | Type    | Deprecated | Definition | Title/Description |
| ---------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#redis_enabled ) | No      | boolean | No         | -          | -                 |

### <a name="redis_enabled"></a>5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > redis > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

## <a name="solr"></a>6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > solr`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                    | Pattern | Type    | Deprecated | Definition | Title/Description |
| --------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#solr_enabled ) | No      | boolean | No         | -          | -                 |

### <a name="solr_enabled"></a>6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `ckan configuration > solr > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

----------------------------------------------------------------------------------------------------------------------------
