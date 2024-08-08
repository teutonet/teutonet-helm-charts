{{- define "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.specHash" -}}
  {{/* the full context is needed for .Files.Get */}}
  {{- $inputs := (dict
    "spec" (include "t8s-cluster.clusterClass.kubeadmControlPlaneTemplate.spec" $)
    ) -}}
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
  {{- $apiServerConfigDir := include "t8s-cluster.clusterClass.apiServer.configDir" (dict) -}}
  {{- $admissionControlConfigFileName := include "t8s-cluster.clusterClass.apiServer.admissionControlConfigFileName" (dict) -}}
  {{- $eventRateLimitConfigFileName := include "t8s-cluster.clusterClass.apiServer.eventRateLimitConfigFileName" (dict) -}}
  {{- $files := list -}}
  {{- $files = concat $files (include "t8s-cluster.clusterClass.configTemplate.files" (dict "context" . "gpu" false) | fromYamlArray) -}}
  {{- $configs := dict
    $eventRateLimitConfigFileName $apiServerConfigDir
    "kube-proxy.config.yaml" "/etc"
  -}}
  {{- $files = append $files (dict "content" (include "t8s-cluster.clusterClass.apiServer.admissionControlConfigFile" (dict)) "path" (printf "%s/%s" $apiServerConfigDir $admissionControlConfigFileName)) -}}
  {{- range $file, $dir := $configs -}}
    {{- $files = append $files (dict "content" ($.Files.Get (printf "files/%s" $file)) "path" (printf "%s/%s" $dir $file)) -}}
  {{- end -}}
  {{- $files = append $files (dict "content" (.Files.Get "files/kube-proxy.patch.sh") "path" "/etc/kube-proxy-patch.sh" "permissions" "0500") -}}
  {{- $apiserverPatch := dict "spec" (dict "containers" (list (dict "name" "kube-apiserver" "resources" (dict "requests" (dict "memory" "2Gi") "limits" (dict "memory" "4Gi"))))) -}}
  {{- $files = append $files (include "t8s-cluster.patches.patchFile" (dict "values" $apiserverPatch "target" "kube-apiserver" "component" "memory") | fromYaml) -}}
  {{- range $file := $files -}}
    {{- $_ := set $file "content" (get $file "content" | trim) -}}
  {{- end -}}
  {{- $files | toYaml -}}
{{- end -}}
