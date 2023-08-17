{{- define "t8s-cluster.clusterClass.containerdConfig.containerRegistryProxyConfigs" -}}
- content: |-
    [plugins]
      [plugins."io.containerd.grpc.v1.cri".registry]
        config_path = "/etc/containerd/registries.conf.d"
  path: /etc/containerd/conf.d/teuto-mirror.toml
  {{- $_ := set . "Values" .context.Values -}}
  {{- $defaultProxiedRegistries := list
    "docker.io"
    "gcr.io"
    "ghcr.io"
    "hub.docker.com"
    "k8s.gcr.io"
    "quay.io"
    "registry.gitlab.com"
    "registry.k8s.io"
    "registry.opensource.zalan.do"
    "registry.teuto.io"
    "index.docker.io"
    -}}
  {{- $proxiedRegistries := concat $defaultProxiedRegistries (.Values.containerRegistryProxy.additionallyProxiedRegistries | default list) | sortAlpha | uniq -}}
  {{- range $registry := $proxiedRegistries }}
- content: |-
    {{ printf `[host."%s%s"]` $.Values.containerRegistryProxy.proxyRegistryEndpoint $registry }}
      capabilities = ["pull", "resolve"]
  path: {{ printf `/etc/containerd/registries.conf.d/%s/hosts.toml` $registry }}
  {{- end -}}
{{- end -}}
