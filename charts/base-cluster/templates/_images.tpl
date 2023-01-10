{{- define "base-cluster.kubectl.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.global.kubectl.image "global" .Values.global) -}}
{{- end -}}

{{- define "base-cluster.pause.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.global.pause.image "global" .Values.global) -}}
{{- end -}}

{{- define "base-cluster.flux.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.global.flux.image "global" .Values.global) -}}
{{- end -}}

{{- define "base-cluster.gpg.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.global.gpg.image "global" .Values.global) -}}
{{- end -}}
