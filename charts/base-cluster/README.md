<!-- vim: set ft=markdown: --># base-cluster

![Version: 9.0.0](https://img.shields.io/badge/Version-9.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A common base for every kubernetes cluster

**Homepage:** <https://teuto.net>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cwrau | <cwr@teuto.net> |  |
| marvinWolff | <mw@teuto.net> |  |
| tasches | <st@teuto.net> |  |

## Cluster bootstrap

The `.x.x` part of the versions can be left as is, helm uses that as a range. If you choose to set a fix version, you have to take care of the updates yourself.

```sh
# always be git 😁
git init

# create empty cluster HelmRelease;
flux create helmrelease --export base-cluster -n flux-system --source HelmRepository/teuto-net.flux-system --chart base-cluster --chart-version 9.x.x > cluster.yaml

# maybe use the following name for your cluster;
kubectl get node -o jsonpath='{.items[0].metadata.annotations.cluster\.x-k8s\.io/cluster-name}'

# configure according to your needs, at least `.global.clusterName` is needed
# additionally, you should add your git repo to `.flux.gitRepositories`, see [the documentation](https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/base-cluster#81--property-base-cluster-configuration--flux--gitrepositories)
# make sure to use the correct url format, see [the documentation](https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/base-cluster#81112-property-base-cluster-configuration--flux--gitrepositories--additionalproperties--allof--item-0--oneof--item-1)
vi cluster.yaml

# create HelmRelease for flux to manage itself
kubectl create namespace flux-system --dry-run=client -o yaml > flux.yaml
flux create source helm --url https://fluxcd-community.github.io/helm-charts flux -n flux-system --export >> flux.yaml
flux create helmrelease --export --crds CreateReplace flux -n flux-system --source HelmRepository/flux.flux-system --chart flux2 --chart-version 2.x.x >> flux.yaml

# add, commit and push resources
git add cluster.yaml flux.yaml
git commit cluster.yaml flux.yaml
git push

# after this you should be on the KUBECONFIG for the cluster
# we explicitly do not use `flux bootstrap` or `flux install` as this creates kustomization stuff and installs flux manually
kubectl apply --server-side -f flux.yaml # ignore the errors about missing CRDs
helm install -n flux-system flux flux2 --repo https://fluxcd-community.github.io/helm-charts --version 2.x.x --atomic

# manual initial installation of the chart, afterwards the chart takes over
# after the installation finished, follow the on-screen instructions to configure your flux, distribute KUBECONFIGs, ...
helm install -n flux-system base-cluster oci://ghcr.io/teutonet/teutonet-helm-charts/base-cluster --version 9.x.x --atomic --values <(cat cluster.yaml | yq -y .spec.values)

# you can use this command to get the instructions again
# e.g. when adding users, gitRepositories, ...
helm -n flux-system get notes base-cluster
```

> ⚠️  Due to various reasons, it's not possible to cleanly uninstall this
via a normal `kubectl delete`, `helm uninstall` or via flux deletion.
[See the corresponding issue](https://github.com/teutonet/teutonet-helm-charts/issues/28)

## Cluster components

### Component [backup](#backup)

[velero](https://velero.io) takes care of backing up your PVCs.

### Component [cert-manager](#certManager)

[cert-manager](https://cert-manager.io) takes care of creating SSL certificates
for your Ingresses (and [other needs](https://cert-manager.io/docs/usage))

1. set `.certManager.email` to your email for the Let's Encrypt account to enable
   certificates

To create wildcard certificates, you need to enable a [DNS Provider](#component-dns)

Then you can just create a [`Certificate`](https://cert-manager.io/docs/usage/certificate)
resource.

### Component [descheduler](#descheduler)

The [descheduler](https://github.com/kubernetes-sigs/descheduler) runs periodically
and tries to average the load across the nodes by deleting pods on fuller nodes
so the kube-scheduler can, hopefully, schedule them on nodes with more space.

Additionally, the descheduler also tries to reconcile `topologySpreadConstraints`
and affinities.

If the cluster is _semi_ underspecced or the individual applications have imperfect
resource requests, the descheduler might lead to period restarting of random pods.

In that case you should disable the descheduler.

### Component [dns](#dns)

The [external-dns](https://github.com/kubernetes-sigs/external-dns) creates, updates,
deletes and syncs DNS records for your Ingresses.

1. set `.dns.provider.<provider>` to your implementation:
    - cloudflare: `.dns.provider.cloudflare.apiToken`

If you need a different provider than cloudflare, please open a ticket for one of
the [supported ones](https://github.com/kubernetes-sigs/external-dns#status-of-providers)
which is also supported by [cert-manager](https://cert-manager.io/docs/configuration/acme/dns01/#supported-dns01-providers)

### Component [ingress](#ingress)

The chart supports two ingress controllers:

1. [`nginx` ingress-controller](https://docs.nginx.com/nginx-ingress-controller) (default)
   - Works with `IngressClassName: nginx` or if none is defined
   - Provides built-in metrics and tracing support

2. [`traefik`](https://traefik.io) (recommended)
   - Works with `IngressClassName: ingress-controller` or if none is defined
   - Provides built-in metrics and tracing support
   - Also supports [Gateway API](https://gateway-api.sigs.k8s.io)

#### TLS

1. add `kubernetes.io/tls-acme: "true"` to your Ingress's annotations
    - additionally, although not advised unless you know what you're doing,
      you can explicitly choose the Issuer by using these annotations:
      - `cert-manager.io/cluster-issuer: letsencrypt-staging`
      - `cert-manager.io/cluster-issuer: letsencrypt-production`

#### IP Address

If you want to make sure that, in the event of a catastrophic failure, you keep the
same IP address, you should roll this out, get the assigned IP
(`kubectl -n ingress-nginx get svc ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress}'` for nginx or `kubectl -n ingress get svc ingress-controller -o jsonpath='{.status.loadBalancer.ingress}'` for traefik)
and set `.ingress.IP=<ip>` in the values. This makes sure the IP is kept in your
project (may incur cost!), which means you can reuse it later or after recovery.

### Component [flux](#flux)

[Flux](https://fluxcd.io) is used to deploy resources to your cluster and to
keep them in sync.

Flux can also auto-update images and HelmReleases.

You can create any number of gitRepository connections, with SSH(recommended)
or https checkout, with or without SOPS, ... .

### Component [kyverno](#kyverno)

You can optionally enable [kyverno](https://kyverno.io), which is a policy
system, allowing you to specify in-depth policies to prevent or force certain
things in your cluster.

### Component [monitoring](#monitoring)

#### Sub-Component [prometheus](#monitoring_prometheus)

[Prometheus](https://prometheus.io) takes care of scraping metrics and alerting.

#### Sub-Component [grafana](#monitoring_grafana)

[Grafana](https://grafana.com) is used to create dashboards to visualize your
metrics and the health of your cluster and applications.

#### Sub-Component [loki](#monitoring_loki)

[Loki](https://grafana.com/oss/loki) collects logs from across the cluster and
allows to have a centralized, non-CLI, view of the logs and to create alerting
based on them.

#### Sub-Component [metrics-server](#monitoring_metricsServer)

[Metrics Server](https://github.com/kubernetes-sigs/metrics-server) implements
the [kubernetes Metrics API](https://github.com/kubernetes/metrics) to allow
for [Horizontal Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale),
[Vertical Autoscaling](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler)
and to allow `kubectl top` and tools like [k9s](https://k9scli.io) to show
resource usage for your pods and nodes.

#### Sub-Component [securityScanning](#monitoring_securityScanning)

The included [trivy](https://aquasecurity.github.io/trivy-operator) scans the
running workload in your cluster for CVEs and creates
[Custom Resources](https://aquasecurity.github.io/trivy-operator/v0.12.1/docs/crds)
to present the results.

#### Sub-Component [tracing](#monitoring_tracing)

The included [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/)
collects traces via otlp-grpc on every node via the `open-telemetry-collector-opentelemetry-collector.monitoring` service.
These traces are then sent to [Grafana Tempo](https://grafana.com/oss/tempo/),
which is included as a datasource in Grafana by default.

##### Usage Example

In your deployment/statefulset/daemonset/... add the following config;

```yaml
spec:
  template:
    spec:
      containers:
        - env:
            - name: OTEL_HOST <- change this to your framework's environment variable
              value: open-telemetry-collector-opentelemetry-collector.monitoring
            - name: OTEL_PORT
              value: "4317"
```

The supported protocols are;

- jaeger
  - grpc: 14250
  - thrift_http: 14268
  - thrift_compact: 6831
- otlp
  - grpc: 4317
  - http: 4318
- zipkin: 9411

### Component [storage](#storage)

The included [NFS Ganesha server and external provisioner](https://github.com/kubernetes-sigs/nfs-ganesha-server-and-external-provisioner)
provides rudimentary support for RWM volumes if needed.

> ⚠️  This is _not_ highly available, and the software itself _does not_ support
it. You should only use this if there is no other choice and make sure you're
cloud provider knows about this, because a node rotation _will_ result in a
downtime for all attached applications!

### Component [rbac](#rbac)

This chart gives you the ability to create serviceAccounts, roles, roleBindings,
[namespaces](#miscellaneous) and KUBECONFIG files with a, hopefully easy to
understand, DSL.

After configuring your stuff you can fetch the KUBECONFIGs with the help of the
output of `helm -n flux-system get notes base-cluster`

### Miscellaneous

- You can create [`HelmRepositoy`s](#global); `.global.helmRepositories.<name>.url=<url>`
- You can create [cluster-wide certificates](#global_certificates); `.global.certificates.<name>.dnsNames=[<domain>]`
- You can create [namespaces](#global_namespaces); `.global.namespaces.<name>={}`
- You can create [cluster-wide imageCredentials](#global); `.global.imageCredentials.<name>.{host,username,password}`

## Source Code

* <https://github.com/teutonet/teutonet-helm-charts/tree/base-cluster-v9.0.0/charts/base-cluster>
* <https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/base-cluster>

## Requirements

Kubernetes: `>=1.27.0-0`

| Repository | Name | Version |
|------------|------|---------|
| oci://ghcr.io/teutonet/teutonet-helm-charts | common | 1.5.0 |

This helm chart requires [flux v2 to be installed](https://fluxcd.io/docs/installation),
see [bootstrap](#cluster-bootstrap)

The various components are automatically updated to the latest minor and patch version.

This excludes:

- descheduler, its version is bound to the k8s version and they have not released
  1.0.0

## Migration

### 0.x.x -> 1.0.0

- The field `.dns.email` moves to `.certManager.email`.
- The field `.dns.provider.cloudflare.email` is removed, as only `apiToken`s are
  supported anyways.

### 1.x.x -> 2.0.0

⚠️  Skip this migration!

- Flux is now a direct dependency
  - You should add the following labels to all resources of flux;
    - .metadata.labels["app.kubernetes.io/managed-by"]="Helm"
    - .metadata.annotations["meta.helm.sh/release-name"]="base-cluster"
    - .metadata.annotations["meta.helm.sh/release-namespace"]="flux-system"
  - If you have problems when applying / `helm upgrade`ing the new CRDs, like
    `cannot patch "alerts.notification.toolkit.fluxcd.io" with kind
     CustomResourceDefinition: CustomResourceDefinition.apiextensions.k8s.io
     "alerts.notification.toolkit.fluxcd.io" is invalid: status.storedVersions[1]:
     Invalid value: "v1beta2": must appear in spec.versions`, you can replace
     those CRDs. (kubectl replace --force -f -)
    - ⚠️ make sure to only replace CRDs you're not actively using!!, this is
      a destructive operation. If all your resources are in flux you can also
      try to turn off flux before the replacement and flux _should_ resync and
      reconcile all resources.
  - remove your manually managed flux resources

### 2.x.x -> 3.0.0

- Flux is removed as a direct dependency

  The flux chart is way too unstable, cannot be used for an installation, ...

We be sorry 😥

You're gonna have to install flux yourself again

### 3.x.x -> 4.0.0

The storageClasses are going to be removed from this chart, this is prepared by
leaving them in the cluster on upgrade.

The new [t8s-cluster](../t8s-cluster) is going to provide these, the enduser can
ignore this change.

### 4.x.x -> 5.0.0

The condition if velero gets deployed changed. Velero will not be deployed if you
have not configured its backupstoragelocation. This change is necessary, because
in the current version of velero this value is mandatory. Please move
your existing backupstoragelocation configuration to the base-cluster chart if you
haven't already.

### 5.x.x -> 6.0.0

The kyverno 2.x.x -> 3.x.x upgrade cannot be done without manual intervention, see
<https://artifacthub.io/packages/helm/kyverno/kyverno#option-1---uninstallation-and-reinstallation>

So you have to backup your resources and delete the kyverno HelmReleases before the
upgrade, they will be recreated in version 6.

This also makes kyverno HA, so be aware that kyverno will need more resources in
you cluster.

### 6.x.x -> 7.0.0

This release allows the user to use the predefined k8s ClusterRoles
(`admin`, `edit`, `view`, ...).

This usage might clash with custom roles named `admin`, `edit`, `view`, ... and
therefore needs to be adjusted

### 7.x.x -> 8.0.0

This release migrates the now unsupported `loki-stack` to the normal `loki` helm
chart.

This is a breaking change because, apart from a new storage engine, the deployment
also moves from the `loki` namespace to `monitoring` to keep in line with every
other monitoring deployment, which in turn also deletes the `loki` namespace

This also replaces `promtail` and the `otel-collector` with `alloy`, using
<https://github.com/teutonet/teutonet-helm-charts/blob/main/charts/common/templates/_telemetry.tpl>
makes this a drop-in change.

---

This release adds another option for ingress, [traefik](https://traefik.io)! 🎉

If you have disabled ingress in your configuration, you need to update your
values from:

```yaml
ingress:
  enabled: false
```

to:

```yaml
ingress:
  provider: none
```

If you are using ingress (the default), you need to either switch over to traefik
or adjust your config to use nginx.
But we do recommend using traefik, especially in light of <https://github.com/kubernetes/ingress-nginx/issues/13002>.

To switch to traefik you don't need to do anything.

This will delete the old service which in turn will get you a new IP.
The `ingress-nginx` namespace will be deleted, so make sure you don't have any other
stuff deployed there or adjust its [condition](https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/base-cluster/#11412--property-base-cluster-configuration--global--namespaces--additionalproperties--condition)

Using a [DNS Provider](#component-dns) will automatically update your DNS records.

If you want to keep the same IP, do
<https://github.com/teutonet/teutonet-helm-charts/tree/main/charts/base-cluster/#ip-address>
beforehand.

The switch will still create downtime, so be aware of that.

In nginx it was possible to enable `allowNginxConfigurationSnippets` to add custom
configuration to the nginx ingress controller.
In traefik this is not possible, but you can use [gateway api](https://gateway-api.sigs.k8s.io)
instead, making this agnostic.

If you want to keep nginx, you need to configure the following;

```yaml
ingress:
  provider: nginx
```

# base cluster configuration

**Title:** base cluster configuration

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                         | Pattern | Type        | Deprecated | Definition | Title/Description    |
| -------------------------------- | ------- | ----------- | ---------- | ---------- | -------------------- |
| - [global](#global )             | No      | object      | No         | -          | -                    |
| - [kyverno](#kyverno )           | No      | object      | No         | -          | -                    |
| - [tetragon](#tetragon )         | No      | object      | No         | -          | -                    |
| - [monitoring](#monitoring )     | No      | object      | No         | -          | -                    |
| - [descheduler](#descheduler )   | No      | object      | No         | -          | -                    |
| - [dns](#dns )                   | No      | object      | No         | -          | -                    |
| - [certManager](#certManager )   | No      | object      | No         | -          | -                    |
| - [externalDNS](#externalDNS )   | No      | object      | No         | -          | -                    |
| - [flux](#flux )                 | No      | object      | No         | -          | -                    |
| - [ingress](#ingress )           | No      | object      | No         | -          | -                    |
| - [storage](#storage )           | No      | object      | No         | -          | -                    |
| - [reflector](#reflector )       | No      | object      | No         | -          | -                    |
| - [rbac](#rbac )                 | No      | object      | No         | -          | -                    |
| - [backup](#backup )             | No      | Combination | No         | -          | -                    |
| - [kube-janitor](#kube-janitor ) | No      | object      | No         | -          | -                    |
| - [common](#common )             | No      | object      | No         | -          | Values for sub-chart |

## <a name="global"></a>1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                  | Pattern | Type             | Deprecated | Definition              | Title/Description                                                                                                                                                                             |
| --------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [serviceLevelAgreement](#global_serviceLevelAgreement ) | No      | enum (of string) | No         | -                       | The ServiceLevelAgreement with teutonet, will be applied to all alerts as label \`teutosla\`                                                                                                  |
| - [clusterName](#global_clusterName )                     | No      | string           | No         | -                       | The name of the cluster, used as subdomain under \`baseDomain\` and as label \`cluster\` on all alerts                                                                                        |
| - [baseDomain](#global_baseDomain )                       | No      | string           | No         | -                       | The base domain to be used for cluster ingress                                                                                                                                                |
| - [imageRegistry](#global_imageRegistry )                 | No      | string           | No         | -                       | The global container image proxy, e.g. [Nexus](https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager), this needs to support various registries                              |
| - [imageCredentials](#global_imageCredentials )           | No      | object           | No         | -                       | A map of credentials to be created and synced into namespaces, the key is the secret name                                                                                                     |
| - [kubectl](#global_kubectl )                             | No      | object           | No         | -                       | Image with \`kubectl\` binary                                                                                                                                                                 |
| - [curl](#global_curl )                                   | No      | object           | No         | -                       | Image with \`curl\` binary                                                                                                                                                                    |
| - [flux](#global_flux )                                   | No      | object           | No         | -                       | Image with \`flux\` binary                                                                                                                                                                    |
| - [gpg](#global_gpg )                                     | No      | object           | No         | -                       | Image with \`gpg\` binary                                                                                                                                                                     |
| - [networkPolicy](#global_networkPolicy )                 | No      | object           | No         | -                       | -                                                                                                                                                                                             |
| - [helmRepositories](#global_helmRepositories )           | No      | object           | No         | -                       | A map of helmRepositories to create, the key is the name                                                                                                                                      |
| - [certificates](#global_certificates )                   | No      | object           | No         | -                       | A map of cert-manager certificates to create and sync its secrets into namespaces, the key is the name, therefore the secret name will be \`$key\`-certificate                                |
| - [storageClass](#global_storageClass )                   | No      | string           | No         | In #/$defs/storageClass | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)                                                                              |
| - [namespaces](#global_namespaces )                       | No      | object           | No         | -                       | Namespaces to create. AND *delete* if removed. These will also be the only ones, including the builtin namespaces, for which alerts will be sent if \`monitoring.monitorAllNamespaces=false\` |
| - [priorityClasses](#global_priorityClasses )             | No      | object           | No         | -                       | -                                                                                                                                                                                             |
| - [authentication](#global_authentication )               | No      | object           | No         | -                       | -                                                                                                                                                                                             |

### <a name="global_serviceLevelAgreement"></a>1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > serviceLevelAgreement`

|             |                    |
| ----------- | ------------------ |
| **Type**    | `enum (of string)` |
| **Default** | `"None"`           |

**Description:** The ServiceLevelAgreement with teutonet, will be applied to all alerts as label `teutosla`

Must be one of:
* "None"
* "24x7"
* "WorkingHours"

### <a name="global_clusterName"></a>1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > clusterName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The name of the cluster, used as subdomain under `baseDomain` and as label `cluster` on all alerts

**Example:**

```yaml
eu-2
```

### <a name="global_baseDomain"></a>1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > baseDomain`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The base domain to be used for cluster ingress

**Example:**

```yaml
teuto.net
```

### <a name="global_imageRegistry"></a>1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > imageRegistry`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The global container image proxy, e.g. [Nexus](https://artifacthub.io/packages/helm/sonatype/nexus-repository-manager), this needs to support various registries

**Example:**

```yaml
nexus.teuto.net
```

### <a name="global_imageCredentials"></a>1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > imageCredentials`

|                           |                                                                                                                      |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_imageCredentials_additionalProperties) |

**Description:** A map of credentials to be created and synced into namespaces, the key is the secret name

| Property                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_imageCredentials_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_imageCredentials_additionalProperties"></a>1.5.1. Property `base cluster configuration > global > imageCredentials > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

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

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Default**               | `"ALL"`                                                                     |
| **Defined in**            | #/$defs/targetNamespaces                                                    |

**Description:** The namespaces to sync the secret into, or `ALL` for all namespaces

| One of(Option)                                                                    |
| --------------------------------------------------------------------------------- |
| [item 0](#global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i0) |
| [item 1](#global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i1) |

###### <a name="global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i0"></a>1.5.1.4.1. Property `base cluster configuration > global > imageCredentials > additionalProperties > targetNamespaces > oneOf > item 0`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `"ALL"`

###### <a name="global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i1"></a>1.5.1.4.2. Property `base cluster configuration > global > imageCredentials > additionalProperties > targetNamespaces > oneOf > item 1`

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

###### <a name="global_imageCredentials_additionalProperties_targetNamespaces_oneOf_i1_items"></a>1.5.1.4.2.1. base cluster configuration > global > imageCredentials > additionalProperties > targetNamespaces > oneOf > item 1 > item 1 items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_kubectl"></a>1.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Image with `kubectl` binary

| Property                          | Pattern | Type   | Deprecated | Definition       | Title/Description |
| --------------------------------- | ------- | ------ | ---------- | ---------------- | ----------------- |
| - [image](#global_kubectl_image ) | No      | object | No         | In #/$defs/image | -                 |

#### <a name="global_kubectl_image"></a>1.6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > kubectl > image`

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

### <a name="global_curl"></a>1.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > curl`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Image with `curl` binary

| Property                       | Pattern | Type   | Deprecated | Definition                              | Title/Description |
| ------------------------------ | ------- | ------ | ---------- | --------------------------------------- | ----------------- |
| - [image](#global_curl_image ) | No      | object | No         | Same as [image](#global_kubectl_image ) | -                 |

#### <a name="global_curl_image"></a>1.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > curl > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Same definition as**    | [image](#global_kubectl_image)                                 |

### <a name="global_flux"></a>1.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > flux`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Image with `flux` binary

| Property                       | Pattern | Type   | Deprecated | Definition                              | Title/Description |
| ------------------------------ | ------- | ------ | ---------- | --------------------------------------- | ----------------- |
| - [image](#global_flux_image ) | No      | object | No         | Same as [image](#global_kubectl_image ) | -                 |

#### <a name="global_flux_image"></a>1.8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > flux > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Same definition as**    | [image](#global_kubectl_image)                                 |

### <a name="global_gpg"></a>1.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > gpg`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Image with `gpg` binary

| Property                      | Pattern | Type   | Deprecated | Definition                              | Title/Description |
| ----------------------------- | ------- | ------ | ---------- | --------------------------------------- | ----------------- |
| - [image](#global_gpg_image ) | No      | object | No         | Same as [image](#global_kubectl_image ) | -                 |

#### <a name="global_gpg_image"></a>1.9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > gpg > image`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Same definition as**    | [image](#global_kubectl_image)                                 |

### <a name="global_networkPolicy"></a>1.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                | Pattern | Type             | Deprecated | Definition | Title/Description                                                                                             |
| ------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------- |
| - [type](#global_networkPolicy_type )                   | No      | enum (of string) | No         | -          | Which networkPolicy to create, \`auto\` tries to detect the deployed framework, checking first for \`cilium\` |
| - [metricsLabels](#global_networkPolicy_metricsLabels ) | No      | Combination      | No         | -          | The labels used to allow ingress from the metrics service                                                     |
| - [dnsLabels](#global_networkPolicy_dnsLabels )         | No      | Combination      | No         | -          | The labels used to allow egress to the DNS service                                                            |
| - [ingressLabels](#global_networkPolicy_ingressLabels ) | No      | Combination      | No         | -          | The labels used to allow ingress from the ingress controller                                                  |

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

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** The labels used to allow ingress from the metrics service

| One of(Option)                                         |
| ------------------------------------------------------ |
| [item 0](#global_networkPolicy_metricsLabels_oneOf_i0) |
| [item 1](#global_networkPolicy_metricsLabels_oneOf_i1) |

##### <a name="global_networkPolicy_metricsLabels_oneOf_i0"></a>1.10.2.1. Property `base cluster configuration > global > networkPolicy > metricsLabels > oneOf > item 0`

|                           |                                                                                                                                          |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                 |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_networkPolicy_metricsLabels_oneOf_i0_additionalProperties) |

| Property                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_networkPolicy_metricsLabels_oneOf_i0_additionalProperties ) | No      | string | No         | -          | -                 |

###### <a name="global_networkPolicy_metricsLabels_oneOf_i0_additionalProperties"></a>1.10.2.1.1. Property `base cluster configuration > global > networkPolicy > metricsLabels > oneOf > item 0 > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_networkPolicy_metricsLabels_oneOf_i1"></a>1.10.2.2. Property `base cluster configuration > global > networkPolicy > metricsLabels > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="global_networkPolicy_dnsLabels"></a>1.10.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy > dnsLabels`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** The labels used to allow egress to the DNS service

| One of(Option)                                     |
| -------------------------------------------------- |
| [item 0](#global_networkPolicy_dnsLabels_oneOf_i0) |
| [item 1](#global_networkPolicy_dnsLabels_oneOf_i1) |

##### <a name="global_networkPolicy_dnsLabels_oneOf_i0"></a>1.10.3.1. Property `base cluster configuration > global > networkPolicy > dnsLabels > oneOf > item 0`

|                           |                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_networkPolicy_dnsLabels_oneOf_i0_additionalProperties) |

| Property                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_networkPolicy_dnsLabels_oneOf_i0_additionalProperties ) | No      | string | No         | -          | -                 |

###### <a name="global_networkPolicy_dnsLabels_oneOf_i0_additionalProperties"></a>1.10.3.1.1. Property `base cluster configuration > global > networkPolicy > dnsLabels > oneOf > item 0 > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_networkPolicy_dnsLabels_oneOf_i1"></a>1.10.3.2. Property `base cluster configuration > global > networkPolicy > dnsLabels > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="global_networkPolicy_ingressLabels"></a>1.10.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > networkPolicy > ingressLabels`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** The labels used to allow ingress from the ingress controller

| One of(Option)                                         |
| ------------------------------------------------------ |
| [item 0](#global_networkPolicy_ingressLabels_oneOf_i0) |
| [item 1](#global_networkPolicy_ingressLabels_oneOf_i1) |

##### <a name="global_networkPolicy_ingressLabels_oneOf_i0"></a>1.10.4.1. Property `base cluster configuration > global > networkPolicy > ingressLabels > oneOf > item 0`

|                           |                                                                                                                                          |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                 |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_networkPolicy_ingressLabels_oneOf_i0_additionalProperties) |

| Property                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_networkPolicy_ingressLabels_oneOf_i0_additionalProperties ) | No      | string | No         | -          | -                 |

###### <a name="global_networkPolicy_ingressLabels_oneOf_i0_additionalProperties"></a>1.10.4.1.1. Property `base cluster configuration > global > networkPolicy > ingressLabels > oneOf > item 0 > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_networkPolicy_ingressLabels_oneOf_i1"></a>1.10.4.2. Property `base cluster configuration > global > networkPolicy > ingressLabels > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="global_helmRepositories"></a>1.11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories`

|                           |                                                                                                                      |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_helmRepositories_additionalProperties) |

**Description:** A map of helmRepositories to create, the key is the name

| Property                                             | Pattern | Type        | Deprecated | Definition | Title/Description |
| ---------------------------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [](#global_helmRepositories_additionalProperties ) | No      | Combination | No         | -          | -                 |

#### <a name="global_helmRepositories_additionalProperties"></a>1.11.1. Property `base cluster configuration > global > helmRepositories > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `combining`                                                    |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                | Pattern | Type             | Deprecated | Definition           | Title/Description                                                                                            |
| ----------------------------------------------------------------------- | ------- | ---------------- | ---------- | -------------------- | ------------------------------------------------------------------------------------------------------------ |
| + [url](#global_helmRepositories_additionalProperties_url )             | No      | string           | No         | -                    | -                                                                                                            |
| - [interval](#global_helmRepositories_additionalProperties_interval )   | No      | string           | No         | -                    | The interval in which to update the repository                                                               |
| - [condition](#global_helmRepositories_additionalProperties_condition ) | No      | string           | No         | In #/$defs/condition | A condition with which to decide to include the resource. This will be templated. Must return a truthy value |
| - [charts](#global_helmRepositories_additionalProperties_charts )       | No      | object           | No         | -                    | Which charts are deployed in which version using this repo, used internally                                  |
| - [type](#global_helmRepositories_additionalProperties_type )           | No      | enum (of string) | No         | -                    | -                                                                                                            |

| One of(Option)                                                   |
| ---------------------------------------------------------------- |
| [item 0](#global_helmRepositories_additionalProperties_oneOf_i0) |
| [item 1](#global_helmRepositories_additionalProperties_oneOf_i1) |

##### <a name="global_helmRepositories_additionalProperties_oneOf_i0"></a>1.11.1.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [url](#global_helmRepositories_additionalProperties_oneOf_i0_url )       | No      | string | No         | -          | -                 |
| - [charts](#global_helmRepositories_additionalProperties_oneOf_i0_charts ) | No      | object | No         | -          | -                 |

| One of(Option)                                                            |
| ------------------------------------------------------------------------- |
| [item 0](#global_helmRepositories_additionalProperties_oneOf_i0_oneOf_i0) |
| [item 1](#global_helmRepositories_additionalProperties_oneOf_i0_oneOf_i1) |

###### <a name="global_helmRepositories_additionalProperties_oneOf_i0_oneOf_i0"></a>1.11.1.1.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 0 > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_2"></a>1.11.1.1.1.1. Must **not** be

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_3"></a>1.11.1.1.1.1.1. The following properties are required
* type

###### <a name="global_helmRepositories_additionalProperties_oneOf_i0_oneOf_i1"></a>1.11.1.1.2. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 0 > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                                        | Pattern | Type  | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------- | ------- | ----- | ---------- | ---------- | ----------------- |
| + [type](#global_helmRepositories_additionalProperties_oneOf_i0_oneOf_i1_type ) | No      | const | No         | -          | -                 |

###### <a name="global_helmRepositories_additionalProperties_oneOf_i0_oneOf_i1_type"></a>1.11.1.1.2.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 0 > oneOf > item 1 > type`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `"helm"`

###### <a name="global_helmRepositories_additionalProperties_oneOf_i0_url"></a>1.11.1.1.3. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 0 > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                            |
| --------------------------------- | ------------------------------------------------------------------------------------------ |
| **Must match regular expression** | ```(https\|oci)://.+``` [Test](https://regex101.com/?regex=%28https%7Coci%29%3A%2F%2F.%2B) |

###### <a name="global_helmRepositories_additionalProperties_oneOf_i0_charts"></a>1.11.1.1.4. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 0 > charts`

|                           |                                                                                                                                                           |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                  |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_helmRepositories_additionalProperties_oneOf_i0_charts_additionalProperties) |

| Property                                                                                  | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_helmRepositories_additionalProperties_oneOf_i0_charts_additionalProperties ) | No      | string | No         | -          | -                 |

###### <a name="global_helmRepositories_additionalProperties_oneOf_i0_charts_additionalProperties"></a>1.11.1.1.4.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 0 > charts > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_helmRepositories_additionalProperties_oneOf_i1"></a>1.11.1.2. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                               | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [url](#global_helmRepositories_additionalProperties_oneOf_i1_url )   | No      | string | No         | -          | -                 |
| + [type](#global_helmRepositories_additionalProperties_oneOf_i1_type ) | No      | const  | No         | -          | -                 |

###### <a name="autogenerated_heading_4"></a>1.11.1.2.1. Must **not** be

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_5"></a>1.11.1.2.1.1. The following properties are required
* interval

###### <a name="autogenerated_heading_6"></a>1.11.1.2.2. The following properties are required
* charts

###### <a name="global_helmRepositories_additionalProperties_oneOf_i1_url"></a>1.11.1.2.3. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 1 > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                         |
| --------------------------------- | ----------------------------------------------------------------------- |
| **Must match regular expression** | ```https://.+``` [Test](https://regex101.com/?regex=https%3A%2F%2F.%2B) |

###### <a name="global_helmRepositories_additionalProperties_oneOf_i1_type"></a>1.11.1.2.4. Property `base cluster configuration > global > helmRepositories > additionalProperties > oneOf > item 1 > type`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `"git"`

##### <a name="global_helmRepositories_additionalProperties_url"></a>1.11.1.3. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > helmRepositories > additionalProperties > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                            |
| --------------------------------- | ------------------------------------------------------------------------------------------ |
| **Must match regular expression** | ```(https\|oci)://.+``` [Test](https://regex101.com/?regex=%28https%7Coci%29%3A%2F%2F.%2B) |

##### <a name="global_helmRepositories_additionalProperties_interval"></a>1.11.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties > interval`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The interval in which to update the repository

| Restrictions                      |                                                                             |
| --------------------------------- | --------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+[mhd]``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%5Bmhd%5D) |

##### <a name="global_helmRepositories_additionalProperties_condition"></a>1.11.1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties > condition`

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

##### <a name="global_helmRepositories_additionalProperties_charts"></a>1.11.1.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties > charts`

|                           |                                                                                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                                         |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_helmRepositories_additionalProperties_charts_additionalProperties) |

**Description:** Which charts are deployed in which version using this repo, used internally

| Property                                                                         | Pattern | Type        | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [](#global_helmRepositories_additionalProperties_charts_additionalProperties ) | No      | Combination | No         | -          | -                 |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties"></a>1.11.1.6.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                                                                               |
| -------------------------------------------------------------------------------------------- |
| [item 0](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i0) |
| [item 1](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1) |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i0"></a>1.11.1.6.1.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1"></a>1.11.1.6.1.2. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `combining`                                                    |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                                   | Pattern | Type   | Deprecated | Definition | Title/Description                              |
| ---------------------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ---------------------------------------------- |
| - [branch](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_branch )     | No      | string | No         | -          | -                                              |
| - [commit](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_commit )     | No      | string | No         | -          | -                                              |
| - [semver](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_semver )     | No      | string | No         | -          | -                                              |
| - [tag](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_tag )           | No      | string | No         | -          | -                                              |
| - [path](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_path )         | No      | string | No         | -          | Path of the chart in the repository            |
| - [interval](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_interval ) | No      | string | No         | -          | The interval in which to update the repository |

| One of(Option)                                                                                        |
| ----------------------------------------------------------------------------------------------------- |
| [item 0](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i0) |
| [item 1](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i1) |
| [item 2](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i2) |
| [item 3](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i3) |
| [item 4](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4) |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i0"></a>1.11.1.6.1.2.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_7"></a>1.11.1.6.1.2.1.1. The following properties are required
* branch

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i1"></a>1.11.1.6.1.2.2. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_8"></a>1.11.1.6.1.2.2.1. The following properties are required
* commit

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i2"></a>1.11.1.6.1.2.3. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 2`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_9"></a>1.11.1.6.1.2.3.1. The following properties are required
* semver

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i3"></a>1.11.1.6.1.2.4. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 3`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_10"></a>1.11.1.6.1.2.4.1. The following properties are required
* tag

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4"></a>1.11.1.6.1.2.5. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 4`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_11"></a>1.11.1.6.1.2.5.1. Must **not** be

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Any of(Option)                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------ |
| [item 0](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i0) |
| [item 1](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i1) |
| [item 2](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i2) |
| [item 3](#global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i3) |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i0"></a>1.11.1.6.1.2.5.1.1. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 4 > not > anyOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_12"></a>1.11.1.6.1.2.5.1.1.1. The following properties are required
* branch

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i1"></a>1.11.1.6.1.2.5.1.2. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 4 > not > anyOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_13"></a>1.11.1.6.1.2.5.1.2.1. The following properties are required
* commit

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i2"></a>1.11.1.6.1.2.5.1.3. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 4 > not > anyOf > item 2`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_14"></a>1.11.1.6.1.2.5.1.3.1. The following properties are required
* semver

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_oneOf_i4_not_anyOf_i3"></a>1.11.1.6.1.2.5.1.4. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > oneOf > item 4 > not > anyOf > item 3`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_15"></a>1.11.1.6.1.2.5.1.4.1. The following properties are required
* tag

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_branch"></a>1.11.1.6.1.2.6. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > branch`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_commit"></a>1.11.1.6.1.2.7. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > commit`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_semver"></a>1.11.1.6.1.2.8. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > semver`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_tag"></a>1.11.1.6.1.2.9. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_path"></a>1.11.1.6.1.2.10. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > path`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Path of the chart in the repository

###### <a name="global_helmRepositories_additionalProperties_charts_additionalProperties_oneOf_i1_interval"></a>1.11.1.6.1.2.11. Property `base cluster configuration > global > helmRepositories > additionalProperties > charts > additionalProperties > oneOf > item 1 > interval`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The interval in which to update the repository

| Restrictions                      |                                                                             |
| --------------------------------- | --------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+[mhd]``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%5Bmhd%5D) |

##### <a name="global_helmRepositories_additionalProperties_type"></a>1.11.1.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > helmRepositories > additionalProperties > type`

|             |                    |
| ----------- | ------------------ |
| **Type**    | `enum (of string)` |
| **Default** | `"helm"`           |

Must be one of:
* "git"
* "helm"

### <a name="global_certificates"></a>1.12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > certificates`

|                           |                                                                                                                  |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                         |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_certificates_additionalProperties) |

**Description:** A map of cert-manager certificates to create and sync its secrets into namespaces, the key is the name, therefore the secret name will be `$key`-certificate

| Property                                         | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_certificates_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_certificates_additionalProperties"></a>1.12.1. Property `base cluster configuration > global > certificates > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                          | Pattern | Type        | Deprecated | Definition                                                                                  | Title/Description                                                                                            |
| --------------------------------------------------------------------------------- | ------- | ----------- | ---------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| + [dnsNames](#global_certificates_additionalProperties_dnsNames )                 | No      | Combination | No         | -                                                                                           | The dnsNames to create                                                                                       |
| - [targetNamespaces](#global_certificates_additionalProperties_targetNamespaces ) | No      | object      | No         | Same as [targetNamespaces](#global_imageCredentials_additionalProperties_targetNamespaces ) | The namespaces to sync the secret into, or \`ALL\` for all namespaces                                        |
| - [condition](#global_certificates_additionalProperties_condition )               | No      | string      | No         | Same as [condition](#global_helmRepositories_additionalProperties_condition )               | A condition with which to decide to include the resource. This will be templated. Must return a truthy value |

##### <a name="global_certificates_additionalProperties_dnsNames"></a>1.12.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > certificates > additionalProperties > dnsNames`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

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

###### <a name="global_certificates_additionalProperties_dnsNames_oneOf_i0"></a>1.12.1.1.1. Property `base cluster configuration > global > certificates > additionalProperties > dnsNames > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** This will be templated

###### <a name="global_certificates_additionalProperties_dnsNames_oneOf_i1"></a>1.12.1.1.2. Property `base cluster configuration > global > certificates > additionalProperties > dnsNames > oneOf > item 1`

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

###### <a name="global_certificates_additionalProperties_dnsNames_oneOf_i1_items"></a>1.12.1.1.2.1. base cluster configuration > global > certificates > additionalProperties > dnsNames > oneOf > item 1 > item 1 items

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_certificates_additionalProperties_targetNamespaces"></a>1.12.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > certificates > additionalProperties > targetNamespaces`

|                           |                                                                                    |
| ------------------------- | ---------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                        |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)        |
| **Default**               | `"ALL"`                                                                            |
| **Same definition as**    | [targetNamespaces](#global_imageCredentials_additionalProperties_targetNamespaces) |

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
| **Type**       | `string`             |
| **Defined in** | #/$defs/storageClass |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

### <a name="global_namespaces"></a>1.14. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces`

|                           |                                                                                                                |
| ------------------------- | -------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                       |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_namespaces_additionalProperties) |

**Description:** Namespaces to create. AND *delete* if removed. These will also be the only ones, including the builtin namespaces, for which alerts will be sent if `monitoring.monitorAllNamespaces=false`

| Property                                       | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_namespaces_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_namespaces_additionalProperties"></a>1.14.1. Property `base cluster configuration > global > namespaces > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                        | Pattern | Type   | Deprecated | Definition                                                                    | Title/Description                                                                                            |
| ------------------------------------------------------------------------------- | ------- | ------ | ---------- | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| - [additionalLabels](#global_namespaces_additionalProperties_additionalLabels ) | No      | object | No         | -                                                                             | -                                                                                                            |
| - [condition](#global_namespaces_additionalProperties_condition )               | No      | string | No         | Same as [condition](#global_helmRepositories_additionalProperties_condition ) | A condition with which to decide to include the resource. This will be templated. Must return a truthy value |
| - [resources](#global_namespaces_additionalProperties_resources )               | No      | object | No         | -                                                                             | -                                                                                                            |

##### <a name="global_namespaces_additionalProperties_additionalLabels"></a>1.14.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > additionalLabels`

|                           |                                                                                                                                                      |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_namespaces_additionalProperties_additionalLabels_additionalProperties) |

| Property                                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_namespaces_additionalProperties_additionalLabels_additionalProperties ) | No      | string | No         | -          | -                 |

###### <a name="global_namespaces_additionalProperties_additionalLabels_additionalProperties"></a>1.14.1.1.1. Property `base cluster configuration > global > namespaces > additionalProperties > additionalLabels > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_namespaces_additionalProperties_condition"></a>1.14.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > condition`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `string`                                                             |
| **Same definition as** | [condition](#global_helmRepositories_additionalProperties_condition) |

**Description:** A condition with which to decide to include the resource. This will be templated. Must return a truthy value

##### <a name="global_namespaces_additionalProperties_resources"></a>1.14.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > resources`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                  | Pattern | Type   | Deprecated | Definition | Title/Description                                               |
| ------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | --------------------------------------------------------------- |
| - [defaults](#global_namespaces_additionalProperties_resources_defaults ) | No      | object | No         | -          | -                                                               |
| - [quotas](#global_namespaces_additionalProperties_resources_quotas )     | No      | object | No         | -          | See https://kubernetes.io/docs/concepts/policy/resource-quotas/ |

###### <a name="global_namespaces_additionalProperties_resources_defaults"></a>1.14.1.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > resources > defaults`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                           | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [requests](#global_namespaces_additionalProperties_resources_defaults_requests ) | No      | object | No         | -          | -                 |
| - [limits](#global_namespaces_additionalProperties_resources_defaults_limits )     | No      | object | No         | -          | -                 |

###### <a name="global_namespaces_additionalProperties_resources_defaults_requests"></a>1.14.1.3.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > resources > defaults > requests`

|                           |                                                                                                                                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                        |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

| Property                                                                                        | Pattern | Type   | Deprecated | Definition          | Title/Description |
| ----------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ------------------- | ----------------- |
| - [](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | No      | object | No         | In #/$defs/quantity | -                 |

###### <a name="global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties"></a>1.14.1.3.1.1.1. Property `base cluster configuration > global > namespaces > additionalProperties > resources > defaults > requests > quantity`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/$defs/quantity                                                            |

| One of(Option)                                                                                              |
| ----------------------------------------------------------------------------------------------------------- |
| [item 0](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties_oneOf_i0) |
| [item 1](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties_oneOf_i1) |

###### <a name="global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties_oneOf_i0"></a>1.14.1.3.1.1.1.1. Property `base cluster configuration > global > namespaces > additionalProperties > resources > defaults > requests > additionalProperties > oneOf > item 0`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties_oneOf_i1"></a>1.14.1.3.1.1.1.2. Property `base cluster configuration > global > namespaces > additionalProperties > resources > defaults > requests > additionalProperties > oneOf > item 1`

|          |          |
| -------- | -------- |
| **Type** | `number` |

###### <a name="global_namespaces_additionalProperties_resources_defaults_limits"></a>1.14.1.3.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > resources > defaults > limits`

|                           |                                                                                                                                                               |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                      |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_namespaces_additionalProperties_resources_defaults_limits_additionalProperties) |

| Property                                                                                      | Pattern | Type   | Deprecated | Definition                                                                                                                                         | Title/Description |
| --------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| - [](#global_namespaces_additionalProperties_resources_defaults_limits_additionalProperties ) | No      | object | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                 |

###### <a name="global_namespaces_additionalProperties_resources_defaults_limits_additionalProperties"></a>1.14.1.3.1.2.1. Property `base cluster configuration > global > namespaces > additionalProperties > resources > defaults > limits > quantity`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

###### <a name="global_namespaces_additionalProperties_resources_quotas"></a>1.14.1.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > namespaces > additionalProperties > resources > quotas`

|                           |                                                                                                                                                      |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_namespaces_additionalProperties_resources_quotas_additionalProperties) |

**Description:** See https://kubernetes.io/docs/concepts/policy/resource-quotas/

| Property                                                                             | Pattern | Type   | Deprecated | Definition                                                                                                                                         | Title/Description |
| ------------------------------------------------------------------------------------ | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| - [](#global_namespaces_additionalProperties_resources_quotas_additionalProperties ) | No      | object | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                 |

###### <a name="global_namespaces_additionalProperties_resources_quotas_additionalProperties"></a>1.14.1.3.2.1. Property `base cluster configuration > global > namespaces > additionalProperties > resources > quotas > quantity`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

### <a name="global_priorityClasses"></a>1.15. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > priorityClasses`

|                           |                                                                                                                     |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                            |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_priorityClasses_additionalProperties) |

| Property                                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#global_priorityClasses_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="global_priorityClasses_additionalProperties"></a>1.15.1. Property `base cluster configuration > global > priorityClasses > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                             | Pattern | Type             | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------------ | ------- | ---------------- | ---------- | ---------- | ----------------- |
| + [value](#global_priorityClasses_additionalProperties_value )                       | No      | integer          | No         | -          | -                 |
| - [description](#global_priorityClasses_additionalProperties_description )           | No      | string           | No         | -          | -                 |
| - [preemptionPolicy](#global_priorityClasses_additionalProperties_preemptionPolicy ) | No      | enum (of string) | No         | -          | -                 |

##### <a name="global_priorityClasses_additionalProperties_value"></a>1.15.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > priorityClasses > additionalProperties > value`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |                  |
| ------------ | ---------------- |
| **Minimum**  | &ge; -2147483648 |
| **Maximum**  | &le; 1000000000  |

##### <a name="global_priorityClasses_additionalProperties_description"></a>1.15.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > priorityClasses > additionalProperties > description`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_priorityClasses_additionalProperties_preemptionPolicy"></a>1.15.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > priorityClasses > additionalProperties > preemptionPolicy`

|             |                          |
| ----------- | ------------------------ |
| **Type**    | `enum (of string)`       |
| **Default** | `"PreemptLowerPriority"` |

Must be one of:
* "PreemptLowerPriority"
* "Never"

### <a name="global_authentication"></a>1.16. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                           | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                          |
| -------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| - [config](#global_authentication_config )         | No      | object | No         | -          | -                                                                                                                                          |
| - [grafana](#global_authentication_grafana )       | No      | object | No         | -          | See https://grafana.com/docs/grafana/latest/setup-grafana/configure-security/configure-authentication/generic-oauth/#configuration-options |
| - [oauthProxy](#global_authentication_oauthProxy ) | No      | object | No         | -          | -                                                                                                                                          |

#### <a name="global_authentication_config"></a>1.16.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > config`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                      | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [clientId](#global_authentication_config_clientId )         | No      | string | No         | -          | -                 |
| + [clientSecret](#global_authentication_config_clientSecret ) | No      | string | No         | -          | -                 |
| + [issuerHost](#global_authentication_config_issuerHost )     | No      | string | No         | -          | -                 |
| - [issuerPath](#global_authentication_config_issuerPath )     | No      | string | No         | -          | -                 |

##### <a name="global_authentication_config_clientId"></a>1.16.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > authentication > config > clientId`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_authentication_config_clientSecret"></a>1.16.1.2. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > authentication > config > clientSecret`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_authentication_config_issuerHost"></a>1.16.1.3. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > global > authentication > config > issuerHost`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_authentication_config_issuerPath"></a>1.16.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > config > issuerPath`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="global_authentication_grafana"></a>1.16.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > grafana`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** See https://grafana.com/docs/grafana/latest/setup-grafana/configure-security/configure-authentication/generic-oauth/#configuration-options

| Property                                                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [roleAttributePath](#global_authentication_grafana_roleAttributePath )   | No      | string | No         | -          | -                 |
| - [authenticationPath](#global_authentication_grafana_authenticationPath ) | No      | string | No         | -          | -                 |
| - [apiPath](#global_authentication_grafana_apiPath )                       | No      | string | No         | -          | -                 |
| - [tokenPath](#global_authentication_grafana_tokenPath )                   | No      | string | No         | -          | -                 |

##### <a name="global_authentication_grafana_roleAttributePath"></a>1.16.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > grafana > roleAttributePath`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_authentication_grafana_authenticationPath"></a>1.16.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > grafana > authenticationPath`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_authentication_grafana_apiPath"></a>1.16.2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > grafana > apiPath`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="global_authentication_grafana_tokenPath"></a>1.16.2.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > grafana > tokenPath`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="global_authentication_oauthProxy"></a>1.16.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > oauthProxy`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                | Pattern | Type             | Deprecated | Definition                      | Title/Description                                                 |
| ----------------------------------------------------------------------- | ------- | ---------------- | ---------- | ------------------------------- | ----------------------------------------------------------------- |
| - [emailDomains](#global_authentication_oauthProxy_emailDomains )       | No      | array            | No         | -                               | -                                                                 |
| - [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | No      | enum (of string) | No         | In #/$defs/resourcesPreset      | -                                                                 |
| - [resources](#global_authentication_oauthProxy_resources )             | No      | object           | No         | In #/$defs/resourceRequirements | ResourceRequirements describes the compute resource requirements. |

##### <a name="global_authentication_oauthProxy_emailDomains"></a>1.16.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > oauthProxy > emailDomains`

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

##### <a name="global_authentication_oauthProxy_resourcesPreset"></a>1.16.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > oauthProxy > resourcesPreset`

|                |                         |
| -------------- | ----------------------- |
| **Type**       | `enum (of string)`      |
| **Defined in** | #/$defs/resourcesPreset |

Must be one of:
* "nano"
* "micro"
* "small"
* "medium"
* "large"
* "xlarge"
* "2xlarge"

##### <a name="global_authentication_oauthProxy_resources"></a>1.16.3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > oauthProxy > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/$defs/resourceRequirements                                                |

**Description:** ResourceRequirements describes the compute resource requirements.

| Property                                                            | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| - [claims](#global_authentication_oauthProxy_resources_claims )     | No      | array  | No         | -          | Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.<br /><br />This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.<br /><br />This field is immutable. It can only be set for containers.                                                           |
| - [limits](#global_authentication_oauthProxy_resources_limits )     | No      | object | No         | -          | Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/                                                                                                                                                                                |
| - [requests](#global_authentication_oauthProxy_resources_requests ) | No      | object | No         | -          | Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |

###### <a name="global_authentication_oauthProxy_resources_claims"></a>1.16.3.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > oauthProxy > resources > claims`

|          |         |
| -------- | ------- |
| **Type** | `array` |

**Description:** Claims lists the names of resources, defined in spec.resourceClaims, that are used by this container.

This is an alpha field and requires enabling the DynamicResourceAllocation feature gate.

This field is immutable. It can only be set for containers.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                              | Description                                                   |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| [io.k8s.api.core.v1.ResourceClaim](#global_authentication_oauthProxy_resources_claims_items) | ResourceClaim references one entry in PodSpec.ResourceClaims. |

###### <a name="global_authentication_oauthProxy_resources_claims_items"></a>1.16.3.3.1.1. base cluster configuration > global > authentication > oauthProxy > resources > claims > io.k8s.api.core.v1.ResourceClaim

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Defined in**            | #/definitions/io.k8s.api.core.v1.ResourceClaim                 |

**Description:** ResourceClaim references one entry in PodSpec.ResourceClaims.

| Property                                                                       | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                                                   |
| ------------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| + [name](#global_authentication_oauthProxy_resources_claims_items_name )       | No      | string | No         | -          | Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container.          |
| - [request](#global_authentication_oauthProxy_resources_claims_items_request ) | No      | string | No         | -          | Request is the name chosen for a request in the referenced claim. If empty, everything from the claim is made available, otherwise only the result of this request. |

###### <a name="global_authentication_oauthProxy_resources_claims_items_name"></a>1.16.3.3.1.1.1. Property `base cluster configuration > global > authentication > oauthProxy > resources > claims > claims items > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Name must match the name of one entry in pod.spec.resourceClaims of the Pod where this field is used. It makes that resource available inside a container.

###### <a name="global_authentication_oauthProxy_resources_claims_items_request"></a>1.16.3.3.1.1.2. Property `base cluster configuration > global > authentication > oauthProxy > resources > claims > claims items > request`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Request is the name chosen for a request in the referenced claim. If empty, everything from the claim is made available, otherwise only the result of this request.

###### <a name="global_authentication_oauthProxy_resources_limits"></a>1.16.3.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > oauthProxy > resources > limits`

|                           |                                                                                                                                                |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                       |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_authentication_oauthProxy_resources_limits_additionalProperties) |

**Description:** Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

| Property                                                                       | Pattern | Type   | Deprecated | Definition                                                                                                                                                                                   | Title/Description |
| ------------------------------------------------------------------------------ | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| - [](#global_authentication_oauthProxy_resources_limits_additionalProperties ) | No      | object | No         | Same as [global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                 |

###### <a name="global_authentication_oauthProxy_resources_limits_additionalProperties"></a>1.16.3.3.2.1. Property `base cluster configuration > global > authentication > oauthProxy > resources > limits > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                                                                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                                                                         |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                                                                         |
| **Same definition as**    | [global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

###### <a name="global_authentication_oauthProxy_resources_requests"></a>1.16.3.3.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > global > authentication > oauthProxy > resources > requests`

|                           |                                                                                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                                         |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#global_authentication_oauthProxy_resources_requests_additionalProperties) |

**Description:** Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. Requests cannot exceed Limits. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

| Property                                                                         | Pattern | Type   | Deprecated | Definition                                                                                                                                                                                   | Title/Description |
| -------------------------------------------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| - [](#global_authentication_oauthProxy_resources_requests_additionalProperties ) | No      | object | No         | Same as [global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                 |

###### <a name="global_authentication_oauthProxy_resources_requests_additionalProperties"></a>1.16.3.3.3.1. Property `base cluster configuration > global > authentication > oauthProxy > resources > requests > io.k8s.apimachinery.pkg.api.resource.Quantity`

|                           |                                                                                                                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                                                                                                                         |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                                                                         |
| **Same definition as**    | [global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

## <a name="kyverno"></a>2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kyverno`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

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

## <a name="tetragon"></a>3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > tetragon`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                        | Pattern | Type    | Deprecated | Definition | Title/Description |
| ------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#tetragon_enabled ) | No      | boolean | No         | -          | -                 |

### <a name="tetragon_enabled"></a>3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > tetragon > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

## <a name="monitoring"></a>4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                    | Pattern | Type    | Deprecated | Definition | Title/Description                                                                                                                 |
| ----------------------------------------------------------- | ------- | ------- | ---------- | ---------- | --------------------------------------------------------------------------------------------------------------------------------- |
| - [monitorAllNamespaces](#monitoring_monitorAllNamespaces ) | No      | boolean | No         | -          | -                                                                                                                                 |
| - [deadMansSwitch](#monitoring_deadMansSwitch )             | No      | object  | No         | -          | This needs \`.global.clusterName\` to be set up as an integration in healthchecks.io. Also, \`.global.baseDomain\` has to be set. |
| - [kdave](#monitoring_kdave )                               | No      | object  | No         | -          | -                                                                                                                                 |
| - [prometheus](#monitoring_prometheus )                     | No      | object  | No         | -          | -                                                                                                                                 |
| - [grafana](#monitoring_grafana )                           | No      | object  | No         | -          | -                                                                                                                                 |
| - [loki](#monitoring_loki )                                 | No      | object  | No         | -          | -                                                                                                                                 |
| - [metricsServer](#monitoring_metricsServer )               | No      | object  | No         | -          | -                                                                                                                                 |
| - [storageCostAnalysis](#monitoring_storageCostAnalysis )   | No      | object  | No         | -          | Configuration of the \`storageCostAnalysis dashboard                                                                              |
| - [securityScanning](#monitoring_securityScanning )         | No      | object  | No         | -          | -                                                                                                                                 |
| - [tracing](#monitoring_tracing )                           | No      | object  | No         | -          | -                                                                                                                                 |
| - [additionalProperties](#monitoring_additionalProperties ) | No      | object  | No         | -          | -                                                                                                                                 |

### <a name="monitoring_monitorAllNamespaces"></a>4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > monitorAllNamespaces`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="monitoring_deadMansSwitch"></a>4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > deadMansSwitch`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** This needs `.global.clusterName` to be set up as an integration in healthchecks.io. Also, `.global.baseDomain` has to be set.

| Property                                         | Pattern | Type    | Deprecated | Definition | Title/Description                        |
| ------------------------------------------------ | ------- | ------- | ---------- | ---------- | ---------------------------------------- |
| - [enabled](#monitoring_deadMansSwitch_enabled ) | No      | boolean | No         | -          | -                                        |
| - [apiKey](#monitoring_deadMansSwitch_apiKey )   | No      | string  | No         | -          | Used for registration and unregistration |
| - [pingKey](#monitoring_deadMansSwitch_pingKey ) | No      | string  | No         | -          | -                                        |

#### <a name="monitoring_deadMansSwitch_enabled"></a>4.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > deadMansSwitch > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="monitoring_deadMansSwitch_apiKey"></a>4.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > deadMansSwitch > apiKey`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Used for registration and unregistration

#### <a name="monitoring_deadMansSwitch_pingKey"></a>4.2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > deadMansSwitch > pingKey`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="monitoring_kdave"></a>4.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > kdave`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                | Pattern | Type    | Deprecated | Definition | Title/Description |
| --------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#monitoring_kdave_enabled ) | No      | boolean | No         | -          | -                 |

#### <a name="monitoring_kdave_enabled"></a>4.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > kdave > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="monitoring_prometheus"></a>4.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                         | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ---------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [enabled](#monitoring_prometheus_enabled )                     | No      | boolean          | No         | -                                                                             | -                                                                 |
| - [replicas](#monitoring_prometheus_replicas )                   | No      | integer          | No         | -                                                                             | -                                                                 |
| - [resourcesPreset](#monitoring_prometheus_resourcesPreset )     | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#monitoring_prometheus_resources )                 | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |
| - [retentionDuration](#monitoring_prometheus_retentionDuration ) | No      | string           | No         | -                                                                             | -                                                                 |
| - [retentionSize](#monitoring_prometheus_retentionSize )         | No      | string           | No         | -                                                                             | -                                                                 |
| - [persistence](#monitoring_prometheus_persistence )             | No      | object           | No         | -                                                                             | -                                                                 |
| - [operator](#monitoring_prometheus_operator )                   | No      | object           | No         | -                                                                             | -                                                                 |
| - [kubeStateMetrics](#monitoring_prometheus_kubeStateMetrics )   | No      | object           | No         | -                                                                             | -                                                                 |
| - [nodeExporter](#monitoring_prometheus_nodeExporter )           | No      | object           | No         | -                                                                             | -                                                                 |
| - [ingress](#monitoring_prometheus_ingress )                     | No      | object           | No         | In #/$defs/toolIngress                                                        | -                                                                 |
| - [alertmanager](#monitoring_prometheus_alertmanager )           | No      | object           | No         | -                                                                             | -                                                                 |

#### <a name="monitoring_prometheus_enabled"></a>4.4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="monitoring_prometheus_replicas"></a>4.4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

#### <a name="monitoring_prometheus_resourcesPreset"></a>4.4.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

#### <a name="monitoring_prometheus_resources"></a>4.4.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_prometheus_retentionDuration"></a>4.4.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > retentionDuration`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(ms\|s\|m\|h\|d\|w\|y)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28ms%7Cs%7Cm%7Ch%7Cd%7Cw%7Cy%29) |

#### <a name="monitoring_prometheus_retentionSize"></a>4.4.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > retentionSize`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                                                               |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(B\|KB\|MB\|GB\|TB\|PB\|EB)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28B%7CKB%7CMB%7CGB%7CTB%7CPB%7CEB%29) |

#### <a name="monitoring_prometheus_persistence"></a>4.4.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > persistence`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                           | Pattern | Type   | Deprecated | Definition                                                                                                                                         | Title/Description                                                                                                |
| ------------------------------------------------------------------ | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [storageClass](#monitoring_prometheus_persistence_storageClass ) | No      | string | No         | Same as [storageClass](#global_storageClass )                                                                                                      | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |
| - [size](#monitoring_prometheus_persistence_size )                 | No      | object | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                                                                                                                |

##### <a name="monitoring_prometheus_persistence_storageClass"></a>4.4.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string`                             |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

##### <a name="monitoring_prometheus_persistence_size"></a>4.4.7.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > persistence > size`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

#### <a name="monitoring_prometheus_operator"></a>4.4.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > operator`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                              | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| --------------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#monitoring_prometheus_operator_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#monitoring_prometheus_operator_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_prometheus_operator_resourcesPreset"></a>4.4.8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > operator > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

##### <a name="monitoring_prometheus_operator_resources"></a>4.4.8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > operator > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_prometheus_kubeStateMetrics"></a>4.4.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                  | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                         |
| ----------------------------------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| - [resourcesPreset](#monitoring_prometheus_kubeStateMetrics_resourcesPreset )             | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                         |
| - [resources](#monitoring_prometheus_kubeStateMetrics_resources )                         | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements.         |
| - [metricLabelsAllowList](#monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList ) | No      | object           | No         | -                                                                             | A map of resource/[label] that will be set as labels on the state metrics |

##### <a name="monitoring_prometheus_kubeStateMetrics_resourcesPreset"></a>4.4.9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

##### <a name="monitoring_prometheus_kubeStateMetrics_resources"></a>4.4.9.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

##### <a name="monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList"></a>4.4.9.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics > metricLabelsAllowList`

|                           |                                                                                                                                                           |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                  |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties) |

**Description:** A map of resource/[label] that will be set as labels on the state metrics

| Property                                                                                  | Pattern | Type            | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [](#monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties ) | No      | array of string | No         | -          | -                 |

###### <a name="monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties"></a>4.4.9.3.1. Property `base cluster configuration > monitoring > prometheus > kubeStateMetrics > metricLabelsAllowList > additionalProperties`

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

###### <a name="monitoring_prometheus_kubeStateMetrics_metricLabelsAllowList_additionalProperties_items"></a>4.4.9.3.1.1. base cluster configuration > monitoring > prometheus > kubeStateMetrics > metricLabelsAllowList > additionalProperties > additionalProperties items

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_prometheus_nodeExporter"></a>4.4.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > nodeExporter`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                  | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ------------------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#monitoring_prometheus_nodeExporter_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#monitoring_prometheus_nodeExporter_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_prometheus_nodeExporter_resourcesPreset"></a>4.4.10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > nodeExporter > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

##### <a name="monitoring_prometheus_nodeExporter_resources"></a>4.4.10.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > nodeExporter > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_prometheus_ingress"></a>4.4.11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Defined in**            | #/$defs/toolIngress                                            |

| Property                                                       | Pattern | Type    | Deprecated | Definition | Title/Description                                                         |
| -------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ------------------------------------------------------------------------- |
| - [enabled](#monitoring_prometheus_ingress_enabled )           | No      | boolean | No         | -          | -                                                                         |
| - [host](#monitoring_prometheus_ingress_host )                 | No      | string  | No         | -          | The subdomain to use under \`.global.clusterName\`.\`.global.baseDomain\` |
| - [customDomain](#monitoring_prometheus_ingress_customDomain ) | No      | string  | No         | -          | The full custom domain to use                                             |

##### <a name="monitoring_prometheus_ingress_enabled"></a>4.4.11.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="monitoring_prometheus_ingress_host"></a>4.4.11.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress > host`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The subdomain to use under `.global.clusterName`.`.global.baseDomain`

##### <a name="monitoring_prometheus_ingress_customDomain"></a>4.4.11.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > ingress > customDomain`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The full custom domain to use

#### <a name="monitoring_prometheus_alertmanager"></a>4.4.12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                      | Pattern | Type            | Deprecated | Definition                                         | Title/Description          |
| ----------------------------------------------------------------------------- | ------- | --------------- | ---------- | -------------------------------------------------- | -------------------------- |
| + [defaultReceiver](#monitoring_prometheus_alertmanager_defaultReceiver )     | No      | string          | No         | -                                                  | -                          |
| - [receivers](#monitoring_prometheus_alertmanager_receivers )                 | No      | object          | No         | -                                                  | -                          |
| - [routes](#monitoring_prometheus_alertmanager_routes )                       | No      | array of object | No         | In #/$defs/alertmanagerConfigRoutes                | Zero or more child routes. |
| - [ingress](#monitoring_prometheus_alertmanager_ingress )                     | No      | object          | No         | Same as [ingress](#monitoring_prometheus_ingress ) | -                          |
| - [replicas](#monitoring_prometheus_alertmanager_replicas )                   | No      | integer         | No         | -                                                  | -                          |
| - [retentionDuration](#monitoring_prometheus_alertmanager_retentionDuration ) | No      | string          | No         | -                                                  | -                          |
| - [persistence](#monitoring_prometheus_alertmanager_persistence )             | No      | object          | No         | -                                                  | -                          |

##### <a name="monitoring_prometheus_alertmanager_defaultReceiver"></a>4.4.12.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > defaultReceiver`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="monitoring_prometheus_alertmanager_receivers"></a>4.4.12.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                                      | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                                   |
| ----------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| - [pagerduty](#monitoring_prometheus_alertmanager_receivers_pagerduty )       | No      | object | No         | -          | -                                                                                                                                   |
| - [^email($\| \S+$)](#monitoring_prometheus_alertmanager_receivers_pattern1 ) | Yes     | object | No         | -          | Sets up an email receiver, if suffixed with \` $name\` \`$name\` will be used as the name of the receiver, otherwise it's \`email\` |

###### <a name="monitoring_prometheus_alertmanager_receivers_pagerduty"></a>4.4.12.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > pagerduty`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                    | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [url](#monitoring_prometheus_alertmanager_receivers_pagerduty_url )                       | No      | string | No         | -          | -                 |
| + [integrationKey](#monitoring_prometheus_alertmanager_receivers_pagerduty_integrationKey ) | No      | string | No         | -          | -                 |

###### <a name="monitoring_prometheus_alertmanager_receivers_pagerduty_url"></a>4.4.12.2.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > pagerduty > url`

|             |                                             |
| ----------- | ------------------------------------------- |
| **Type**    | `string`                                    |
| **Default** | `"https://events.pagerduty.com/v2/enqueue"` |

###### <a name="monitoring_prometheus_alertmanager_receivers_pagerduty_integrationKey"></a>4.4.12.2.1.2. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > pagerduty > integrationKey`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions   |    |
| -------------- | -- |
| **Min length** | 32 |
| **Max length** | 32 |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1"></a>4.4.12.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Pattern Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$)`
> All properties whose name matches the regular expression
```^email($| \S+$)``` ([Test](https://regex101.com/?regex=%5Eemail%28%24%7C%20%5CS%2B%24%29))
must respect the following conditions

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Sets up an email receiver, if suffixed with ` $name` `$name` will be used as the name of the receiver, otherwise it's `email`

| Property                                                                               | Pattern | Type    | Deprecated | Definition                                                                   | Title/Description |
| -------------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------------------------------------------------------------------------- | ----------------- |
| + [from](#monitoring_prometheus_alertmanager_receivers_pattern1_from )                 | No      | object  | No         | In #/$defs/email                                                             | -                 |
| + [to](#monitoring_prometheus_alertmanager_receivers_pattern1_to )                     | No      | object  | No         | Same as [from](#monitoring_prometheus_alertmanager_receivers_pattern1_from ) | -                 |
| + [host](#monitoring_prometheus_alertmanager_receivers_pattern1_host )                 | No      | string  | No         | -                                                                            | -                 |
| + [port](#monitoring_prometheus_alertmanager_receivers_pattern1_port )                 | No      | integer | No         | -                                                                            | -                 |
| + [username](#monitoring_prometheus_alertmanager_receivers_pattern1_username )         | No      | string  | No         | -                                                                            | -                 |
| + [password](#monitoring_prometheus_alertmanager_receivers_pattern1_password )         | No      | string  | No         | -                                                                            | -                 |
| - [sendResolved](#monitoring_prometheus_alertmanager_receivers_pattern1_sendResolved ) | No      | boolean | No         | -                                                                            | -                 |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1_from"></a>4.4.12.2.2.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$) > from`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/$defs/email                                                               |

| Restrictions                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```(?:[a-z0-9!#$%&'*+/=?^_`{\|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{\|}~-]+)*\|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\|\[(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\.){3}(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])``` [Test](https://regex101.com/?regex=%28%3F%3A%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%28%3F%3A%5C.%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%29%2A%7C%22%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21%5Cx23-%5Cx5b%5Cx5d-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2A%22%29%40%28%3F%3A%28%3F%3A%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%5C.%29%2B%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%7C%5C%5B%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%5C.%29%7B3%7D%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%7C%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%3A%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21-%5Cx5a%5Cx53-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2B%29%5C%5D%29) |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1_to"></a>4.4.12.2.2.2. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$) > to`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [from](#monitoring_prometheus_alertmanager_receivers_pattern1_from)         |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1_host"></a>4.4.12.2.2.3. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$) > host`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1_port"></a>4.4.12.2.2.4. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$) > port`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |            |
| ------------ | ---------- |
| **Minimum**  | &ge; 1     |
| **Maximum**  | &le; 65535 |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1_username"></a>4.4.12.2.2.5. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$) > username`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1_password"></a>4.4.12.2.2.6. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$) > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_prometheus_alertmanager_receivers_pattern1_sendResolved"></a>4.4.12.2.2.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > receivers > ^email($\| \S+$) > sendResolved`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="monitoring_prometheus_alertmanager_routes"></a>4.4.12.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > routes`

|                |                                  |
| -------------- | -------------------------------- |
| **Type**       | `array of object`                |
| **Defined in** | #/$defs/alertmanagerConfigRoutes |

**Description:** Zero or more child routes.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                           | Description                  |
| --------------------------------------------------------- | ---------------------------- |
| [route](#monitoring_prometheus_alertmanager_routes_items) | Alert routing configuration. |

###### <a name="monitoring_prometheus_alertmanager_routes_items"></a>4.4.12.3.1. base cluster configuration > monitoring > prometheus > alertmanager > routes > route

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/definitions/config/route                                                  |

**Description:** Alert routing configuration.

| Property                                                                                           | Pattern | Type            | Deprecated | Definition                                                                         | Title/Description                                                                                                                                            |
| -------------------------------------------------------------------------------------------------- | ------- | --------------- | ---------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| - [receiver](#monitoring_prometheus_alertmanager_routes_items_receiver )                           | No      | string          | No         | -                                                                                  | The default receiver to send alerts to.                                                                                                                      |
| - [group_by](#monitoring_prometheus_alertmanager_routes_items_group_by )                           | No      | array of string | No         | -                                                                                  | The labels by which incoming alerts are grouped together.                                                                                                    |
| - [continue](#monitoring_prometheus_alertmanager_routes_items_continue )                           | No      | boolean         | No         | -                                                                                  | Whether an alert should continue matching subsequent sibling nodes.                                                                                          |
| - [matchers](#monitoring_prometheus_alertmanager_routes_items_matchers )                           | No      | array of string | No         | -                                                                                  | A list of matchers that an alert has to fulfill to match the node.                                                                                           |
| - [group_wait](#monitoring_prometheus_alertmanager_routes_items_group_wait )                       | No      | string          | No         | In #/definitions/config/duration                                                   | How long to initially wait to send a notification for a group of alerts.                                                                                     |
| - [group_interval](#monitoring_prometheus_alertmanager_routes_items_group_interval )               | No      | string          | No         | Same as [group_wait](#monitoring_prometheus_alertmanager_routes_items_group_wait ) | How long to wait before sending a notification about new alerts that are added to a group of alerts for which an initial notification has already been sent. |
| - [repeat_interval](#monitoring_prometheus_alertmanager_routes_items_repeat_interval )             | No      | string          | No         | Same as [group_wait](#monitoring_prometheus_alertmanager_routes_items_group_wait ) | How long to wait before sending a notification again if it has already been sent successfully for an alert.                                                  |
| - [mute_time_intervals](#monitoring_prometheus_alertmanager_routes_items_mute_time_intervals )     | No      | array of string | No         | -                                                                                  | Times when the route should be muted.                                                                                                                        |
| - [active_time_intervals](#monitoring_prometheus_alertmanager_routes_items_active_time_intervals ) | No      | array of string | No         | -                                                                                  | Times when the route should be active.                                                                                                                       |
| - [routes](#monitoring_prometheus_alertmanager_routes_items_routes )                               | No      | array of object | No         | -                                                                                  | Zero or more child routes.                                                                                                                                   |

###### <a name="monitoring_prometheus_alertmanager_routes_items_receiver"></a>4.4.12.3.1.1. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > receiver`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The default receiver to send alerts to.

###### <a name="monitoring_prometheus_alertmanager_routes_items_group_by"></a>4.4.12.3.1.2. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > group_by`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** The labels by which incoming alerts are grouped together.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                              | Description |
| ---------------------------------------------------------------------------- | ----------- |
| [labelname](#monitoring_prometheus_alertmanager_routes_items_group_by_items) | -           |

###### <a name="monitoring_prometheus_alertmanager_routes_items_group_by_items"></a>4.4.12.3.1.2.1. base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > group_by > labelname

|                |                                |
| -------------- | ------------------------------ |
| **Type**       | `string`                       |
| **Defined in** | #/definitions/config/labelname |

| Restrictions                      |                                                                                                                              |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```^[a-zA-Z_][a-zA-Z0-9_]*$\|^...$``` [Test](https://regex101.com/?regex=%5E%5Ba-zA-Z_%5D%5Ba-zA-Z0-9_%5D%2A%24%7C%5E...%24) |

###### <a name="monitoring_prometheus_alertmanager_routes_items_continue"></a>4.4.12.3.1.3. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > continue`

|             |           |
| ----------- | --------- |
| **Type**    | `boolean` |
| **Default** | `false`   |

**Description:** Whether an alert should continue matching subsequent sibling nodes.

###### <a name="monitoring_prometheus_alertmanager_routes_items_matchers"></a>4.4.12.3.1.4. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > matchers`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** A list of matchers that an alert has to fulfill to match the node.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                   | Description |
| --------------------------------------------------------------------------------- | ----------- |
| [matchers items](#monitoring_prometheus_alertmanager_routes_items_matchers_items) | -           |

###### <a name="monitoring_prometheus_alertmanager_routes_items_matchers_items"></a>4.4.12.3.1.4.1. base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > matchers > matchers items

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_prometheus_alertmanager_routes_items_group_wait"></a>4.4.12.3.1.5. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > group_wait`

|                |                               |
| -------------- | ----------------------------- |
| **Type**       | `string`                      |
| **Defined in** | #/definitions/config/duration |

**Description:** How long to initially wait to send a notification for a group of alerts.

| Restrictions                      |                                                                                                                                                                                                                                                                                                                                                              |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Must match regular expression** | ```^((([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?\|0)$``` [Test](https://regex101.com/?regex=%5E%28%28%28%5B0-9%5D%2B%29y%29%3F%28%28%5B0-9%5D%2B%29w%29%3F%28%28%5B0-9%5D%2B%29d%29%3F%28%28%5B0-9%5D%2B%29h%29%3F%28%28%5B0-9%5D%2B%29m%29%3F%28%28%5B0-9%5D%2B%29s%29%3F%28%28%5B0-9%5D%2B%29ms%29%3F%7C0%29%24) |

###### <a name="monitoring_prometheus_alertmanager_routes_items_group_interval"></a>4.4.12.3.1.6. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > group_interval`

|                        |                                                                           |
| ---------------------- | ------------------------------------------------------------------------- |
| **Type**               | `string`                                                                  |
| **Same definition as** | [group_wait](#monitoring_prometheus_alertmanager_routes_items_group_wait) |

**Description:** How long to wait before sending a notification about new alerts that are added to a group of alerts for which an initial notification has already been sent.

###### <a name="monitoring_prometheus_alertmanager_routes_items_repeat_interval"></a>4.4.12.3.1.7. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > repeat_interval`

|                        |                                                                           |
| ---------------------- | ------------------------------------------------------------------------- |
| **Type**               | `string`                                                                  |
| **Same definition as** | [group_wait](#monitoring_prometheus_alertmanager_routes_items_group_wait) |

**Description:** How long to wait before sending a notification again if it has already been sent successfully for an alert.

###### <a name="monitoring_prometheus_alertmanager_routes_items_mute_time_intervals"></a>4.4.12.3.1.8. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > mute_time_intervals`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** Times when the route should be muted.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                                         | Description |
| ------------------------------------------------------------------------------------------------------- | ----------- |
| [mute_time_intervals items](#monitoring_prometheus_alertmanager_routes_items_mute_time_intervals_items) | -           |

###### <a name="monitoring_prometheus_alertmanager_routes_items_mute_time_intervals_items"></a>4.4.12.3.1.8.1. base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > mute_time_intervals > mute_time_intervals items

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_prometheus_alertmanager_routes_items_active_time_intervals"></a>4.4.12.3.1.9. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > active_time_intervals`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** Times when the route should be active.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                                             | Description |
| ----------------------------------------------------------------------------------------------------------- | ----------- |
| [active_time_intervals items](#monitoring_prometheus_alertmanager_routes_items_active_time_intervals_items) | -           |

###### <a name="monitoring_prometheus_alertmanager_routes_items_active_time_intervals_items"></a>4.4.12.3.1.9.1. base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > active_time_intervals > active_time_intervals items

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_prometheus_alertmanager_routes_items_routes"></a>4.4.12.3.1.10. Property `base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > routes`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of object` |

**Description:** Zero or more child routes.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                        | Description                  |
| ---------------------------------------------------------------------- | ---------------------------- |
| [route](#monitoring_prometheus_alertmanager_routes_items_routes_items) | Alert routing configuration. |

###### <a name="monitoring_prometheus_alertmanager_routes_items_routes_items"></a>4.4.12.3.1.10.1. base cluster configuration > monitoring > prometheus > alertmanager > routes > routes items > routes > route

|                           |                                                                                                     |
| ------------------------- | --------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                            |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                         |
| **Same definition as**    | [monitoring_prometheus_alertmanager_routes_items](#monitoring_prometheus_alertmanager_routes_items) |

**Description:** Alert routing configuration.

##### <a name="monitoring_prometheus_alertmanager_ingress"></a>4.4.12.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > ingress`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Same definition as**    | [ingress](#monitoring_prometheus_ingress)                      |

##### <a name="monitoring_prometheus_alertmanager_replicas"></a>4.4.12.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

##### <a name="monitoring_prometheus_alertmanager_retentionDuration"></a>4.4.12.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > retentionDuration`

|          |          |
| -------- | -------- |
| **Type** | `string` |

| Restrictions                      |                                                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(ms\|s\|m\|h\|d\|w\|y)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28ms%7Cs%7Cm%7Ch%7Cd%7Cw%7Cy%29) |

##### <a name="monitoring_prometheus_alertmanager_persistence"></a>4.4.12.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > persistence`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                        | Pattern | Type   | Deprecated | Definition                                                                                                                                         | Title/Description                                                                                                |
| ------------------------------------------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [storageClass](#monitoring_prometheus_alertmanager_persistence_storageClass ) | No      | string | No         | Same as [storageClass](#global_storageClass )                                                                                                      | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |
| - [size](#monitoring_prometheus_alertmanager_persistence_size )                 | No      | object | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                                                                                                                |

###### <a name="monitoring_prometheus_alertmanager_persistence_storageClass"></a>4.4.12.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string`                             |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

###### <a name="monitoring_prometheus_alertmanager_persistence_size"></a>4.4.12.7.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > prometheus > alertmanager > persistence > size`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

### <a name="monitoring_grafana"></a>4.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                            | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                       |
| ------------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| - [adminPassword](#monitoring_grafana_adminPassword )               | No      | string           | No         | -                                                                             | -                                                                       |
| - [ingress](#monitoring_grafana_ingress )                           | No      | object           | No         | Same as [ingress](#monitoring_prometheus_ingress )                            | -                                                                       |
| - [additionalDashboards](#monitoring_grafana_additionalDashboards ) | No      | object           | No         | -                                                                             | -                                                                       |
| - [config](#monitoring_grafana_config )                             | No      | object           | No         | -                                                                             | -                                                                       |
| - [notifiers](#monitoring_grafana_notifiers )                       | No      | array of object  | No         | -                                                                             | See https://grafana.com/docs/grafana/latest/administration/provisioning |
| - [additionalPlugins](#monitoring_grafana_additionalPlugins )       | No      | array of string  | No         | -                                                                             | -                                                                       |
| - [resourcesPreset](#monitoring_grafana_resourcesPreset )           | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                       |
| - [resources](#monitoring_grafana_resources )                       | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements.       |
| - [persistence](#monitoring_grafana_persistence )                   | No      | object           | No         | -                                                                             | -                                                                       |
| - [sidecar](#monitoring_grafana_sidecar )                           | No      | object           | No         | -                                                                             | -                                                                       |

#### <a name="monitoring_grafana_adminPassword"></a>4.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > adminPassword`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_grafana_ingress"></a>4.5.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > ingress`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |
| **Same definition as**    | [ingress](#monitoring_prometheus_ingress)                      |

#### <a name="monitoring_grafana_additionalDashboards"></a>4.5.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalDashboards`

|                           |                                                                                                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Type**                  | `object`                                                                                                                             |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_grafana_additionalDashboards_additionalProperties) |

| Property                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#monitoring_grafana_additionalDashboards_additionalProperties ) | No      | object | No         | -          | -                 |

##### <a name="monitoring_grafana_additionalDashboards_additionalProperties"></a>4.5.3.1. Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                  | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| + [gnetId](#monitoring_grafana_additionalDashboards_additionalProperties_gnetId )         | No      | integer | No         | -          | -                 |
| - [revision](#monitoring_grafana_additionalDashboards_additionalProperties_revision )     | No      | integer | No         | -          | -                 |
| - [datasource](#monitoring_grafana_additionalDashboards_additionalProperties_datasource ) | No      | string  | No         | -          | -                 |

###### <a name="monitoring_grafana_additionalDashboards_additionalProperties_gnetId"></a>4.5.3.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties > gnetId`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

###### <a name="monitoring_grafana_additionalDashboards_additionalProperties_revision"></a>4.5.3.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties > revision`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

###### <a name="monitoring_grafana_additionalDashboards_additionalProperties_datasource"></a>4.5.3.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalDashboards > additionalProperties > datasource`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_grafana_config"></a>4.5.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > config`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

#### <a name="monitoring_grafana_notifiers"></a>4.5.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > notifiers`

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

##### <a name="monitoring_grafana_notifiers_items"></a>4.5.5.1. base cluster configuration > monitoring > grafana > notifiers > notifiers items

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

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

###### <a name="monitoring_grafana_notifiers_items_name"></a>4.5.5.1.1. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_grafana_notifiers_items_type"></a>4.5.5.1.2. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > type`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_grafana_notifiers_items_uid"></a>4.5.5.1.3. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > uid`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_grafana_notifiers_items_org_id"></a>4.5.5.1.4. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > org_id`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

###### <a name="monitoring_grafana_notifiers_items_is_default"></a>4.5.5.1.5. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > is_default`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

###### <a name="monitoring_grafana_notifiers_items_send_reminder"></a>4.5.5.1.6. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > send_reminder`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

###### <a name="monitoring_grafana_notifiers_items_frequency"></a>4.5.5.1.7. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > frequency`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="monitoring_grafana_notifiers_items_settings"></a>4.5.5.1.8. Property `base cluster configuration > monitoring > grafana > notifiers > notifiers items > settings`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

#### <a name="monitoring_grafana_additionalPlugins"></a>4.5.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > additionalPlugins`

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

##### <a name="monitoring_grafana_additionalPlugins_items"></a>4.5.6.1. base cluster configuration > monitoring > grafana > additionalPlugins > additionalPlugins items

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_grafana_resourcesPreset"></a>4.5.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

#### <a name="monitoring_grafana_resources"></a>4.5.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_grafana_persistence"></a>4.5.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > persistence`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                | Pattern | Type    | Deprecated | Definition                                                                                                                                         | Title/Description |
| ----------------------------------------------------------------------- | ------- | ------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| - [enabled](#monitoring_grafana_persistence_enabled )                   | No      | boolean | No         | -                                                                                                                                                  | -                 |
| - [size](#monitoring_grafana_persistence_size )                         | No      | object  | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                 |
| - [storageClassName](#monitoring_grafana_persistence_storageClassName ) | No      | string  | No         | -                                                                                                                                                  | -                 |

##### <a name="monitoring_grafana_persistence_enabled"></a>4.5.9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > persistence > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

##### <a name="monitoring_grafana_persistence_size"></a>4.5.9.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > persistence > size`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

##### <a name="monitoring_grafana_persistence_storageClassName"></a>4.5.9.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > persistence > storageClassName`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="monitoring_grafana_sidecar"></a>4.5.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > sidecar`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                          | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ----------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#monitoring_grafana_sidecar_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#monitoring_grafana_sidecar_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_grafana_sidecar_resourcesPreset"></a>4.5.10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > sidecar > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

##### <a name="monitoring_grafana_sidecar_resources"></a>4.5.10.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > grafana > sidecar > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="monitoring_loki"></a>4.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                               | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ------------------------------------------------------ | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [enabled](#monitoring_loki_enabled )                 | No      | boolean          | No         | -                                                                             | -                                                                 |
| - [persistence](#monitoring_loki_persistence )         | No      | object           | No         | -                                                                             | -                                                                 |
| - [resourcesPreset](#monitoring_loki_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#monitoring_loki_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |
| - [promtail](#monitoring_loki_promtail )               | No      | object           | No         | -                                                                             | -                                                                 |

#### <a name="monitoring_loki_enabled"></a>4.6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="monitoring_loki_persistence"></a>4.6.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > persistence`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                     | Pattern | Type   | Deprecated | Definition                                                                                                                                         | Title/Description                                                                                                |
| ------------------------------------------------------------ | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [size](#monitoring_loki_persistence_size )                 | No      | object | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                                                                                                                |
| - [storageClass](#monitoring_loki_persistence_storageClass ) | No      | string | No         | Same as [storageClass](#global_storageClass )                                                                                                      | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |

##### <a name="monitoring_loki_persistence_size"></a>4.6.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > persistence > size`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

##### <a name="monitoring_loki_persistence_storageClass"></a>4.6.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string`                             |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

#### <a name="monitoring_loki_resourcesPreset"></a>4.6.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

#### <a name="monitoring_loki_resources"></a>4.6.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

#### <a name="monitoring_loki_promtail"></a>4.6.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > promtail`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                        | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| --------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#monitoring_loki_promtail_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#monitoring_loki_promtail_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

##### <a name="monitoring_loki_promtail_resourcesPreset"></a>4.6.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > promtail > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

##### <a name="monitoring_loki_promtail_resources"></a>4.6.5.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > loki > promtail > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="monitoring_metricsServer"></a>4.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > metricsServer`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                        | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#monitoring_metricsServer_enabled ) | No      | boolean | No         | -          | -                 |

#### <a name="monitoring_metricsServer_enabled"></a>4.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > metricsServer > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="monitoring_storageCostAnalysis"></a>4.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** Configuration of the `storageCostAnalysis dashboard

| Property                                                                      | Pattern | Type   | Deprecated | Definition | Title/Description                                     |
| ----------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------------------------------------------- |
| - [period](#monitoring_storageCostAnalysis_period )                           | No      | string | No         | -          | The billing period                                    |
| - [currency](#monitoring_storageCostAnalysis_currency )                       | No      | string | No         | -          | -                                                     |
| - [storageClassMapping](#monitoring_storageCostAnalysis_storageClassMapping ) | No      | object | No         | -          | A map of storageClasses to their cost per GiB/$period |

#### <a name="monitoring_storageCostAnalysis_period"></a>4.8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis > period`

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

#### <a name="monitoring_storageCostAnalysis_currency"></a>4.8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis > currency`

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

#### <a name="monitoring_storageCostAnalysis_storageClassMapping"></a>4.8.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > storageCostAnalysis > storageClassMapping`

|                           |                                                                                                                                                 |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                        |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#monitoring_storageCostAnalysis_storageClassMapping_additionalProperties) |

**Description:** A map of storageClasses to their cost per GiB/$period

| Property                                                                        | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#monitoring_storageCostAnalysis_storageClassMapping_additionalProperties ) | No      | number | No         | -          | -                 |

##### <a name="monitoring_storageCostAnalysis_storageClassMapping_additionalProperties"></a>4.8.3.1. Property `base cluster configuration > monitoring > storageCostAnalysis > storageClassMapping > additionalProperties`

|          |          |
| -------- | -------- |
| **Type** | `number` |

### <a name="monitoring_securityScanning"></a>4.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > securityScanning`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                       | Pattern | Type    | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#monitoring_securityScanning_enabled )             | No      | boolean | No         | -          | -                 |
| - [nodeCollector](#monitoring_securityScanning_nodeCollector ) | No      | object  | No         | -          | -                 |

#### <a name="monitoring_securityScanning_enabled"></a>4.9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > securityScanning > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="monitoring_securityScanning_nodeCollector"></a>4.9.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > securityScanning > nodeCollector`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                                 | Pattern | Type  | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------ | ------- | ----- | ---------- | ---------- | ----------------- |
| - [tolerations](#monitoring_securityScanning_nodeCollector_tolerations ) | No      | array | No         | -          | -                 |

##### <a name="monitoring_securityScanning_nodeCollector_tolerations"></a>4.9.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > securityScanning > nodeCollector > tolerations`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                             | Description                                                                                                                                   |
| --------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| [tolerations](#monitoring_securityScanning_nodeCollector_tolerations_items) | The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>. |

###### <a name="monitoring_securityScanning_nodeCollector_tolerations_items"></a>4.9.2.1.1. base cluster configuration > monitoring > securityScanning > nodeCollector > tolerations > tolerations

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Defined in**            | #/$defs/tolerations                                                         |

**Description:** The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>.

| Property                                                                                               | Pattern | Type    | Deprecated | Definition | Title/Description                                                                                                                                                                                                                                                                                                           |
| ------------------------------------------------------------------------------------------------------ | ------- | ------- | ---------- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [effect](#monitoring_securityScanning_nodeCollector_tolerations_items_effect )                       | No      | string  | No         | -          | Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.                                                                                                                                                             |
| - [key](#monitoring_securityScanning_nodeCollector_tolerations_items_key )                             | No      | string  | No         | -          | Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.                                                                                                                               |
| - [operator](#monitoring_securityScanning_nodeCollector_tolerations_items_operator )                   | No      | string  | No         | -          | Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.                                                                                                 |
| - [tolerationSeconds](#monitoring_securityScanning_nodeCollector_tolerations_items_tolerationSeconds ) | No      | integer | No         | -          | TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system. |
| - [value](#monitoring_securityScanning_nodeCollector_tolerations_items_value )                         | No      | string  | No         | -          | Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.                                                                                                                                                                                  |

###### <a name="monitoring_securityScanning_nodeCollector_tolerations_items_effect"></a>4.9.2.1.1.1. Property `base cluster configuration > monitoring > securityScanning > nodeCollector > tolerations > tolerations items > effect`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.

###### <a name="monitoring_securityScanning_nodeCollector_tolerations_items_key"></a>4.9.2.1.1.2. Property `base cluster configuration > monitoring > securityScanning > nodeCollector > tolerations > tolerations items > key`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.

###### <a name="monitoring_securityScanning_nodeCollector_tolerations_items_operator"></a>4.9.2.1.1.3. Property `base cluster configuration > monitoring > securityScanning > nodeCollector > tolerations > tolerations items > operator`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.

###### <a name="monitoring_securityScanning_nodeCollector_tolerations_items_tolerationSeconds"></a>4.9.2.1.1.4. Property `base cluster configuration > monitoring > securityScanning > nodeCollector > tolerations > tolerations items > tolerationSeconds`

|            |           |
| ---------- | --------- |
| **Type**   | `integer` |
| **Format** | `int64`   |

**Description:** TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.

###### <a name="monitoring_securityScanning_nodeCollector_tolerations_items_value"></a>4.9.2.1.1.5. Property `base cluster configuration > monitoring > securityScanning > nodeCollector > tolerations > tolerations items > value`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.

### <a name="monitoring_tracing"></a>4.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > tracing`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                    | Pattern | Type    | Deprecated | Definition | Title/Description |
| ------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#monitoring_tracing_enabled )   | No      | boolean | No         | -          | -                 |
| - [ingester](#monitoring_tracing_ingester ) | No      | object  | No         | -          | -                 |

#### <a name="monitoring_tracing_enabled"></a>4.10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > tracing > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="monitoring_tracing_ingester"></a>4.10.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > tracing > ingester`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                           | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ------------------------------------------------------------------ | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#monitoring_tracing_ingester_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#monitoring_tracing_ingester_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |
| - [persistence](#monitoring_tracing_ingester_persistence )         | No      | object           | No         | -                                                                             | -                                                                 |

##### <a name="monitoring_tracing_ingester_resourcesPreset"></a>4.10.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > tracing > ingester > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

##### <a name="monitoring_tracing_ingester_resources"></a>4.10.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > tracing > ingester > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

##### <a name="monitoring_tracing_ingester_persistence"></a>4.10.2.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > tracing > ingester > persistence`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                 | Pattern | Type   | Deprecated | Definition                                                                                                                                         | Title/Description |
| -------------------------------------------------------- | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| - [size](#monitoring_tracing_ingester_persistence_size ) | No      | object | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                 |

###### <a name="monitoring_tracing_ingester_persistence_size"></a>4.10.2.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > tracing > ingester > persistence > size`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

### <a name="monitoring_additionalProperties"></a>4.11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > monitoring > additionalProperties`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

## <a name="descheduler"></a>5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                           | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                                                                          |
| -------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| - [enabled](#descheduler_enabled )                 | No      | boolean          | No         | -                                                                             | -                                                                                                                          |
| - [profile](#descheduler_profile )                 | No      | object           | No         | -                                                                             | See https://github.com/kubernetes-sigs/descheduler#policy-default-evictor-and-strategy-plugins. The key is the policy name |
| - [resourcesPreset](#descheduler_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                                                                          |
| - [resources](#descheduler_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements.                                                          |

### <a name="descheduler_enabled"></a>5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="descheduler_profile"></a>5.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > profile`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** See https://github.com/kubernetes-sigs/descheduler#policy-default-evictor-and-strategy-plugins. The key is the policy name

| Property                                             | Pattern | Type            | Deprecated | Definition | Title/Description |
| ---------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| - [pluginConfig](#descheduler_profile_pluginConfig ) | No      | array of object | No         | -          | -                 |
| - [plugins](#descheduler_profile_plugins )           | No      | object          | No         | -          | -                 |

#### <a name="descheduler_profile_pluginConfig"></a>5.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > profile > pluginConfig`

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

| Each item of this array must be                               | Description |
| ------------------------------------------------------------- | ----------- |
| [pluginConfig items](#descheduler_profile_pluginConfig_items) | -           |

##### <a name="descheduler_profile_pluginConfig_items"></a>5.2.1.1. base cluster configuration > descheduler > profile > pluginConfig > pluginConfig items

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [name](#descheduler_profile_pluginConfig_items_name ) | No      | string | No         | -          | -                 |
| - [args](#descheduler_profile_pluginConfig_items_args ) | No      | object | No         | -          | -                 |

###### <a name="descheduler_profile_pluginConfig_items_name"></a>5.2.1.1.1. Property `base cluster configuration > descheduler > profile > pluginConfig > pluginConfig items > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="descheduler_profile_pluginConfig_items_args"></a>5.2.1.1.2. Property `base cluster configuration > descheduler > profile > pluginConfig > pluginConfig items > args`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

#### <a name="descheduler_profile_plugins"></a>5.2.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > profile > plugins`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                          | Pattern | Type   | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [^balance\|deschedule$](#descheduler_profile_plugins_pattern1 ) | Yes     | object | No         | -          | -                 |

##### <a name="descheduler_profile_plugins_pattern1"></a>5.2.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Pattern Property `base cluster configuration > descheduler > profile > plugins > ^balance\|deschedule$`
> All properties whose name matches the regular expression
```^balance|deschedule$``` ([Test](https://regex101.com/?regex=%5Ebalance%7Cdeschedule%24))
must respect the following conditions

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                    | Pattern | Type            | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------- |
| + [enabled](#descheduler_profile_plugins_pattern1_enabled ) | No      | array of string | No         | -          | -                 |

###### <a name="descheduler_profile_plugins_pattern1_enabled"></a>5.2.2.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > descheduler > profile > plugins > ^balance\|deschedule$ > enabled`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                      | Description |
| -------------------------------------------------------------------- | ----------- |
| [enabled items](#descheduler_profile_plugins_pattern1_enabled_items) | -           |

###### <a name="descheduler_profile_plugins_pattern1_enabled_items"></a>5.2.2.1.1.1. base cluster configuration > descheduler > profile > plugins > ^balance\|deschedule$ > enabled > enabled items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="descheduler_resourcesPreset"></a>5.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

### <a name="descheduler_resources"></a>5.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > descheduler > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

## <a name="dns"></a>6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > dns`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                     | Pattern | Type            | Deprecated | Definition | Title/Description                                                                                           |
| ---------------------------- | ------- | --------------- | ---------- | ---------- | ----------------------------------------------------------------------------------------------------------- |
| - [provider](#dns_provider ) | No      | Combination     | No         | -          | Setting a provider enabled various DNS based features, such as \`external-dns\`, wildcard certificates, ... |
| - [domains](#dns_domains )   | No      | array of string | No         | -          | -                                                                                                           |

### <a name="dns_provider"></a>6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > dns > provider`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** Setting a provider enabled various DNS based features, such as `external-dns`, wildcard certificates, ...

| One of(Option)                   |
| -------------------------------- |
| [item 0](#dns_provider_oneOf_i0) |
| [item 1](#dns_provider_oneOf_i1) |

#### <a name="dns_provider_oneOf_i0"></a>6.1.1. Property `base cluster configuration > dns > provider > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                           | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [cloudflare](#dns_provider_oneOf_i0_cloudflare ) | No      | object | No         | -          | -                 |

##### <a name="dns_provider_oneOf_i0_cloudflare"></a>6.1.1.1. Property `base cluster configuration > dns > provider > oneOf > item 0 > cloudflare`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                  | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [apiToken](#dns_provider_oneOf_i0_cloudflare_apiToken ) | No      | string | No         | -          | -                 |

###### <a name="dns_provider_oneOf_i0_cloudflare_apiToken"></a>6.1.1.1.1. Property `base cluster configuration > dns > provider > oneOf > item 0 > cloudflare > apiToken`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="dns_provider_oneOf_i1"></a>6.1.2. Property `base cluster configuration > dns > provider > oneOf > item 1`

|          |        |
| -------- | ------ |
| **Type** | `null` |

### <a name="dns_domains"></a>6.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > dns > domains`

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

#### <a name="dns_domains_items"></a>6.2.1. base cluster configuration > dns > domains > domains items

|          |          |
| -------- | -------- |
| **Type** | `string` |

## <a name="certManager"></a>7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                           | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                                      |
| ------------------------------------------------------------------ | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| - [resourcesPreset](#certManager_resourcesPreset )                 | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                                      |
| - [resources](#certManager_resources )                             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements.                      |
| - [email](#certManager_email )                                     | No      | string           | No         | In #/$defs/email                                                              | Setting an email enables cert-manager's IngressShim and will be used for Let's Encrypt |
| - [webhook](#certManager_webhook )                                 | No      | object           | No         | -                                                                             | -                                                                                      |
| - [caInjector](#certManager_caInjector )                           | No      | object           | No         | -                                                                             | -                                                                                      |
| - [dnsChallengeNameservers](#certManager_dnsChallengeNameservers ) | No      | object           | No         | -                                                                             | -                                                                                      |

### <a name="certManager_resourcesPreset"></a>7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

### <a name="certManager_resources"></a>7.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="certManager_email"></a>7.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > email`

|                |               |
| -------------- | ------------- |
| **Type**       | `string`      |
| **Defined in** | #/$defs/email |

**Description:** Setting an email enables cert-manager's IngressShim and will be used for Let's Encrypt

| Restrictions                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```(?:[a-z0-9!#$%&'*+/=?^_`{\|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{\|}~-]+)*\|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\|\[(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\.){3}(?:(2(5[0-5]\|[0-4][0-9])\|1[0-9][0-9]\|[1-9]?[0-9])\|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]\|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])``` [Test](https://regex101.com/?regex=%28%3F%3A%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%28%3F%3A%5C.%5Ba-z0-9%21%23%24%25%26%27%2A%2B%2F%3D%3F%5E_%60%7B%7C%7D~-%5D%2B%29%2A%7C%22%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21%5Cx23-%5Cx5b%5Cx5d-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2A%22%29%40%28%3F%3A%28%3F%3A%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%5C.%29%2B%5Ba-z0-9%5D%28%3F%3A%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%29%3F%7C%5C%5B%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%5C.%29%7B3%7D%28%3F%3A%282%285%5B0-5%5D%7C%5B0-4%5D%5B0-9%5D%29%7C1%5B0-9%5D%5B0-9%5D%7C%5B1-9%5D%3F%5B0-9%5D%29%7C%5Ba-z0-9-%5D%2A%5Ba-z0-9%5D%3A%28%3F%3A%5B%5Cx01-%5Cx08%5Cx0b%5Cx0c%5Cx0e-%5Cx1f%5Cx21-%5Cx5a%5Cx53-%5Cx7f%5D%7C%5C%5C%5B%5Cx01-%5Cx09%5Cx0b%5Cx0c%5Cx0e-%5Cx7f%5D%29%2B%29%5C%5D%29) |

### <a name="certManager_webhook"></a>7.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > webhook`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                   | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ---------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#certManager_webhook_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#certManager_webhook_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

#### <a name="certManager_webhook_resourcesPreset"></a>7.4.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > webhook > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

#### <a name="certManager_webhook_resources"></a>7.4.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > webhook > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="certManager_caInjector"></a>7.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > caInjector`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                      | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ------------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#certManager_caInjector_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#certManager_caInjector_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

#### <a name="certManager_caInjector_resourcesPreset"></a>7.5.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > caInjector > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

#### <a name="certManager_caInjector_resources"></a>7.5.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > caInjector > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="certManager_dnsChallengeNameservers"></a>7.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > certManager > dnsChallengeNameservers`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                            | Pattern | Type    | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [^((25[0-5]\|(2[0-4]\|1\d\|[1-9]\|)\d)\.?\b){4}$](#certManager_dnsChallengeNameservers_pattern1 ) | Yes     | integer | No         | -          | -                 |

#### <a name="certManager_dnsChallengeNameservers_pattern1"></a>7.6.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Pattern Property `base cluster configuration > certManager > dnsChallengeNameservers > ^((25[0-5]\|(2[0-4]\|1\d\|[1-9]\|)\d)\.?\b){4}$`
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

## <a name="externalDNS"></a>8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > externalDNS`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                           | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| -------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#externalDNS_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#externalDNS_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

### <a name="externalDNS_resourcesPreset"></a>8.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > externalDNS > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

### <a name="externalDNS_resources"></a>8.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > externalDNS > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

## <a name="flux"></a>9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                    | Pattern | Type   | Deprecated | Definition | Title/Description                  |
| ------------------------------------------- | ------- | ------ | ---------- | ---------- | ---------------------------------- |
| - [gitRepositories](#flux_gitRepositories ) | No      | object | No         | -          | A map of gitRepositories to create |

### <a name="flux_gitRepositories"></a>9.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories`

|                           |                                                                                                                   |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                          |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#flux_gitRepositories_additionalProperties) |

**Description:** A map of gitRepositories to create

| Property                                          | Pattern | Type        | Deprecated | Definition | Title/Description |
| ------------------------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [](#flux_gitRepositories_additionalProperties ) | No      | Combination | No         | -          | -                 |

#### <a name="flux_gitRepositories_additionalProperties"></a>9.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `combining`                                                    |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                 | Pattern | Type   | Deprecated | Definition | Title/Description                            |
| ------------------------------------------------------------------------ | ------- | ------ | ---------- | ---------- | -------------------------------------------- |
| + [url](#flux_gitRepositories_additionalProperties_url )                 | No      | string | No         | -          | -                                            |
| - [username](#flux_gitRepositories_additionalProperties_username )       | No      | string | No         | -          | -                                            |
| - [password](#flux_gitRepositories_additionalProperties_password )       | No      | string | No         | -          | -                                            |
| - [branch](#flux_gitRepositories_additionalProperties_branch )           | No      | string | No         | -          | -                                            |
| - [commit](#flux_gitRepositories_additionalProperties_commit )           | No      | string | No         | -          | -                                            |
| - [semver](#flux_gitRepositories_additionalProperties_semver )           | No      | string | No         | -          | -                                            |
| - [tag](#flux_gitRepositories_additionalProperties_tag )                 | No      | string | No         | -          | -                                            |
| - [path](#flux_gitRepositories_additionalProperties_path )               | No      | string | No         | -          | -                                            |
| - [gitInterval](#flux_gitRepositories_additionalProperties_gitInterval ) | No      | string | No         | -          | The interval in which to sync the repository |
| - [decryption](#flux_gitRepositories_additionalProperties_decryption )   | No      | object | No         | -          | -                                            |

| All of(Requirement)                                           |
| ------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i1) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i0"></a>9.1.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                                                         |
| ---------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1) |

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0"></a>9.1.1.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [url](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_url ) | No      | object | No         | -          | -                 |

| One of(Option)                                                                  |
| ------------------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i1) |

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i0"></a>9.1.1.1.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_16"></a>9.1.1.1.1.1.1. The following properties are required
* password
* username

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i1"></a>9.1.1.1.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_17"></a>9.1.1.1.1.2.1. Must **not** be

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Any of(Option)                                                                               |
| -------------------------------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i1_not_anyOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i1_not_anyOf_i1) |

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i1_not_anyOf_i0"></a>9.1.1.1.1.2.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > oneOf > item 1 > not > anyOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_18"></a>9.1.1.1.1.2.1.1.1. The following properties are required
* username

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_oneOf_i1_not_anyOf_i1"></a>9.1.1.1.1.2.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > oneOf > item 1 > not > anyOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_19"></a>9.1.1.1.1.2.1.2.1. The following properties are required
* password

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i0_url"></a>9.1.1.1.1.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 0 > url`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Restrictions                      |                                                                         |
| --------------------------------- | ----------------------------------------------------------------------- |
| **Must match regular expression** | ```https://.+``` [Test](https://regex101.com/?regex=https%3A%2F%2F.%2B) |

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1"></a>9.1.1.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                                   | Pattern | Type   | Deprecated | Definition | Title/Description                                                                                                      |
| -------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ---------------------------------------------------------------------------------------------------------------------- |
| - [url](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_url ) | No      | object | No         | -          | This needs to follow flux's way of writing this url, see https://fluxcd.io/flux/components/source/gitrepositories/#url |

###### <a name="autogenerated_heading_20"></a>9.1.1.1.2.1. Must **not** be

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Any of(Option)                                                                      |
| ----------------------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_not_anyOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_not_anyOf_i1) |

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_not_anyOf_i0"></a>9.1.1.1.2.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1 > not > anyOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_21"></a>9.1.1.1.2.1.1.1. The following properties are required
* username

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_not_anyOf_i1"></a>9.1.1.1.2.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1 > not > anyOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_22"></a>9.1.1.1.2.1.2.1. The following properties are required
* password

###### <a name="flux_gitRepositories_additionalProperties_allOf_i0_oneOf_i1_url"></a>9.1.1.1.2.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 0 > oneOf > item 1 > url`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** This needs to follow flux's way of writing this url, see https://fluxcd.io/flux/components/source/gitrepositories/#url

| Restrictions                      |                                                                                                                                                               |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```^ssh://.+@[^:]+(?::\d+/)?[^:]*$``` [Test](https://regex101.com/?regex=%5Essh%3A%2F%2F.%2B%40%5B%5E%3A%5D%2B%28%3F%3A%3A%5Cd%2B%2F%29%3F%5B%5E%3A%5D%2A%24) |

##### <a name="flux_gitRepositories_additionalProperties_allOf_i1"></a>9.1.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                                                         |
| ---------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i1) |
| [item 2](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i2) |
| [item 3](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i3) |
| [item 4](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4) |

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i0"></a>9.1.1.2.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_23"></a>9.1.1.2.1.1. The following properties are required
* branch

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i1"></a>9.1.1.2.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_24"></a>9.1.1.2.2.1. The following properties are required
* commit

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i2"></a>9.1.1.2.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 2`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_25"></a>9.1.1.2.3.1. The following properties are required
* semver

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i3"></a>9.1.1.2.4. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 3`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_26"></a>9.1.1.2.4.1. The following properties are required
* tag

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4"></a>9.1.1.2.5. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_27"></a>9.1.1.2.5.1. Must **not** be

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Any of(Option)                                                                      |
| ----------------------------------------------------------------------------------- |
| [item 0](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i0) |
| [item 1](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i1) |
| [item 2](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i2) |
| [item 3](#flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i3) |

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i0"></a>9.1.1.2.5.1.1. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > not > anyOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_28"></a>9.1.1.2.5.1.1.1. The following properties are required
* branch

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i1"></a>9.1.1.2.5.1.2. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > not > anyOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_29"></a>9.1.1.2.5.1.2.1. The following properties are required
* commit

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i2"></a>9.1.1.2.5.1.3. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > not > anyOf > item 2`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_30"></a>9.1.1.2.5.1.3.1. The following properties are required
* semver

###### <a name="flux_gitRepositories_additionalProperties_allOf_i1_oneOf_i4_not_anyOf_i3"></a>9.1.1.2.5.1.4. Property `base cluster configuration > flux > gitRepositories > additionalProperties > allOf > item 1 > oneOf > item 4 > not > anyOf > item 3`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_31"></a>9.1.1.2.5.1.4.1. The following properties are required
* tag

##### <a name="flux_gitRepositories_additionalProperties_url"></a>9.1.1.3. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > flux > gitRepositories > additionalProperties > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_username"></a>9.1.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > username`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_password"></a>9.1.1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > password`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_branch"></a>9.1.1.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > branch`

|             |            |
| ----------- | ---------- |
| **Type**    | `string`   |
| **Default** | `"master"` |

##### <a name="flux_gitRepositories_additionalProperties_commit"></a>9.1.1.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > commit`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_semver"></a>9.1.1.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > semver`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_tag"></a>9.1.1.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > tag`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_path"></a>9.1.1.10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > path`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="flux_gitRepositories_additionalProperties_gitInterval"></a>9.1.1.11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > gitInterval`

|             |          |
| ----------- | -------- |
| **Type**    | `string` |
| **Default** | `"1m"`   |

**Description:** The interval in which to sync the repository

| Restrictions                      |                                                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```[0-9]+(ms\|s\|m\|h\|d\|w\|y)``` [Test](https://regex101.com/?regex=%5B0-9%5D%2B%28ms%7Cs%7Cm%7Ch%7Cd%7Cw%7Cy%29) |

##### <a name="flux_gitRepositories_additionalProperties_decryption"></a>9.1.1.12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > flux > gitRepositories > additionalProperties > decryption`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                      | Pattern | Type             | Deprecated | Definition | Title/Description |
| ----------------------------------------------------------------------------- | ------- | ---------------- | ---------- | ---------- | ----------------- |
| + [provider](#flux_gitRepositories_additionalProperties_decryption_provider ) | No      | enum (of string) | No         | -          | -                 |

###### <a name="flux_gitRepositories_additionalProperties_decryption_provider"></a>9.1.1.12.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > flux > gitRepositories > additionalProperties > decryption > provider`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

Must be one of:
* "sops"

## <a name="ingress"></a>10. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                       | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                                                                                                                                                                             |
| ------------------------------------------------------------------------------ | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [replicas](#ingress_replicas )                                               | No      | integer          | No         | -                                                                             | -                                                                                                                                                                                                                             |
| - [resourcesPreset](#ingress_resourcesPreset )                                 | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                                                                                                                                                                             |
| - [resources](#ingress_resources )                                             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements.                                                                                                                                                             |
| - [provider](#ingress_provider )                                               | No      | enum (of string) | No         | -                                                                             | Which ingress controller to use                                                                                                                                                                                               |
| - [allowNginxConfigurationSnippets](#ingress_allowNginxConfigurationSnippets ) | No      | boolean          | No         | -                                                                             | Please don't do it if not absolutely necessary, it goes against all best practices. Ref.: https://docs.nginx.com/nginx-ingress-controller/configuration/global-configuration/command-line-arguments#cmdoption-enable-snippets |
| - [useProxyProtocol](#ingress_useProxyProtocol )                               | No      | boolean          | No         | -                                                                             | -                                                                                                                                                                                                                             |
| - [IP](#ingress_IP )                                                           | No      | string           | No         | -                                                                             | Try to use specified IP as loadbalancer IP                                                                                                                                                                                    |

### <a name="ingress_replicas"></a>10.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > replicas`

|          |           |
| -------- | --------- |
| **Type** | `integer` |

| Restrictions |        |
| ------------ | ------ |
| **Minimum**  | &ge; 1 |

### <a name="ingress_resourcesPreset"></a>10.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

### <a name="ingress_resources"></a>10.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="ingress_provider"></a>10.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > provider`

|          |                    |
| -------- | ------------------ |
| **Type** | `enum (of string)` |

**Description:** Which ingress controller to use

Must be one of:
* "nginx"
* "traefik"
* "none"

### <a name="ingress_allowNginxConfigurationSnippets"></a>10.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > allowNginxConfigurationSnippets`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

**Description:** Please don't do it if not absolutely necessary, it goes against all best practices. Ref.: https://docs.nginx.com/nginx-ingress-controller/configuration/global-configuration/command-line-arguments#cmdoption-enable-snippets

### <a name="ingress_useProxyProtocol"></a>10.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > useProxyProtocol`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

### <a name="ingress_IP"></a>10.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > ingress > IP`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** Try to use specified IP as loadbalancer IP

| Restrictions                      |                                                                                                                                                                                         |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Must match regular expression** | ```^((25[0-5]\|(2[0-4]\|1\d\|[1-9]\|)\d)\.?\b){4}$``` [Test](https://regex101.com/?regex=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%24) |

## <a name="storage"></a>11. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                   | Pattern | Type   | Deprecated | Definition | Title/Description                                                    |
| ------------------------------------------ | ------- | ------ | ---------- | ---------- | -------------------------------------------------------------------- |
| - [readWriteMany](#storage_readWriteMany ) | No      | object | No         | -          | NFS based ReadWriteMany storage, requires \`mount.nfs\` on the hosts |

### <a name="storage_readWriteMany"></a>11.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

**Description:** NFS based ReadWriteMany storage, requires `mount.nfs` on the hosts

| Property                                               | Pattern | Type    | Deprecated | Definition | Title/Description |
| ------------------------------------------------------ | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#storage_readWriteMany_enabled )           | No      | boolean | No         | -          | -                 |
| - [storageClass](#storage_readWriteMany_storageClass ) | No      | object  | No         | -          | -                 |
| - [persistence](#storage_readWriteMany_persistence )   | No      | object  | No         | -          | -                 |

#### <a name="storage_readWriteMany_enabled"></a>11.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

#### <a name="storage_readWriteMany_storageClass"></a>11.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > storageClass`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                            | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [name](#storage_readWriteMany_storageClass_name ) | No      | string | No         | -          | -                 |

##### <a name="storage_readWriteMany_storageClass_name"></a>11.1.2.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > storageClass > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

#### <a name="storage_readWriteMany_persistence"></a>11.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > persistence`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                           | Pattern | Type   | Deprecated | Definition                                                                                                                                         | Title/Description                                                                                                |
| ------------------------------------------------------------------ | ------- | ------ | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| - [size](#storage_readWriteMany_persistence_size )                 | No      | object | No         | Same as [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties ) | -                                                                                                                |
| - [storageClass](#storage_readWriteMany_persistence_storageClass ) | No      | string | No         | Same as [storageClass](#global_storageClass )                                                                                                      | The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd) |

##### <a name="storage_readWriteMany_persistence_size"></a>11.1.3.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > persistence > size`

|                           |                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                  |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green)                                                               |
| **Same definition as**    | [io.k8s.apimachinery.pkg.api.resource.Quantity](#global_namespaces_additionalProperties_resources_defaults_requests_additionalProperties) |

##### <a name="storage_readWriteMany_persistence_storageClass"></a>11.1.3.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > storage > readWriteMany > persistence > storageClass`

|                        |                                      |
| ---------------------- | ------------------------------------ |
| **Type**               | `string`                             |
| **Same definition as** | [storageClass](#global_storageClass) |

**Description:** The storageClass to use for persistence, e.g. for prometheus, otherwise use the cluster default (teutostack-ssd)

## <a name="reflector"></a>12. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > reflector`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                         | Pattern | Type        | Deprecated | Definition | Title/Description |
| -------------------------------- | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [enabled](#reflector_enabled ) | No      | Combination | No         | -          | -                 |

### <a name="reflector_enabled"></a>12.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > reflector > enabled`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| One of(Option)                        |
| ------------------------------------- |
| [item 0](#reflector_enabled_oneOf_i0) |
| [item 1](#reflector_enabled_oneOf_i1) |

#### <a name="reflector_enabled_oneOf_i0"></a>12.1.1. Property `base cluster configuration > reflector > enabled > oneOf > item 0`

|          |         |
| -------- | ------- |
| **Type** | `const` |

Specific value: `"auto"`

#### <a name="reflector_enabled_oneOf_i1"></a>12.1.2. Property `base cluster configuration > reflector > enabled > oneOf > item 1`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

## <a name="rbac"></a>13. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                      | Pattern | Type   | Deprecated | Definition | Title/Description                           |
| ----------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------- |
| - [roles](#rbac_roles )       | No      | object | No         | -          | A map of a ClusterRole name to it's rules   |
| - [accounts](#rbac_accounts ) | No      | object | No         | -          | A map of an account to it's (Cluster-)Roles |

### <a name="rbac_roles"></a>13.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > roles`

|                           |                                                                                                         |
| ------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#rbac_roles_additionalProperties) |

**Description:** A map of a ClusterRole name to it's rules

| Property                                | Pattern | Type  | Deprecated | Definition | Title/Description |
| --------------------------------------- | ------- | ----- | ---------- | ---------- | ----------------- |
| - [](#rbac_roles_additionalProperties ) | No      | array | No         | -          | -                 |

#### <a name="rbac_roles_additionalProperties"></a>13.1.1. Property `base cluster configuration > rbac > roles > additionalProperties`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                         | Description                                                                                                                                                       |
| ----------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [io.k8s.api.rbac.v1.PolicyRule](#rbac_roles_additionalProperties_items) | PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to. |

##### <a name="rbac_roles_additionalProperties_items"></a>13.1.1.1. base cluster configuration > rbac > roles > additionalProperties > io.k8s.api.rbac.v1.PolicyRule

|                           |                                                                                                                                                             |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                                                    |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red)                                                                                              |
| **Defined in**            | https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/_definitions.json#/definitions/io.k8s.api.rbac.v1.PolicyRule |

**Description:** PolicyRule holds information that describes a policy rule, but does not contain information about who the rule applies to or which namespace the rule applies to.

| Property                                                                     | Pattern | Type            | Deprecated | Definition | Title/Description                                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------------------------------------------------------------------- | ------- | --------------- | ---------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| - [apiGroups](#rbac_roles_additionalProperties_items_apiGroups )             | No      | array of string | No         | -          | APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. "" represents the core API group and "*" represents all API groups.                                                                                                                                |
| - [nonResourceURLs](#rbac_roles_additionalProperties_items_nonResourceURLs ) | No      | array of string | No         | -          | NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as "pods" or "secrets") or non-resource URL paths (such as "/api"),  but not both. |
| - [resourceNames](#rbac_roles_additionalProperties_items_resourceNames )     | No      | array of string | No         | -          | ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.                                                                                                                                                                                                                                                                                  |
| - [resources](#rbac_roles_additionalProperties_items_resources )             | No      | array of string | No         | -          | Resources is a list of resources this rule applies to. '*' represents all resources.                                                                                                                                                                                                                                                                                                                        |
| + [verbs](#rbac_roles_additionalProperties_items_verbs )                     | No      | array of string | No         | -          | Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs.                                                                                                                                                                                                                                                                                              |

###### <a name="rbac_roles_additionalProperties_items_apiGroups"></a>13.1.1.1.1. Property `base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > apiGroups`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** APIGroups is the name of the APIGroup that contains the resources.  If multiple API groups are specified, any action requested against one of the enumerated resources in any API group will be allowed. "" represents the core API group and "*" represents all API groups.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                           | Description |
| ------------------------------------------------------------------------- | ----------- |
| [apiGroups items](#rbac_roles_additionalProperties_items_apiGroups_items) | -           |

###### <a name="rbac_roles_additionalProperties_items_apiGroups_items"></a>13.1.1.1.1.1. base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > apiGroups > apiGroups items

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="rbac_roles_additionalProperties_items_nonResourceURLs"></a>13.1.1.1.2. Property `base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > nonResourceURLs`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** NonResourceURLs is a set of partial urls that a user should have access to.  *s are allowed, but only as the full, final step in the path Since non-resource URLs are not namespaced, this field is only applicable for ClusterRoles referenced from a ClusterRoleBinding. Rules can either apply to API resources (such as "pods" or "secrets") or non-resource URL paths (such as "/api"),  but not both.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                       | Description |
| ------------------------------------------------------------------------------------- | ----------- |
| [nonResourceURLs items](#rbac_roles_additionalProperties_items_nonResourceURLs_items) | -           |

###### <a name="rbac_roles_additionalProperties_items_nonResourceURLs_items"></a>13.1.1.1.2.1. base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > nonResourceURLs > nonResourceURLs items

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="rbac_roles_additionalProperties_items_resourceNames"></a>13.1.1.1.3. Property `base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > resourceNames`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** ResourceNames is an optional white list of names that the rule applies to.  An empty set means that everything is allowed.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                                   | Description |
| --------------------------------------------------------------------------------- | ----------- |
| [resourceNames items](#rbac_roles_additionalProperties_items_resourceNames_items) | -           |

###### <a name="rbac_roles_additionalProperties_items_resourceNames_items"></a>13.1.1.1.3.1. base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > resourceNames > resourceNames items

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="rbac_roles_additionalProperties_items_resources"></a>13.1.1.1.4. Property `base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > resources`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** Resources is a list of resources this rule applies to. '*' represents all resources.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                           | Description |
| ------------------------------------------------------------------------- | ----------- |
| [resources items](#rbac_roles_additionalProperties_items_resources_items) | -           |

###### <a name="rbac_roles_additionalProperties_items_resources_items"></a>13.1.1.1.4.1. base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > resources > resources items

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="rbac_roles_additionalProperties_items_verbs"></a>13.1.1.1.5. Property `base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > verbs`

|          |                   |
| -------- | ----------------- |
| **Type** | `array of string` |

**Description:** Verbs is a list of Verbs that apply to ALL the ResourceKinds contained in this rule. '*' represents all verbs.

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | N/A                |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | False              |
| **Tuple validation** | See below          |

| Each item of this array must be                                   | Description |
| ----------------------------------------------------------------- | ----------- |
| [verbs items](#rbac_roles_additionalProperties_items_verbs_items) | -           |

###### <a name="rbac_roles_additionalProperties_items_verbs_items"></a>13.1.1.1.5.1. base cluster configuration > rbac > roles > additionalProperties > additionalProperties items > verbs > verbs items

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="rbac_accounts"></a>13.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts`

|                           |                                                                                                            |
| ------------------------- | ---------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                   |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#rbac_accounts_additionalProperties) |

**Description:** A map of an account to it's (Cluster-)Roles

| Property                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| ------------------------------------------ | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#rbac_accounts_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="rbac_accounts_additionalProperties"></a>13.2.1. Property `base cluster configuration > rbac > accounts > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                            | Pattern | Type   | Deprecated | Definition | Title/Description                           |
| ------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ------------------------------------------- |
| - [roles](#rbac_accounts_additionalProperties_roles )               | No      | object | No         | -          | A map of a role to it's intended namespaces |
| - [clusterRoles](#rbac_accounts_additionalProperties_clusterRoles ) | No      | array  | No         | -          | -                                           |

##### <a name="rbac_accounts_additionalProperties_roles"></a>13.2.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts > additionalProperties > roles`

|                           |                                                                                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                              |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#rbac_accounts_additionalProperties_roles_additionalProperties) |

**Description:** A map of a role to it's intended namespaces

| Property                                                              | Pattern | Type  | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------- | ------- | ----- | ---------- | ---------- | ----------------- |
| - [](#rbac_accounts_additionalProperties_roles_additionalProperties ) | No      | array | No         | -          | -                 |

###### <a name="rbac_accounts_additionalProperties_roles_additionalProperties"></a>13.2.1.1.1. Property `base cluster configuration > rbac > accounts > additionalProperties > roles > additionalProperties`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | True               |
| **Tuple validation** | N/A                |

##### <a name="rbac_accounts_additionalProperties_clusterRoles"></a>13.2.1.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > rbac > accounts > additionalProperties > clusterRoles`

|          |         |
| -------- | ------- |
| **Type** | `array` |

|                      | Array restrictions |
| -------------------- | ------------------ |
| **Min items**        | 1                  |
| **Max items**        | N/A                |
| **Items unicity**    | False              |
| **Additional items** | True               |
| **Tuple validation** | N/A                |

## <a name="backup"></a>14. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `combining`                                                    |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                    | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ----------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#backup_resourcesPreset )               | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#backup_resources )                           | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |
| - [backupStorageLocations](#backup_backupStorageLocations ) | No      | object           | No         | -                                                                             | -                                                                 |
| - [defaultLocation](#backup_defaultLocation )               | No      | string           | No         | -                                                                             | -                                                                 |
| - [nodeAgent](#backup_nodeAgent )                           | No      | object           | No         | -                                                                             | -                                                                 |

| One of(Option)             |
| -------------------------- |
| [item 0](#backup_oneOf_i0) |
| [item 1](#backup_oneOf_i1) |

### <a name="backup_oneOf_i0"></a>14.1. Property `base cluster configuration > backup > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [backupStorageLocations](#backup_oneOf_i0_backupStorageLocations ) | No      | object | No         | -          | -                 |

#### <a name="autogenerated_heading_32"></a>14.1.1. The following properties are required
* defaultLocation

#### <a name="backup_oneOf_i0_backupStorageLocations"></a>14.1.2. Property `base cluster configuration > backup > oneOf > item 0 > backupStorageLocations`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="backup_oneOf_i1"></a>14.2. Property `base cluster configuration > backup > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Property                                                             | Pattern | Type   | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [backupStorageLocations](#backup_oneOf_i1_backupStorageLocations ) | No      | object | No         | -          | -                 |

#### <a name="backup_oneOf_i1_backupStorageLocations"></a>14.2.1. Property `base cluster configuration > backup > oneOf > item 1 > backupStorageLocations`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

### <a name="backup_resourcesPreset"></a>14.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

### <a name="backup_resources"></a>14.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

### <a name="backup_backupStorageLocations"></a>14.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations`

|                           |                                                                                                                            |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                                                                   |
| **Additional properties** | [![Should-conform](https://img.shields.io/badge/Should-conform-blue)](#backup_backupStorageLocations_additionalProperties) |

| Property                                                   | Pattern | Type   | Deprecated | Definition | Title/Description |
| ---------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| - [](#backup_backupStorageLocations_additionalProperties ) | No      | object | No         | -          | -                 |

#### <a name="backup_backupStorageLocations_additionalProperties"></a>14.5.1. Property `base cluster configuration > backup > backupStorageLocations > additionalProperties`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                    | Pattern | Type   | Deprecated | Definition | Title/Description |
| --------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | ----------------- |
| + [provider](#backup_backupStorageLocations_additionalProperties_provider ) | No      | object | No         | -          | -                 |
| + [bucket](#backup_backupStorageLocations_additionalProperties_bucket )     | No      | string | No         | -          | -                 |
| - [prefix](#backup_backupStorageLocations_additionalProperties_prefix )     | No      | string | No         | -          | -                 |

##### <a name="backup_backupStorageLocations_additionalProperties_provider"></a>14.5.1.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                       | Pattern | Type        | Deprecated | Definition | Title/Description |
| ------------------------------------------------------------------------------ | ------- | ----------- | ---------- | ---------- | ----------------- |
| - [minio](#backup_backupStorageLocations_additionalProperties_provider_minio ) | No      | Combination | No         | -          | -                 |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio"></a>14.5.1.1.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `combining`                                                    |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                                 | Pattern | Type    | Deprecated | Definition | Title/Description |
| -------------------------------------------------------------------------------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [accessKeyID](#backup_backupStorageLocations_additionalProperties_provider_minio_accessKeyID )         | No      | string  | No         | -          | -                 |
| - [secretAccessKey](#backup_backupStorageLocations_additionalProperties_provider_minio_secretAccessKey ) | No      | string  | No         | -          | -                 |
| - [existingSecret](#backup_backupStorageLocations_additionalProperties_provider_minio_existingSecret )   | No      | object  | No         | -          | -                 |
| + [url](#backup_backupStorageLocations_additionalProperties_provider_minio_url )                         | No      | string  | No         | -          | -                 |
| - [region](#backup_backupStorageLocations_additionalProperties_provider_minio_region )                   | No      | string  | No         | -          | -                 |
| - [forcePathStyle](#backup_backupStorageLocations_additionalProperties_provider_minio_forcePathStyle )   | No      | boolean | No         | -          | -                 |

| One of(Option)                                                                        |
| ------------------------------------------------------------------------------------- |
| [item 0](#backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i0) |
| [item 1](#backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i1) |
| [item 2](#backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2) |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i0"></a>14.5.1.1.1.1. Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > oneOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_33"></a>14.5.1.1.1.1.1. The following properties are required
* accessKeyID
* secretAccessKey

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i1"></a>14.5.1.1.1.2. Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > oneOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_34"></a>14.5.1.1.1.2.1. The following properties are required
* existingSecret

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2"></a>14.5.1.1.1.3. Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > oneOf > item 2`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_35"></a>14.5.1.1.1.3.1. Must **not** be

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `combining`                                                                 |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

| Any of(Option)                                                                                     |
| -------------------------------------------------------------------------------------------------- |
| [item 0](#backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2_not_anyOf_i0) |
| [item 1](#backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2_not_anyOf_i1) |
| [item 2](#backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2_not_anyOf_i2) |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2_not_anyOf_i0"></a>14.5.1.1.1.3.1.1. Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > oneOf > item 2 > not > anyOf > item 0`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_36"></a>14.5.1.1.1.3.1.1.1. The following properties are required
* accessKeyID

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2_not_anyOf_i1"></a>14.5.1.1.1.3.1.2. Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > oneOf > item 2 > not > anyOf > item 1`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_37"></a>14.5.1.1.1.3.1.2.1. The following properties are required
* secretAccessKey

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_oneOf_i2_not_anyOf_i2"></a>14.5.1.1.1.3.1.3. Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > oneOf > item 2 > not > anyOf > item 2`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

###### <a name="autogenerated_heading_38"></a>14.5.1.1.1.3.1.3.1. The following properties are required
* existingSecret

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_accessKeyID"></a>14.5.1.1.1.4. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > accessKeyID`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_secretAccessKey"></a>14.5.1.1.1.5. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > secretAccessKey`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_existingSecret"></a>14.5.1.1.1.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > existingSecret`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                                                          | Pattern | Type   | Deprecated | Definition | Title/Description                                        |
| ------------------------------------------------------------------------------------------------- | ------- | ------ | ---------- | ---------- | -------------------------------------------------------- |
| + [name](#backup_backupStorageLocations_additionalProperties_provider_minio_existingSecret_name ) | No      | string | No         | -          | -                                                        |
| - [key](#backup_backupStorageLocations_additionalProperties_provider_minio_existingSecret_key )   | No      | string | No         | -          | The default is <$providerName-$name> (e.g. 'minio-prod') |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_existingSecret_name"></a>14.5.1.1.1.6.1. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > existingSecret > name`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_existingSecret_key"></a>14.5.1.1.1.6.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > existingSecret > key`

|          |          |
| -------- | -------- |
| **Type** | `string` |

**Description:** The default is <$providerName-$name> (e.g. 'minio-prod')

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_url"></a>14.5.1.1.1.7. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > url`

|          |          |
| -------- | -------- |
| **Type** | `string` |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_region"></a>14.5.1.1.1.8. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > region`

|             |             |
| ----------- | ----------- |
| **Type**    | `string`    |
| **Default** | `"Region1"` |

###### <a name="backup_backupStorageLocations_additionalProperties_provider_minio_forcePathStyle"></a>14.5.1.1.1.9. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > provider > minio > forcePathStyle`

|             |           |
| ----------- | --------- |
| **Type**    | `boolean` |
| **Default** | `true`    |

##### <a name="backup_backupStorageLocations_additionalProperties_bucket"></a>14.5.1.2. ![Required](https://img.shields.io/badge/Required-blue) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > bucket`

|          |          |
| -------- | -------- |
| **Type** | `string` |

##### <a name="backup_backupStorageLocations_additionalProperties_prefix"></a>14.5.1.3. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > backupStorageLocations > additionalProperties > prefix`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="backup_defaultLocation"></a>14.6. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > defaultLocation`

|          |          |
| -------- | -------- |
| **Type** | `string` |

### <a name="backup_nodeAgent"></a>14.7. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > nodeAgent`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                                                | Pattern | Type             | Deprecated | Definition                                                                    | Title/Description                                                 |
| ------------------------------------------------------- | ------- | ---------------- | ---------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| - [resourcesPreset](#backup_nodeAgent_resourcesPreset ) | No      | enum (of string) | No         | Same as [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset ) | -                                                                 |
| - [resources](#backup_nodeAgent_resources )             | No      | object           | No         | Same as [resources](#global_authentication_oauthProxy_resources )             | ResourceRequirements describes the compute resource requirements. |

#### <a name="backup_nodeAgent_resourcesPreset"></a>14.7.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > nodeAgent > resourcesPreset`

|                        |                                                                      |
| ---------------------- | -------------------------------------------------------------------- |
| **Type**               | `enum (of string)`                                                   |
| **Same definition as** | [resourcesPreset](#global_authentication_oauthProxy_resourcesPreset) |

#### <a name="backup_nodeAgent_resources"></a>14.7.2. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > backup > nodeAgent > resources`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |
| **Same definition as**    | [resources](#global_authentication_oauthProxy_resources)                    |

**Description:** ResourceRequirements describes the compute resource requirements.

## <a name="kube-janitor"></a>15. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kube-janitor`

|                           |                                                                |
| ------------------------- | -------------------------------------------------------------- |
| **Type**                  | `object`                                                       |
| **Additional properties** | ![Not allowed](https://img.shields.io/badge/Not%20allowed-red) |

| Property                            | Pattern | Type    | Deprecated | Definition | Title/Description |
| ----------------------------------- | ------- | ------- | ---------- | ---------- | ----------------- |
| - [enabled](#kube-janitor_enabled ) | No      | boolean | No         | -          | -                 |

### <a name="kube-janitor_enabled"></a>15.1. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > kube-janitor > enabled`

|          |           |
| -------- | --------- |
| **Type** | `boolean` |

## <a name="common"></a>16. ![Optional](https://img.shields.io/badge/Optional-yellow) Property `base cluster configuration > common`

|                           |                                                                             |
| ------------------------- | --------------------------------------------------------------------------- |
| **Type**                  | `object`                                                                    |
| **Additional properties** | ![Any type: allowed](https://img.shields.io/badge/Any%20type-allowed-green) |

**Description:** Values for sub-chart

----------------------------------------------------------------------------------------------------------------------------

