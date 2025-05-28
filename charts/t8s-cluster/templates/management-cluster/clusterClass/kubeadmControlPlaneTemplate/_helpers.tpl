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
  {{- $configs := include "t8s-cluster.clusterClass.apiServer.staticFiles" (dict) | fromYaml -}}
  {{- $configs = mustMerge $configs (dict "kube-proxy.config.yaml" (dict "path" "/etc/kube-proxy-config.yaml")) -}}
  {{- range $name, $file := $configs -}}
    {{- $files = append $files (dict "content" ($.Files.Get (printf "files/%s" $name)) "path" (get $file "path" | required (printf "missing path for %s" $name))) -}}
  {{- end -}}
  {{- $files = append $files (dict "content" (.Files.Get "files/kube-proxy.patch.sh") "path" "/etc/kube-proxy-patch.sh" "permissions" "0700") -}}
  {{- range $file := $files -}}
    {{- $file = set $file "content" (get $file "content" | trim) -}}
  {{- end -}}
  {{- $dynamicFiles := include "t8s-cluster.clusterClass.apiServer.dynamicFiles" (dict "context" .) | fromYaml | values -}}
  {{- range $name, $file := $dynamicFiles -}}
    {{- $files = append $files (dict "content" (get $file "content" | required (printf "missing content for %s" $name)) "path" (get $file "path" | required (printf "missing path for %s" $name))) -}}
  {{- end -}}
  {{- $apiserverPatch := dict "spec" (dict "containers" (list (dict "name" "kube-apiserver" "resources" (include "common.resources" .Values.controlPlane | fromYaml)))) -}}
  {{- $files = append $files (include "t8s-cluster.patches.patchFile" (dict "values" $apiserverPatch "target" "kube-apiserver" "component" "memory") | fromYaml) -}}
  {{- toYaml $files -}}
{{- end -}}
