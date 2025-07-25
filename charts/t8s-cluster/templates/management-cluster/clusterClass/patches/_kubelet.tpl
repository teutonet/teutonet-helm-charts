{{- define "t8s-cluster.patches.kubelet.imagePulls" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $values := dict -}}
  {{- if and (semverCompare ">=1.27.0" (include "t8s-cluster.k8s-version" .context)) (gt (int .Values.global.kubeletExtraConfig.maxParallelImagePulls) 1) -}}
    {{- $values = mustMerge $values (dict "serializeImagePulls" false "maxParallelImagePulls" .Values.global.kubeletExtraConfig.maxParallelImagePulls) -}}
  {{- end -}}
  {{- toYaml $values -}}
{{- end -}}

{{- define "t8s-cluster.kubelet.featureGates"}}
  {{- include "t8s-cluster.featureGates.forComponent" (dict "component" "kubelet") -}}
{{- end -}}

{{- define "t8s-cluster.kubelet.options" -}}
  {{- $options := dict -}}
  {{- $options = set $options "eventRecordQPS" 0 -}}
  {{- $options = set $options "protectKernelDefaults" true -}}
  {{- $options = set $options "tlsCipherSuites" (include "t8s-cluster.clusterClass.tlsCipherSuites" (dict) | fromYamlArray) -}}
  {{- $options = set $options "seccompDefault" true -}}
  {{- toYaml $options -}}
{{- end -}}

{{- define "t8s-cluster.patches.kubelet.default" -}}
  {{- $values := dict -}}
  {{- range $option, $value := include "t8s-cluster.kubelet.options" (dict) | fromYaml -}}
    {{- $values = set $values $option $value -}}
  {{- end -}}
  {{- $values = set $values "featureGates" (include "t8s-cluster.kubelet.featureGates" (dict) | fromYaml) -}}
  {{- $patches := list -}}
  {{/* clear the old stuff beforehand, otherwise they just stay there 😐 */}}
  {{- $cleanupJsonPatch := list -}}
  {{- $settingsToClean := dict "/featureGates" (dict) -}}
  {{- range $settingToClean, $cleanValue := $settingsToClean -}}
    {{- $cleanupJsonPatch = append $cleanupJsonPatch (dict "op" "add" "path" $settingToClean "value" $cleanValue) -}}
  {{- end -}}
  {{- $patches = append $patches (include "t8s-cluster.patches.patchFile" (dict "values" $cleanupJsonPatch "target" "kubeletconfiguration" "suffix" 0 "patchType" "json") | fromYaml) -}}
  {{- $patches = append $patches (include "t8s-cluster.patches.patchFile" (dict "values" $values "target" "kubeletconfiguration" "component" "default") | fromYaml) -}}
  {{- toYaml $patches -}}
{{- end -}}

{{- define "t8s-cluster.patches.kubelet.patches" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $patches := include "t8s-cluster.patches.kubelet.default" (dict) | fromYamlArray -}}
  {{- with include "t8s-cluster.patches.kubelet.imagePulls" (dict "context" .context) | fromYaml -}}
    {{- $patches = append $patches (include "t8s-cluster.patches.patchFile" (dict "values" . "target" "kubeletconfiguration" "component" "imagePulls") | fromYaml) -}}
  {{- end -}}
  {{- toYaml $patches -}}
{{- end -}}
