{{- define "t8s-cluster.patches.patchFile" -}}
content: |- {{- toYaml .values | nindent 2 }}
path: {{ printf "%s/%s-%s.yaml" (include "t8s-cluster.patches.directory" (dict)) .target .component }}
{{- end -}}

{{- define "t8s-cluster.patches.directory" -}}
/etc/kubernetes/patches
{{- end -}}
