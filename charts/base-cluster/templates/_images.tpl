{{- define "base-cluster.kubectl.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.global.kubectl.image "global" .Values.global) -}}
{{- end -}}
