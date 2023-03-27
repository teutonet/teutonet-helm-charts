{{- define "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.specHash" -}}
  {{- $inputs := (dict
    "spec" (include "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.spec" .)
    ) -}}
  {{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.tlsCipherSuites" -}}
  {{- $cipherSuites := list "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256" "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256" "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305" "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384" "TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305" "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384" "TLS_RSA_WITH_AES_256_GCM_SHA384" "TLS_RSA_WITH_AES_128_GCM_SHA256" -}}
  {{- dict "tlsCipherSuites" $cipherSuites | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.kubeletExtraArgs" -}}
  {{- $args := dict
    "cloud-provider" "external"
        -}}
  {{- $args | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.preKudeadmCommands" -}}
  {{- $commands := list -}}
  {{- $commands = append $commands "bash /etc/kube-proxy-patch.sh" }}
  {{- if .Files.Get "files/CA.crt" -}}
    {{- $commands = append $commands "update-ca-certificates" -}}
  {{- end -}}
  {{- $commands | toYaml }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.kubeletConfiguration" -}}
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
eventRecordQPS: 0
{{- $featureGates := dict "SeccompDefault" "true" }}
featureGates: {{- $featureGates | toYaml | nindent 2 }}
seccompDefault: true
protectKernelDefaults: true
{{- include "t8s-cluster.clusterClass.tlsCipherSuites" (dict) | nindent 0 }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.containerRegistryProxies" -}}
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
[plugins]
  [plugins."io.containerd.grpc.v1.cri".registry]
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
      {{- range $registry := $proxiedRegistries }}
      {{ printf `[plugins."io.containerd.grpc.v1.cri".registry.mirrors."%s"]` $registry }}
        endpoint = {{ printf `["%s%s"]` $.Values.containerRegistryProxy.proxyRegistryEndpoint $registry }}
      {{- end -}}
{{- end -}}
