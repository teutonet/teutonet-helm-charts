{{- define "t8s-cluster.patches.kubelet.imagePulls" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $values := dict -}}
  {{- if and (or (gt (.Values.version.major | int) 1) (ge (.Values.version.minor | int) 27)) (gt (int .Values.global.kubeletExtraConfig.maxParallelImagePulls) 1) -}}
    {{- $values = mustMerge $values (dict "serializeImagePulls" false "maxParallelImagePulls" .Values.global.kubeletExtraConfig.maxParallelImagePulls) -}}
  {{- end -}}
  {{- $values | toYaml -}}
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
  {{- $options | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.patches.kubelet.default" -}}
  {{- $values := dict -}}
  {{- range $option, $value := include "t8s-cluster.kubelet.options" (dict) | fromYaml -}}
    {{- $values = set $values $option $value -}}
  {{- end -}}
  {{- $values = set $values "featureGates" (include "t8s-cluster.kubelet.featureGates" (dict) | fromYaml) -}}
  {{- include "t8s-cluster.patches.patchFile" (dict "values" $values "target" "kubeletconfiguration" "component" "default") -}}
{{- end -}}

{{- define "t8s-cluster.patches.kubelet.patches" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $patches := list (include "t8s-cluster.patches.kubelet.default" (dict) | fromYaml) -}}
  {{- with include "t8s-cluster.patches.kubelet.imagePulls" (dict "context" .context) | fromYaml -}}
    {{- $patches = append $patches (include "t8s-cluster.patches.patchFile" (dict "values" . "target" "kubeletconfiguration" "component" "imagePulls") | fromYaml) -}}
  {{- end -}}
  {{- toYaml $patches -}}
{{- end -}}
