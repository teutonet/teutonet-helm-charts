{{- define "t8s-cluster.clusterClass.containerdConfig.plugins" -}}
[plugins]
  [plugins."io.containerd.grpc.v1.cri"]
  {{- $_ := set . "Values" .context.Values -}}
  {{- if .Values.containerRegistryProxy.proxyRegistryEndpoint }}
    [plugins."io.containerd.grpc.v1.cri".registry]
      config_path = "/etc/containerd/registries.conf.d"
  {{- end }}
  {{- if .gpu }}
    [plugins."io.containerd.grpc.v1.cri".containerd]
      default_runtime_name = "runc"
      [plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
        # TODO: this is only needed because of https://github.com/containerd/containerd/issues/5837
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
          runtime_type = "io.containerd.runc.v2"
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
            SystemdCgroup = true
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
          privileged_without_host_devices = false
          runtime_engine = ""
          runtime_root = ""
          runtime_type = "io.containerd.runc.v2"
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options]
            BinaryName = "/usr/local/nvidia/toolkit/nvidia-container-runtime"
  {{- end -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.containerdConfig.containerRegistryProxyConfigs" -}}
  {{- $_ := set . "Values" .context.Values -}}
  {{- $defaultProxiedRegistries := list
    "gcr.io"
    "ghcr.io"
    "k8s.gcr.io"
    "quay.io"
    "registry.gitlab.com"
    "registry.k8s.io"
    "registry.opensource.zalan.do"
    "registry.teuto.io"
    -}}
  {{- $proxiedRegistries := concat $defaultProxiedRegistries (.Values.containerRegistryProxy.additionallyProxiedRegistries | default list) | sortAlpha | uniq -}}
  {{- range $registry := $proxiedRegistries }}
- content: |-
    server = {{ printf "https://%s" $registry | quote }}
    {{ printf `[host."%s"]` $.Values.containerRegistryProxy.proxyRegistryEndpoint }}
      capabilities = ["pull", "resolve"]
  path: {{ printf `/etc/containerd/registries.conf.d/%s/hosts.toml` $registry }}
  {{- end }}
- content: |-
    server = "registry-1.docker.io"
    {{ printf `[host."%s"]` $.Values.containerRegistryProxy.proxyRegistryEndpoint }}
      capabilities = ["pull", "resolve"]
  path: /etc/containerd/registries.conf.d/docker.io/hosts.toml
- content: |- # this only works with containerd >=1.7.0, that's why the above still exists
    server = "*"
    {{ printf `[host."%s"]` $.Values.containerRegistryProxy.proxyRegistryEndpoint }}
      capabilities = ["pull", "resolve"]
  path: /etc/containerd/registries.conf.d/_default/hosts.toml
{{- end -}}
