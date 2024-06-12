{{- define "t8s-cluster.patches.patchFile" -}}
  {{- dict "content" (toYaml .values) "path" (printf "%s/%s-%s.yaml" (include "t8s-cluster.patches.directory" (dict)) .target .component) | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.patches.directory" -}}
/etc/kubernetes/patches
{{- end -}}
