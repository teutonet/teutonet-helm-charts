{{- define "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.specHash" -}}
  {{/* the full context is needed for .Files.Get */}}
  {{- $inputs := dict "spec" (include "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.spec" $) -}}
  {{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.preKubeadmCommands" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $commands := list -}}
  {{- $commands = append $commands "bash /etc/kube-proxy-patch.sh" -}}
  {{- if .Values.global.injectedCertificateAuthorities -}}
    {{- $commands = append $commands "update-ca-certificates" -}}
  {{- end -}}
  {{- toYaml $commands }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.files" -}}
  {{- $files := list -}}
  {{- $files = concat $files (include "t8s-cluster.clusterClass.configTemplate.files" (dict "context" . "gpu" false) | fromYamlArray) -}}
  {{- $configs := dict
    "admission-control-config.yaml" (required "Missing" .admissionControlConfigFilePath)
    "event-rate-limit-config.yaml" (required "Missing" .eventRateLimitConfigFilePath)
    "kube-proxy.config.yaml" "/etc/kube-proxy-config.yaml"
  -}}
  {{- range $file, $path := $configs -}}
    {{- $files = append $files (dict "content" ($.Files.Get (printf "files/%s" $file)) "path" $path) -}}
  {{- end -}}
  {{- $files = append $files (dict "content" (.Files.Get "files/kube-proxy.patch.sh") "path" "/etc/kube-proxy-patch.sh" "permissions" "0700") -}}
  {{- range $file := $files -}}
    {{- $_ := set $file "content" (get $file "content" | trim) -}}
  {{- end -}}
  {{- $apiserverPatch := dict "spec" (dict "containers" (list (dict "name" "kube-apiserver" "resources" (dict "requests" (dict "memory" "2Gi") "limits" (dict "memory" "4Gi"))))) -}}
  {{- $files = append $files (include "t8s-cluster.patches.patchFile" (dict "values" $apiserverPatch "target" "kube-apiserver" "component" "memory") | fromYaml) -}}
  {{- toYaml $files -}}
{{- end -}}
