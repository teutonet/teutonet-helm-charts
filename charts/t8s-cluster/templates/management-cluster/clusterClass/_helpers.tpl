{{- define "t8s-cluster.clusterClass.infrastructureApiVersion" -}}
infrastructure.cluster.x-k8s.io/v1beta1
{{- end -}}

{{- define "t8s-cluster.clusterClass.cloudName" -}}
openstack
{{- end -}}

{{- define "t8s-cluster.clusterClass.getIdentityRefSecretName" -}}
  {{- $_ := mustMerge . (pick .context "Release") -}}
  {{- printf "%s-cloud-config" .Release.Name -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.tlsCipherSuites" -}}
  {{- $cipherSuites := list "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256" "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256" "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305" "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384" "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305" "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" "TLS_RSA_WITH_AES_256_GCM_SHA384" "TLS_RSA_WITH_AES_128_GCM_SHA256" -}}
  {{- $cipherSuites | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.preKubeadmCommands" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $commands := list -}}
  {{- if .Values.global.injectedCertificateAuthorities -}}
    {{- $commands = append $commands "update-ca-certificates" -}}
  {{- end -}}
  {{- toYaml $commands }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.postKubeadmCommands" -}}
  {{- $commands := list -}}
  {{- toYaml $commands }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.kubeletExtraArgs" -}}
  {{- $args := dict "cloud-provider" "external" -}}
  {{- toYaml $args -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.containerdConfig.plugins" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
[plugins]
  [plugins."io.containerd.grpc.v1.cri"]
    {{- if .Values.containerRegistryMirror.mirrorEndpoint }}
    [plugins."io.containerd.grpc.v1.cri".registry]
      config_path = "/etc/containerd/registries.conf.d"
    {{- end }}
    [plugins."io.containerd.grpc.v1.cri".containerd]
      default_runtime_name = "runc"
      [plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
        # TODO: this is only needed because of https://github.com/containerd/containerd/issues/5837
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
          runtime_type = "io.containerd.runc.v2"
          # TODO: this is only needed because of https://github.com/containerd/containerd/issues/5837
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
            SystemdCgroup = true
        {{- if .gpu }}
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia]
          privileged_without_host_devices = false
          runtime_engine = ""
          runtime_root = ""
          runtime_type = "io.containerd.runc.v2"
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options]
            BinaryName = "/usr/local/nvidia/toolkit/nvidia-container-runtime"
        {{- end -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.containerdConfig.containerRegistryMirrorConfigs.content" -}}
server = {{ printf "https://%s" .registry | quote }}
{{ printf `[host."%s"]` .endpoint }}
  capabilities = ["pull", "resolve"]
{{- end -}}

{{- define "t8s-cluster.featureGates" -}}
{{/*  {{- (dict "SeccompDefault" (list "kubelet")) | toYaml -}}*/}}
  {{- (dict) | toYaml -}}
{{- end -}}

{{- define  "t8s-cluster.featureGates.forComponent" -}}
  {{- $featureGates := dict -}}
  {{- $component := .component -}}
  {{- range $featureGate, $components := include "t8s-cluster.featureGates" (dict) | fromYaml -}}
    {{- if $components | has $component -}}
      {{- $featureGates = set $featureGates $featureGate true -}}
    {{- end -}}
  {{- end -}}
  {{- $featureGates | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.containerdConfig.containerRegistryMirrorConfigs" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $defaultMirroredRegistries := list
    "gcr.io"
    "ghcr.io"
    "k8s.gcr.io"
    "nvcr.io"
    "quay.io"
    "registry.gitlab.com"
    "registry.k8s.io"
    "registry.opensource.zalan.do"
    "registry.teuto.io"
    -}}
  {{- $mirroredRegistries := concat $defaultMirroredRegistries (.Values.containerRegistryMirror.additionallyMirroredRegistries | default list) | sortAlpha | uniq -}}
  {{- $files := list -}}
  {{- range $registry := $mirroredRegistries }}
    {{- $files = append $files (dict "content" (include "t8s-cluster.clusterClass.containerdConfig.containerRegistryMirrorConfigs.content" (dict "registry" $registry "endpoint" $.Values.containerRegistryMirror.mirrorEndpoint)) "path" (printf `/etc/containerd/registries.conf.d/%s/hosts.toml` $registry)) -}}
  {{- end }}
  {{- $files = append $files (dict "content" (include "t8s-cluster.clusterClass.containerdConfig.containerRegistryMirrorConfigs.content" (dict "registry" "registry-1.docker.io" "endpoint" $.Values.containerRegistryMirror.mirrorEndpoint)) "path" "/etc/containerd/registries.conf.d/docker.io/hosts.toml") -}}
  {{- $files | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.configTemplate.files" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $files := list -}}
  {{- if not .excludePatches -}}
    {{- $files = concat $files (include "t8s-cluster.patches.kubelet.patches" (dict "context" .context) | fromYamlArray) -}}
  {{- end -}}
  {{- if .Values.containerRegistryMirror.mirrorEndpoint -}}
    {{- $files = concat $files (include "t8s-cluster.clusterClass.containerdConfig.containerRegistryMirrorConfigs" (dict "context" .context) | fromYamlArray) -}}
  {{- end -}}
  {{- $files = append $files (dict "content" (include "t8s-cluster.clusterClass.containerdConfig.plugins" (dict "context" .context "gpu" .gpu)) "path" "/etc/containerd/conf.d/plugins.toml" ) -}}
  {{- if .Values.global.injectedCertificateAuthorities }}
    {{- $files = append $files (dict "content" .Values.global.injectedCertificateAuthorities "path" "/usr/local/share/ca-certificates/injected-ca-certs.crt" ) -}}
  {{- end }}
  {{- $files | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.base" -}}
  {{- dict "profiling" "false" | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.shared" -}}
  {{- $args := include "t8s-cluster.clusterClass.args.base" (dict) | fromYaml -}}
  {{- $args = mustMerge (dict
    "authorization-always-allow-paths" (list "/healthz" "/readyz" "/livez" "/metrics" | join ",")
    "bind-address" "0.0.0.0"
    ) $args -}}
  {{- $args | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.scheduler" -}}
  {{- include "t8s-cluster.clusterClass.args.shared" (dict) -}}
{{- end }}

{{- define "t8s-cluster.clusterClass.args.sharedController" -}}
  {{- $args := dict "cloud-provider" "external" -}}
  {{- toYaml $args -}}
{{- end }}

{{- define "t8s-cluster.clusterClass.args.controllerManager" -}}
  {{- $args := include "t8s-cluster.clusterClass.args.shared" (dict) | fromYaml -}}
  {{- $args = mustMerge (include "t8s-cluster.clusterClass.args.sharedController" (dict "context" .context) | fromYaml) $args -}}
  {{- $args = set $args "terminated-pod-gc-threshold" "100" -}}
  {{- $args | toYaml -}}
{{- end }}

{{- define "t8s-cluster.clusterClass.apiServer.admissionPlugins" -}}
  {{- $admissionPlugins := list "AlwaysPullImages" "NodeRestriction" -}}
  {{- if not .excludePatches -}}
    {{- $admissionPlugins = concat $admissionPlugins (list "EventRateLimit") -}}
  {{- end -}}
  {{- $admissionPlugins | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.apiServer" -}}
  {{- $args := include "t8s-cluster.clusterClass.args.base" (dict "context" .context) | fromYaml -}}
  {{- $args = mustMerge (include "t8s-cluster.clusterClass.args.sharedController" (dict "context" .context) | fromYaml) $args -}}
  {{- $args = set $args "enable-admission-plugins" (include "t8s-cluster.clusterClass.apiServer.admissionPlugins" (dict "excludePatches" .excludePatches) | fromYamlArray | join ",") -}}
  {{- $args = set $args "event-ttl" "4h" -}}
  {{- $args = set $args "tls-cipher-suites" (include "t8s-cluster.clusterClass.tlsCipherSuites" (dict) | fromYamlArray | join ",") -}}
  {{- $args | toYaml -}}
{{- end }}
