{{- define "t8s-cluster.patches.patchFile" -}}
content: |- {{- .values | toYaml | nindent 2 }}
path: {{ printf "%s/%s-%s.yaml" (include "t8s-cluster.patches.directory" (dict)) .target .component }}
{{- end -}}

{{- define "t8s-cluster.patches.directory" -}}
/etc/kubernetes/patches
{{- end -}}
