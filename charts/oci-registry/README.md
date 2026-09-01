[modeline]: # ( vim: set ft=markdown: )
# oci-registry

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.4.5](https://img.shields.io/badge/AppVersion-0.4.5-informational?style=flat-square)

An implementation of the OCI Registry spec with filesystem and S3 storage back-ends, acting as a pull-through cache (mirror); pushing is not yet implemented

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| tasches | <st@teuto.net> |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/teutonet/teutonet-helm-charts | common | 2.2.0 |

# oci-registry helmchart

**Title:** oci-registry helmchart

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                 | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                            |
| ------------------------ | ------- | ------ | ---------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------- |
| - [global](#global )     | No      | object | No         | -          | -                                                                                                                            |
| - [registry](#registry ) | No      | object | No         | -          | An implementation of the OCI Registry spec with filesystem and S3 storage back-ends, acting as a pull-through cache (mirror) |
| - [common](#common )     | No      | object | No         | -          | Values for sub-chart                                                                                                         |

## <a name="global"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                            | Pattern | Type            | Deprecated | Definition | Title/Description |
| --------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [imagePullSecrets](#global_imagePullSecrets )     | No      | array of object | No         | -          | -                 |
| - [podSecurityContext](#global_podSecurityContext ) | No      | object          | No         | -          | -                 |
| - [securityContext](#global_securityContext )       | No      | object          | No         | -          | -                 |

### <a name="global_imagePullSecrets"></a>1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > imagePullSecrets`

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

#### <a name="global_imagePullSecrets_items"></a>1.1.1. oci-registry helmchart > global > imagePullSecrets > imagePullSecrets items

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                       | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [name](#global_imagePullSecrets_items_name ) | No      | string | No         | -          | -                 |

##### <a name="global_imagePullSecrets_items_name"></a>1.1.1.1. Property `oci-registry helmchart > global > imagePullSecrets > imagePullSecrets items > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_podSecurityContext"></a>1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                           | Pattern | Type    | Deprecated | Definition | Title/Description |
| ---------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [runAsNonRoot](#global_podSecurityContext_runAsNonRoot )                         | No      | boolean | No         | -          | -                 |
| - [readOnlyRootFilesystem](#global_podSecurityContext_readOnlyRootFilesystem )     | No      | boolean | No         | -          | -                 |
| - [allowPrivilegeEscalation](#global_podSecurityContext_allowPrivilegeEscalation ) | No      | boolean | No         | -          | -                 |
| - [privileged](#global_podSecurityContext_privileged )                             | No      | boolean | No         | -          | -                 |
| - [capabilities](#global_podSecurityContext_capabilities )                         | No      | object  | No         | -          | -                 |
| - [runAsGroup](#global_podSecurityContext_runAsGroup )                             | No      | integer | No         | -          | -                 |
| - [runAsUser](#global_podSecurityContext_runAsUser )                               | No      | integer | No         | -          | -                 |

#### <a name="global_podSecurityContext_runAsNonRoot"></a>1.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > runAsNonRoot`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="global_podSecurityContext_readOnlyRootFilesystem"></a>1.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > readOnlyRootFilesystem`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="global_podSecurityContext_allowPrivilegeEscalation"></a>1.2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > allowPrivilegeEscalation`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="global_podSecurityContext_privileged"></a>1.2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > privileged`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="global_podSecurityContext_capabilities"></a>1.2.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > capabilities`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                | Pattern | Type            | Deprecated | Definition | Title/Description |
| ------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [drop](#global_podSecurityContext_capabilities_drop ) | No      | array of string | No         | -          | -                 |

##### <a name="global_podSecurityContext_capabilities_drop"></a>1.2.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > capabilities > drop`

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

| Each item of this array must be                                  | Description |
| ---------------------------------------------------------------- | ----------- |
| [drop items](#global_podSecurityContext_capabilities_drop_items) | -           |

###### <a name="global_podSecurityContext_capabilities_drop_items"></a>1.2.5.1.1. oci-registry helmchart > global > podSecurityContext > capabilities > drop > drop items

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="global_podSecurityContext_runAsGroup"></a>1.2.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > runAsGroup`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

#### <a name="global_podSecurityContext_runAsUser"></a>1.2.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > podSecurityContext > runAsUser`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

### <a name="global_securityContext"></a>1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > securityContext`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                              | Pattern | Type             | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| - [fsGroup](#global_securityContext_fsGroup )                         | No      | integer          | No         | -          | -                 |
| - [runAsUser](#global_securityContext_runAsUser )                     | No      | integer          | No         | -          | -                 |
| - [runAsGroup](#global_securityContext_runAsGroup )                   | No      | integer          | No         | -          | -                 |
| - [runAsNonRoot](#global_securityContext_runAsNonRoot )               | No      | boolean          | No         | -          | -                 |
| - [fsGroupChangePolicy](#global_securityContext_fsGroupChangePolicy ) | No      | enum (of string) | No         | -          | -                 |

#### <a name="global_securityContext_fsGroup"></a>1.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > securityContext > fsGroup`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

#### <a name="global_securityContext_runAsUser"></a>1.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > securityContext > runAsUser`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

#### <a name="global_securityContext_runAsGroup"></a>1.3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > securityContext > runAsGroup`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

#### <a name="global_securityContext_runAsNonRoot"></a>1.3.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > securityContext > runAsNonRoot`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="global_securityContext_fsGroupChangePolicy"></a>1.3.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > global > securityContext > fsGroupChangePolicy`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "Always"
* "OnRootMismatch"

## <a name="registry"></a>2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** An implementation of the OCI Registry spec with filesystem and S3 storage back-ends, acting as a pull-through cache (mirror)

| Property                                          | Pattern | Type             | Deprecated | Definition                      | Title/Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------------- | ------- | ---------------- | ---------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| - [image](#registry_image )                       | No      | object           | No         | -                               | -                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| - [replicas](#registry_replicas )                 | No      | integer          | No         | -                               | -                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| - [resourcesPreset](#registry_resourcesPreset )   | No      | enum (of string) | No         | In #/$defs/resourcesPreset      | -                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| - [resources](#registry_resources )               | No      | object           | No         | In #/$defs/resourceRequirements | ResourceRequirements describes the compute resource requirements.                                                                                                                                                                                                                                                                                                                                                                                                                          |
| - [extraEnvVars](#registry_extraEnvVars )         | No      | object           | No         | -                               | Map of env var name to either a plain string value, or an object for the remaining Kubernetes EnvVar fields (e.g. valueFrom)                                                                                                                                                                                                                                                                                                                                                               |
| - [checkCacheDigest](#registry_checkCacheDigest ) | No      | boolean          | No         | -                               | Whether to check the digest of a cached blob/manifest against upstream before serving it                                                                                                                                                                                                                                                                                                                                                                                                   |
| - [upstream](#registry_upstream )                 | No      | object           | No         | -                               | -                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| - [storage](#registry_storage )                   | No      | object           | No         | -                               | -                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| - [service](#registry_service )                   | No      | object           | No         | -                               | -                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| - [ingress](#registry_ingress )                   | No      | object           | No         | -                               | External access to the registry. type: gatewayApi uses Gateway API (an HTTPRoute plus our own ListenerSet for TLS) instead of a plain Ingress; the \`ingress\` sub-object only applies to type: ingress, \`gatewayApi\` only applies to type: gatewayApi. Unless tls.existingSecret is set, the cert is auto-issued by cert-manager into a Secret named "<fullname>-tls" -- via the kubernetes.io/tls-acme annotation for type: ingress, or gatewayApi.clusterIssuer for type: gatewayApi. |

### <a name="registry_image"></a>2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                    | Pattern | Type   | Deprecated | Definition | Title/Description              |
| ------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------ |
| - [registry](#registry_image_registry )     | No      | string | No         | -          | The host of the registry       |
| - [repository](#registry_image_repository ) | No      | string | No         | -          | The image path in the registry |
| - [tag](#registry_image_tag )               | No      | string | No         | -          | -                              |
| - [digest](#registry_image_digest )         | No      | string | No         | -          | -                              |

#### <a name="registry_image_registry"></a>2.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > image > registry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The host of the registry

**Example:**

```yaml
docker.io
```

#### <a name="registry_image_repository"></a>2.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > image > repository`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The image path in the registry

**Example:**

```yaml
mcronce/oci-registry
```

#### <a name="registry_image_tag"></a>2.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > image > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="registry_image_digest"></a>2.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > image > digest`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="registry_replicas"></a>2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

### <a name="registry_resourcesPreset"></a>2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > resourcesPreset`

|                |                         |
| -------------- | ----------------------- |
| **Type**       | `enum (of string)`      |
| **Defined in** | #/$defs/resourcesPreset |

Must be one of:
* "none"
* "nano"
* "micro"
* "small"
* "medium"
* "large"
* "xlarge"
* "2xlarge"

### <a name="registry_resources"></a>2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/$defs/resourceRequirements                                                |

**Description:** ResourceRequirements describes the compute resource requirements.

| Property                                    | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| - [claims](#registry_resources_claims )     | No      | array  | No         | -          | Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.<br /><br />This field depends on the DynamicResourceAllocation feature gate.<br /><br />This field is immutable. It can only be set for containers.                                                                                  |
| - [limits](#registry_resources_limits )     | No      | object | No         | -          | Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/                                                                                                                                                                                |
| - [requests](#registry_resources_requests ) | No      | object | No         | -          | Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

#### <a name="registry_resources_claims"></a>2.4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > resources > claims`

|          |         |
| -------- | ------- |
| **Type** | `array` |

**Description:** Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.

This field depends on the DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                      | Description                                                   |
| -------------------------------------------------------------------- | ------------------------------------------------------------- |
| [io.k8s.api.core.v1.ResourceClaim](#registry_resources_claims_items) | ResourceClaim references one entry in PodSpec.ResourceClaims. |

##### <a name="registry_resources_claims_items"></a>2.4.1.1. oci-registry helmchart > registry > resources > claims > io.k8s.api.core.v1.ResourceClaim

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Defined in**            | #/definitions/io.k8s.api.core.v1.ResourceClaim                 |

**Description:** ResourceClaim references one entry in PodSpec.ResourceClaims.

| Property                                               | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                   |
| ------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| + [name](#registry_resources_claims_items_name )       | No      | string | No         | -          | Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container.          |
| - [request](#registry_resources_claims_items_request ) | No      | string | No         | -          | Request is the name chosen for a request in the referenced claim. If empty, everything from the claim is made available, otherwise only the result of this request. |

###### <a name="registry_resources_claims_items_name"></a>2.4.1.1.1. Property `oci-registry helmchart > registry > resources > claims > claims items > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container.

###### <a name="registry_resources_claims_items_request"></a>2.4.1.1.2. Property `oci-registry helmchart > registry > resources > claims > claims items > request`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Request is the name chosen for a request in the referenced claim. If empty, everything from the claim is made available, otherwise only the result of this request.

#### <a name="registry_resources_limits"></a>2.4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > resources > limits`

|                           |                                                                                                                        |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                               |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#registry_resources_limits_additionalProperties) |

**Description:** Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

| Property                                               | Pattern | Type   | Deprecated | Definition                                                     | Title/Description |
| ------------------------------------------------------ | ------- | ------ | ---------- | -------------------------------------------------------------- | ----------------- |
| - [](#registry_resources_limits_additionalProperties ) | No      | object | No         | In #/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity | -                 |

##### <a name="registry_resources_limits_additionalProperties"></a>2.4.2.1. Property `oci-registry helmchart > registry > resources > limits > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/definitions/io.k8s.apimachinery.pkg.api.resource.Quantity                 |

| One of(Option)                                                     |
| ------------------------------------------------------------------ |
| [item 0](#registry_resources_limits_additionalProperties_oneOf_i0) |
| [item 1](#registry_resources_limits_additionalProperties_oneOf_i1) |

###### <a name="registry_resources_limits_additionalProperties_oneOf_i0"></a>2.4.2.1.1. Property `oci-registry helmchart > registry > resources > limits > additionalProperties > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_resources_limits_additionalProperties_oneOf_i1"></a>2.4.2.1.2. Property `oci-registry helmchart > registry > resources > limits > additionalProperties > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `number` |

#### <a name="registry_resources_requests"></a>2.4.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > resources > requests`

|                           |                                                                                                                          |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                 |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#registry_resources_requests_additionalProperties) |

**Description:** Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

| Property                                                 | Pattern | Type   | Deprecated | Definition                                                                                                 | Title/Description |
| -------------------------------------------------------- | ------- | ------ | ---------- | ---------------------------------------------------------------------------------------------------------- | ----------------- |
| - [](#registry_resources_requests_additionalProperties ) | No      | object | No         | Same as [registry_resources_limits_additionalProperties](#registry_resources_limits_additionalProperties ) | -                 |

##### <a name="registry_resources_requests_additionalProperties"></a>2.4.3.1. Property `oci-registry helmchart > registry > resources > requests > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                       |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                       |
| **Same definition as**    | [registry_resources_limits_additionalProperties](#registry_resources_limits_additionalProperties) |

### <a name="registry_extraEnvVars"></a>2.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > extraEnvVars`

|                           |                                                                                                                    |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                           |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#registry_extraEnvVars_additionalProperties) |

**Description:** Map of env var name to either a plain string value, or an object for the remaining Kubernetes EnvVar fields (e.g. valueFrom)

| Property                                           | Pattern | Type        | Deprecated | Definition | Title/Description |
| -------------------------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [](#registry_extraEnvVars_additionalProperties ) | No      | Combination | No         | -          | -                 |

#### <a name="registry_extraEnvVars_additionalProperties"></a>2.5.1. Property `oci-registry helmchart > registry > extraEnvVars > additionalProperties`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                                                 |
| -------------------------------------------------------------- |
| [item 0](#registry_extraEnvVars_additionalProperties_oneOf_i0) |
| [item 1](#registry_extraEnvVars_additionalProperties_oneOf_i1) |

##### <a name="registry_extraEnvVars_additionalProperties_oneOf_i0"></a>2.5.1.1. Property `oci-registry helmchart > registry > extraEnvVars > additionalProperties > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="registry_extraEnvVars_additionalProperties_oneOf_i1"></a>2.5.1.2. Property `oci-registry helmchart > registry > extraEnvVars > additionalProperties > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="registry_checkCacheDigest"></a>2.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > checkCacheDigest`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

**Description:** Whether to check the digest of a cached blob/manifest against upstream before serving it

### <a name="registry_upstream"></a>2.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > upstream`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                   | Pattern | Type   | Deprecated | Definition | Title/Description                                                                          |
| ---------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------ |
| - [config](#registry_upstream_config )                     | No      | object | No         | -          | Rendered as-is into the upstream registries configuration file consumed by the application |
| - [defaultNamespace](#registry_upstream_defaultNamespace ) | No      | string | No         | -          | -                                                                                          |

#### <a name="registry_upstream_config"></a>2.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > upstream > config`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Rendered as-is into the upstream registries configuration file consumed by the application

| Property                                          | Pattern | Type            | Deprecated | Definition | Title/Description |
| ------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [contents](#registry_upstream_config_contents ) | No      | array of object | No         | -          | -                 |

##### <a name="registry_upstream_config_contents"></a>2.7.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > upstream > config > contents`

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

| Each item of this array must be                            | Description |
| ---------------------------------------------------------- | ----------- |
| [contents items](#registry_upstream_config_contents_items) | -           |

###### <a name="registry_upstream_config_contents_items"></a>2.7.1.1.1. oci-registry helmchart > registry > upstream > config > contents > contents items

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                             | Pattern | Type    | Deprecated | Definition | Title/Description |
| ---------------------------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [namespace](#registry_upstream_config_contents_items_namespace )                                   | No      | string  | No         | -          | -                 |
| + [host](#registry_upstream_config_contents_items_host )                                             | No      | string  | No         | -          | -                 |
| - [tls](#registry_upstream_config_contents_items_tls )                                               | No      | boolean | No         | -          | -                 |
| - [accept_invalid_certs](#registry_upstream_config_contents_items_accept_invalid_certs )             | No      | boolean | No         | -          | -                 |
| - [user_agent](#registry_upstream_config_contents_items_user_agent )                                 | No      | string  | No         | -          | -                 |
| - [username](#registry_upstream_config_contents_items_username )                                     | No      | string  | No         | -          | -                 |
| - [password](#registry_upstream_config_contents_items_password )                                     | No      | string  | No         | -          | -                 |
| - [manifest_invalidation_time](#registry_upstream_config_contents_items_manifest_invalidation_time ) | No      | string  | No         | -          | -                 |
| - [blob_invalidation_time](#registry_upstream_config_contents_items_blob_invalidation_time )         | No      | string  | No         | -          | -                 |

###### <a name="registry_upstream_config_contents_items_namespace"></a>2.7.1.1.1.1. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > namespace`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_upstream_config_contents_items_host"></a>2.7.1.1.1.2. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > host`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_upstream_config_contents_items_tls"></a>2.7.1.1.1.3. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > tls`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

###### <a name="registry_upstream_config_contents_items_accept_invalid_certs"></a>2.7.1.1.1.4. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > accept_invalid_certs`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

###### <a name="registry_upstream_config_contents_items_user_agent"></a>2.7.1.1.1.5. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > user_agent`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_upstream_config_contents_items_username"></a>2.7.1.1.1.6. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > username`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_upstream_config_contents_items_password"></a>2.7.1.1.1.7. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_upstream_config_contents_items_manifest_invalidation_time"></a>2.7.1.1.1.8. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > manifest_invalidation_time`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_upstream_config_contents_items_blob_invalidation_time"></a>2.7.1.1.1.9. Property `oci-registry helmchart > registry > upstream > config > contents > contents items > blob_invalidation_time`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="registry_upstream_defaultNamespace"></a>2.7.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > upstream > defaultNamespace`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="registry_storage"></a>2.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                      | Pattern | Type             | Deprecated | Definition | Title/Description |
| --------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| - [mode](#registry_storage_mode )             | No      | enum (of string) | No         | -          | -                 |
| - [filesystem](#registry_storage_filesystem ) | No      | object           | No         | -          | -                 |
| - [s3](#registry_storage_s3 )                 | No      | object           | No         | -          | -                 |

#### <a name="registry_storage_mode"></a>2.8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > mode`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "filesystem"
* "s3"

#### <a name="registry_storage_filesystem"></a>2.8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > filesystem`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                     | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [path](#registry_storage_filesystem_path ) | No      | string | No         | -          | -                 |

##### <a name="registry_storage_filesystem_path"></a>2.8.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > filesystem > path`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="registry_storage_s3"></a>2.8.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                         | Pattern | Type   | Deprecated | Definition | Title/Description      |
| ------------------------------------------------ | ------- | ------ | ---------- | ---------- | ---------------------- |
| - [host](#registry_storage_s3_host )             | No      | string | No         | -          | Leave blank to use AWS |
| - [region](#registry_storage_s3_region )         | No      | string | No         | -          | -                      |
| - [bucket](#registry_storage_s3_bucket )         | No      | string | No         | -          | -                      |
| - [authSecret](#registry_storage_s3_authSecret ) | No      | object | No         | -          | -                      |

##### <a name="registry_storage_s3_host"></a>2.8.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3 > host`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Leave blank to use AWS

##### <a name="registry_storage_s3_region"></a>2.8.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3 > region`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="registry_storage_s3_bucket"></a>2.8.3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3 > bucket`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="registry_storage_s3_authSecret"></a>2.8.3.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3 > authSecret`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                  | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                          |
| --------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ---------------------------------------------------------------------------------------------------------- |
| - [name](#registry_storage_s3_authSecret_name )           | No      | string | No         | -          | Use an existing Secret (with access_key/secret_key keys) instead of deploying one from accessKey/secretKey |
| - [accessKey](#registry_storage_s3_authSecret_accessKey ) | No      | string | No         | -          | -                                                                                                          |
| - [secretKey](#registry_storage_s3_authSecret_secretKey ) | No      | string | No         | -          | -                                                                                                          |

###### <a name="registry_storage_s3_authSecret_name"></a>2.8.3.4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3 > authSecret > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Use an existing Secret (with access_key/secret_key keys) instead of deploying one from accessKey/secretKey

###### <a name="registry_storage_s3_authSecret_accessKey"></a>2.8.3.4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3 > authSecret > accessKey`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_storage_s3_authSecret_secretKey"></a>2.8.3.4.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > storage > s3 > authSecret > secretKey`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="registry_service"></a>2.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > service`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                        | Pattern | Type             | Deprecated | Definition | Title/Description |
| ----------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| - [type](#registry_service_type )               | No      | enum (of string) | No         | -          | -                 |
| - [annotations](#registry_service_annotations ) | No      | object           | No         | -          | -                 |

#### <a name="registry_service_type"></a>2.9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > service > type`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "ClusterIP"
* "NodePort"
* "LoadBalancer"

#### <a name="registry_service_annotations"></a>2.9.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > service > annotations`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="registry_ingress"></a>2.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** External access to the registry. type: gatewayApi uses Gateway API (an HTTPRoute plus our own ListenerSet for TLS) instead of a plain Ingress; the `ingress` sub-object only applies to type: ingress, `gatewayApi` only applies to type: gatewayApi. Unless tls.existingSecret is set, the cert is auto-issued by cert-manager into a Secret named "<fullname>-tls" -- via the kubernetes.io/tls-acme annotation for type: ingress, or gatewayApi.clusterIssuer for type: gatewayApi.

| Property                                        | Pattern | Type             | Deprecated | Definition | Title/Description |
| ----------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| - [enabled](#registry_ingress_enabled )         | No      | boolean          | No         | -          | -                 |
| - [type](#registry_ingress_type )               | No      | enum (of string) | No         | -          | -                 |
| - [hostname](#registry_ingress_hostname )       | No      | string           | No         | -          | -                 |
| - [annotations](#registry_ingress_annotations ) | No      | object           | No         | -          | -                 |
| - [tls](#registry_ingress_tls )                 | No      | object           | No         | -          | -                 |
| - [ingress](#registry_ingress_ingress )         | No      | object           | No         | -          | -                 |
| - [gatewayApi](#registry_ingress_gatewayApi )   | No      | object           | No         | -          | -                 |

#### <a name="registry_ingress_enabled"></a>2.10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="registry_ingress_type"></a>2.10.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > type`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "ingress"
* "gatewayApi"

#### <a name="registry_ingress_hostname"></a>2.10.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > hostname`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="registry_ingress_annotations"></a>2.10.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > annotations`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

#### <a name="registry_ingress_tls"></a>2.10.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > tls`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                  | Pattern | Type   | Deprecated | Definition | Title/Description                                                                             |
| --------------------------------------------------------- | ------- | ------ | ---------- | ---------- | --------------------------------------------------------------------------------------------- |
| - [existingSecret](#registry_ingress_tls_existingSecret ) | No      | string | No         | -          | Use an existing cert Secret instead of having cert-manager issue one, for either ingress type |

##### <a name="registry_ingress_tls_existingSecret"></a>2.10.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > tls > existingSecret`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Use an existing cert Secret instead of having cert-manager issue one, for either ingress type

#### <a name="registry_ingress_ingress"></a>2.10.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > ingress`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [className](#registry_ingress_ingress_className ) | No      | string | No         | -          | -                 |

##### <a name="registry_ingress_ingress_className"></a>2.10.6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > ingress > className`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="registry_ingress_gatewayApi"></a>2.10.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > gatewayApi`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                       | Pattern | Type   | Deprecated | Definition | Title/Description                                                                       |
| -------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | --------------------------------------------------------------------------------------- |
| - [gateway](#registry_ingress_gatewayApi_gateway )             | No      | object | No         | -          | The Gateway our ListenerSet attaches to. The listener's hostname is \`hostname\` above. |
| - [clusterIssuer](#registry_ingress_gatewayApi_clusterIssuer ) | No      | string | No         | -          | cert-manager ClusterIssuer name, used unless tls.existingSecret is set                  |

##### <a name="registry_ingress_gatewayApi_gateway"></a>2.10.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > gatewayApi > gateway`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** The Gateway our ListenerSet attaches to. The listener's hostname is `hostname` above.

| Property                                                       | Pattern | Type   | Deprecated | Definition | Title/Description                          |
| -------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------ |
| - [name](#registry_ingress_gatewayApi_gateway_name )           | No      | string | No         | -          | -                                          |
| - [namespace](#registry_ingress_gatewayApi_gateway_namespace ) | No      | string | No         | -          | If different from this release's namespace |

###### <a name="registry_ingress_gatewayApi_gateway_name"></a>2.10.7.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > gatewayApi > gateway > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="registry_ingress_gatewayApi_gateway_namespace"></a>2.10.7.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > gatewayApi > gateway > namespace`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** If different from this release's namespace

##### <a name="registry_ingress_gatewayApi_clusterIssuer"></a>2.10.7.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > registry > ingress > gatewayApi > clusterIssuer`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** cert-manager ClusterIssuer name, used unless tls.existingSecret is set

## <a name="common"></a>3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `oci-registry helmchart > common`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** Values for sub-chart

----------------------------------------------------------------------------------------------------------------------------

