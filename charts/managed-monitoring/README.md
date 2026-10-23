<!-- vim: set ft=markdown: -->
# managed-monitoring

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Deploys the metrics-forwarding agent for a managed service (e.g. teuto-cnpg databases) into a workload cluster remotely from the management cluster, without requiring Flux on the workload cluster itself.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| tasches | <st@teuto.net> |  |

## Usage

This chart is installed on the **management cluster**, once per workload cluster, into that cluster's own CAPI namespace (the
same namespace as its `<cluster>-kubeconfig` secret). It renders two `HelmRelease`s targeting the workload cluster remotely via
`spec.kubeConfig` (so the workload cluster itself doesn't need Flux installed):

- a copy of `prometheus.existingSecret.name` (which must already exist on the management cluster, in this release's own
  namespace) into the workload cluster as a Secret named `prometheus-write`
- the metrics agent itself, which scrapes `teuto-cnpg`-managed database and operator pods and remote-writes to
  `prometheus.url`, authenticating with the copied secret

# managed-monitoring configuration

**Title:** managed-monitoring configuration

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                           | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                             |
| ---------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------- |
| - [namespace](#namespace )         | No      | string | No         | -          | The namespace on the workload cluster to deploy the metrics agent and the copied prometheus-write secret into |
| + [targetCluster](#targetCluster ) | No      | object | No         | -          | The workload cluster the metrics agent gets deployed into remotely                                            |
| + [prometheus](#prometheus )       | No      | object | No         | -          | Central Prometheus this cluster's managed-service metrics get remote-written to                               |
| - [resources](#resources )         | No      | object | No         | -          | See common.resources                                                                                          |

## <a name="namespace"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `managed-monitoring configuration > namespace`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The namespace on the workload cluster to deploy the metrics agent and the copied prometheus-write secret into

## <a name="targetCluster"></a>2. ![Required](https://img.shields.io/badge/Required-blue) Property `managed-monitoring configuration > targetCluster`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** The workload cluster the metrics agent gets deployed into remotely

| Property                                                       | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                                                                                                                                                                      |
| -------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [kubeconfigSecretName](#targetCluster_kubeconfigSecretName ) | No      | string | No         | -          | Name of the Secret (in this release's own namespace, on the management cluster) holding the workload cluster's kubeconfig, e.g. the CAPI-provided '<cluster>-kubeconfig' secret. Only needed if this release isn't installed as '<cluster-name>-mm' -- otherwise it's derived automatically and this can be left empty |

### <a name="targetCluster_kubeconfigSecretName"></a>2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `managed-monitoring configuration > targetCluster > kubeconfigSecretName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Name of the Secret (in this release's own namespace, on the management cluster) holding the workload cluster's kubeconfig, e.g. the CAPI-provided '<cluster>-kubeconfig' secret. Only needed if this release isn't installed as '<cluster-name>-mm' -- otherwise it's derived automatically and this can be left empty

## <a name="prometheus"></a>3. ![Required](https://img.shields.io/badge/Required-blue) Property `managed-monitoring configuration > prometheus`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Central Prometheus this cluster's managed-service metrics get remote-written to

| Property                                        | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                                                                  |
| ----------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| + [url](#prometheus_url )                       | No      | string | No         | -          | -                                                                                                                                                                                                                  |
| + [existingSecret](#prometheus_existingSecret ) | No      | object | No         | -          | A Secret with 'username'/'password' keys, already present in this release's own namespace on the management cluster. It gets copied into the workload cluster (as 'prometheus-write') for the metrics agent to use |

### <a name="prometheus_url"></a>3.1. ![Required](https://img.shields.io/badge/Required-blue) Property `managed-monitoring configuration > prometheus > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions   |   |
| -------------- | - |
| **Min length** | 1 |

### <a name="prometheus_existingSecret"></a>3.2. ![Required](https://img.shields.io/badge/Required-blue) Property `managed-monitoring configuration > prometheus > existingSecret`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** A Secret with 'username'/'password' keys, already present in this release's own namespace on the management cluster. It gets copied into the workload cluster (as 'prometheus-write') for the metrics agent to use

| Property                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| + [name](#prometheus_existingSecret_name ) | No      | string | No         | -          | -                 |

#### <a name="prometheus_existingSecret_name"></a>3.2.1. ![Required](https://img.shields.io/badge/Required-blue) Property `managed-monitoring configuration > prometheus > existingSecret > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions   |   |
| -------------- | - |
| **Min length** | 1 |

## <a name="resources"></a>4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `managed-monitoring configuration > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** See common.resources

----------------------------------------------------------------------------------------------------------------------------

