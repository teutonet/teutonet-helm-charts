{{- define "t8s-cluster.patches.kubelet.imagePulls" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- include "t8s-cluster.patches.patchFile" (dict "values" (dict "serializeImagePulls" false "maxParallelImagePulls" .Values.global.kubeletExtraConfig.maxParallelImagePulls) "target" "kubeletconfiguration" "component" "imagePulls") -}}
{{- end -}}

{{- define "t8s-cluster.patches.kubelet.default" -}}
  {{- $values := dict -}}
  {{- $values = set $values "eventRecordQPS" 0 -}}
  {{- $values = set $values "protectKernelDefaults" true -}}
  {{- $values = set $values "featureGates" (dict) -}}
  {{- $values = set $values "SeccompDefault" true -}}
  {{- $values = set $values "tlsCipherSuites" (include "t8s-cluster.clusterClass.tlsCipherSuites" (dict) | splitList ",") -}}
  {{- include "t8s-cluster.patches.patchFile" (dict "values" $values "target" "kubeletconfiguration" "component" "default") -}}
{{- end -}}

{{- define "t8s-cluster.patches.kubelet.patches" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $patches := list (include "t8s-cluster.patches.kubelet.default" (dict) | fromYaml) -}}
  {{- if and (eq (int .Values.version.major) 1) (ge (int .Values.version.minor) 27) (gt (int .Values.global.kubeletExtraConfig.maxParallelImagePulls) 1) -}}
    {{- $patches = append $patches (include "t8s-cluster.patches.kubelet.imagePulls" (dict "context" .context) | fromYaml) -}}
  {{- end -}}
  {{- toYaml $patches -}}
{{- end -}}
