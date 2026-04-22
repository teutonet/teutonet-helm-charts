{{- define "t8s-cluster.hostedControlPlane.apiServerHost" -}}
  {{- $gateway := lookup "gateway.networking.k8s.io/v1" "Gateway" "capi-hosted-control-plane-system" "controlplane" -}}
  {{- if not $gateway -}}
    {{- fail "Hosted control plane Gateway 'controlplane' in namespace 'capi-hosted-control-plane-system' not found" -}}
  {{- else -}}
    {{- printf "%s.%s.%s" .Release.Name .Release.Namespace (replace "*." "" (index $gateway.spec.listeners 0).hostname) -}}
  {{- end -}}
{{- end -}}

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
  {{- toYaml $cipherSuites -}}
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

{{- define "t8s-cluster.clusterClass.argsMapToArray" }}
  {{- $argsArray := list -}}
  {{- range $key, $value := .args -}}
    {{- $argsArray = append $argsArray (dict "name" $key "value" $value) -}}
  {{- end -}}
  {{- toYaml $argsArray -}}
{{- end -}}

{{/* this can be split up with containerd >=2.0.0 */}}
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
  {{- $featureGates := (dict "ImageVolume" (list "apiserver" "kubelet")) -}}
  {{- if semverCompare ">=1.33.0 <1.35.0" (include "t8s-cluster.k8s-version" .context) -}}
    {{- $featureGates = set $featureGates "KubeletEnsureSecretPulledImages" (list "kubelet") -}}
  {{- end -}}
  {{- if semverCompare ">=1.32.0" (include "t8s-cluster.k8s-version" .context) -}}
    {{- $featureGates = set $featureGates "MutatingAdmissionPolicy" (list "apiserver") -}}
  {{- end -}}
  {{- toYaml $featureGates -}}
{{- end -}}

{{- define  "t8s-cluster.featureGates.forComponent" -}}
  {{- $featureGates := dict -}}
  {{- $component := .component -}}
  {{- range $featureGate, $components := include "t8s-cluster.featureGates" (dict "context" .context) | fromYaml -}}
    {{- if $components | has $component -}}
      {{- $featureGates = set $featureGates $featureGate true -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $featureGates -}}
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
  {{- toYaml $files -}}
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
  {{- toYaml $files -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.base" -}}
  {{- dict "profiling" "false" | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.shared" -}}
  {{- $args := include "t8s-cluster.clusterClass.args.base" (dict) | fromYaml -}}
  {{- toYaml $args -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.scheduler" -}}
  {{- include "t8s-cluster.clusterClass.args.shared" (dict) -}}
{{- end }}

{{- define "t8s-cluster.clusterClass.args.sharedController" -}}
  {{- $args := dict -}}
  {{- if semverCompare "<1.33.0" (include "t8s-cluster.k8s-version" .context) -}}
    {{- $args = set $args "cloud-provider" "external" -}}
  {{- end -}}
  {{- toYaml $args -}}
{{- end }}

{{- define "t8s-cluster.clusterClass.args.controllerManager" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $args := include "t8s-cluster.clusterClass.args.shared" (dict) | fromYaml -}}
  {{- $args = mustMerge (include "t8s-cluster.clusterClass.args.sharedController" (dict "context" .context) | fromYaml) $args -}}
  {{- $args = set $args "terminated-pod-gc-threshold" "100" -}}
  {{- if .Values.controlPlane.hosted -}}
    {{- $args = set $args "allocate-node-cidrs" "true" -}}
  {{- end }}
  {{- toYaml $args -}}
{{- end }}

{{- define "t8s-cluster.clusterClass.apiServer.admissionPlugins" -}}
  {{- $admissionPlugins := list "NodeRestriction" "EventRateLimit" -}}
  {{- if semverCompare "<1.33.0" (include "t8s-cluster.k8s-version" .context) -}}
    {{- $admissionPlugins = append $admissionPlugins "AlwaysPullImages" -}}
  {{- end -}}
  {{- toYaml ($admissionPlugins | sortAlpha) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.configPath" -}}
/etc/kubernetes
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.authenticationConfigPath" -}}
{{- include "t8s-cluster.clusterClass.configPath" (dict) -}}/{{- include "t8s-cluster.clusterClass.apiServer.authenticationConfigFileName" (dict) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.eventRateLimitConfigPath" -}}
{{- include "t8s-cluster.clusterClass.configPath" (dict) -}}/{{- include "t8s-cluster.clusterClass.apiServer.eventRateLimitConfigFileName" (dict) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.admissionControlConfigPath" -}}
{{- include "t8s-cluster.clusterClass.configPath" (dict) -}}/{{- include "t8s-cluster.clusterClass.apiServer.admissionControlConfigFileName" (dict) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.authenticationConfigFileName" -}}
authentication-config.yaml
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.eventRateLimitConfigFileName" -}}
event-rate-limit-config.yaml
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.admissionControlConfigFileName" -}}
admission-control-config.yaml
{{- end -}}

{{- define "t8s-cluster.clusterClass.args.apiServer" -}}
  {{- $args := include "t8s-cluster.clusterClass.args.base" (dict "context" .context) | fromYaml -}}
  {{- $args = mustMerge (include "t8s-cluster.clusterClass.args.sharedController" (dict "context" .context) | fromYaml) $args -}}
  {{- $args = set $args "authentication-config" (include "t8s-cluster.clusterClass.apiServer.authenticationConfigPath" (dict)) -}}
  {{- $args = set $args "admission-control-config-file" (include "t8s-cluster.clusterClass.apiServer.admissionControlConfigPath" (dict)) -}}
  {{- $args = set $args "enable-admission-plugins" (include "t8s-cluster.clusterClass.apiServer.admissionPlugins" (dict "context" .context) | fromYamlArray | join ",") -}}
  {{- $args = set $args "event-ttl" "4h" -}}
  {{- $args = set $args "tls-cipher-suites" (include "t8s-cluster.clusterClass.tlsCipherSuites" (dict) | fromYamlArray | join ",") -}}
  {{- if semverCompare ">=1.32.0" (include "t8s-cluster.k8s-version" .context) -}}
    {{- $args = set $args "runtime-config" "admissionregistration.k8s.io/v1beta1=true" -}}
  {{- end -}}
  {{- $featureFlags := list -}}
  {{- range $featureFlag, $enabled := include "t8s-cluster.featureGates.forComponent" (dict "component" "apiserver" "context" .context) | fromYaml -}}
    {{- $featureFlags = append $featureFlags (printf "%s=%t" $featureFlag $enabled) -}}
  {{- end -}}
  {{- if $featureFlags -}}
    {{- $args = set $args "feature-gates" ($featureFlags | join ",") -}}
  {{- end -}}
  {{- if .context.Values.controlPlane.audit -}}
    {{- $args = set $args "audit-policy-file" (include "t8s-cluster.clusterClass.apiServer.auditPolicyPath" (dict)) -}}
    {{- $args = set $args "audit-webhook-config-file" (include "t8s-cluster.clusterClass.apiServer.auditWebhookConfigPath" (dict)) -}}
  {{- end -}}
  {{- toYaml $args -}}
{{- end }}

{{- define "t8s-cluster.clusterClass.apiServer.staticFiles" -}}
  {{- toYaml (dict
      (include "t8s-cluster.clusterClass.apiServer.admissionControlConfigFileName" (dict)) (dict
        "path" (include "t8s-cluster.clusterClass.apiServer.admissionControlConfigPath" (dict))
        "fileName" (include "t8s-cluster.clusterClass.apiServer.admissionControlConfigFileName" (dict))
      )
      (include "t8s-cluster.clusterClass.apiServer.eventRateLimitConfigFileName" (dict)) (dict
        "path" (include "t8s-cluster.clusterClass.apiServer.eventRateLimitConfigPath" (dict))
        "fileName" (include "t8s-cluster.clusterClass.apiServer.eventRateLimitConfigFileName" (dict))
      )
    )
  -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditPolicyFileName" -}}
audit-policy.yaml
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditWebhookConfigFileName" -}}
audit-webhook.kubeconfig
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditPolicyPath" -}}
{{- include "t8s-cluster.clusterClass.configPath" (dict) -}}/{{- include "t8s-cluster.clusterClass.apiServer.auditPolicyFileName" (dict) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditWebhookConfigPath" -}}
{{- include "t8s-cluster.clusterClass.configPath" (dict) -}}/{{- include "t8s-cluster.clusterClass.apiServer.auditWebhookConfigFileName" (dict) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditWebhookTokenFileName" -}}
audit-webhook-token
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditWebhookTokenPath" -}}
{{- include "t8s-cluster.clusterClass.configPath" (dict) -}}/{{- include "t8s-cluster.clusterClass.apiServer.auditWebhookTokenFileName" (dict) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditPolicyRules" -}}
# Long-running requests like watches will not generate an audit event in RequestReceived.
omitStages:
  - RequestReceived
rules:
  - level: None
    users:
      - system:kube-controller-manager
      - system:kube-scheduler
      - system:apiserver
  - level: None
    resources:
      - group: coordination.k8s.io
        resources:
          - leases
      - group: ""
        resources:
          - events
  - level: Metadata
    verbs: [] # All verbs
    resources:
      - group: ""
        resources:
          - secrets
  - level: Metadata
    verbs:
      - create
      - update
      - patch
      - delete
      - deletecollection
    resources: [] # All resources
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditPolicy" -}}
apiVersion: audit.k8s.io/v1
kind: Policy
{{ include "t8s-cluster.clusterClass.apiServer.auditPolicyRules" (dict) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.auditWebhookConfig" -}}
  {{- $_ := mustMerge . (pick .context "Release") -}}
  {{- $server := printf "https://k8s.master.wazuh.teuto.net/%s/%s" .Release.Namespace .Release.Name -}}
apiVersion: v1
kind: Config
clusters:
- cluster:
    server: {{ $server }}
  name: webhook
users:
- name: kube-apiserver
  user:
    tokenFile: {{ include "t8s-cluster.clusterClass.apiServer.auditWebhookTokenPath" (dict) }}
contexts:
- context:
    cluster: webhook
    user: kube-apiserver
  name: webhook
current-context: webhook
{{- end -}}

{{- define "t8s-cluster.clusterClass.apiServer.dynamicFiles" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $files := dict
      (include "t8s-cluster.clusterClass.apiServer.authenticationConfigFileName" (dict)) (dict
        "path" (include "t8s-cluster.clusterClass.apiServer.authenticationConfigPath" (dict))
        "fileName" (include "t8s-cluster.clusterClass.apiServer.authenticationConfigFileName" (dict))
        "content" (include "t8s-cluster.clusterClass.apiServer.authenticationConfig" (dict "context" .context))
      )
  -}}
  {{- if .Values.controlPlane.audit -}}
    {{- $_ := set $files (include "t8s-cluster.clusterClass.apiServer.auditPolicyFileName" (dict)) (dict
        "path" (include "t8s-cluster.clusterClass.apiServer.auditPolicyPath" (dict))
        "fileName" (include "t8s-cluster.clusterClass.apiServer.auditPolicyFileName" (dict))
        "content" (include "t8s-cluster.clusterClass.apiServer.auditPolicy" (dict))
      )
    -}}
    {{- $_ = set $files (include "t8s-cluster.clusterClass.apiServer.auditWebhookConfigFileName" (dict)) (dict
        "path" (include "t8s-cluster.clusterClass.apiServer.auditWebhookConfigPath" (dict))
        "fileName" (include "t8s-cluster.clusterClass.apiServer.auditWebhookConfigFileName" (dict))
        "content" (include "t8s-cluster.clusterClass.apiServer.auditWebhookConfig" (dict "context" .context))
      )
    -}}
    {{- $_ = set $files (include "t8s-cluster.clusterClass.apiServer.auditWebhookTokenFileName" (dict)) (dict
        "path" (include "t8s-cluster.clusterClass.apiServer.auditWebhookTokenPath" (dict))
        "fileName" (include "t8s-cluster.clusterClass.apiServer.auditWebhookTokenFileName" (dict))
        "contentFrom" (dict "secret" (dict "name" "wazuh-audit-webhook" "key" "token"))
      )
    -}}
  {{- end -}}
  {{- toYaml $files -}}
{{- end -}}
