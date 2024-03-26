{{- define "base-cluster.kubectl.image" -}}
  {{- include "common.images.image" (dict "imageRoot" .Values.global.kubectl.image "global" .Values.global) -}}
{{- end -}}

{{- define "base-cluster.curl.image" -}}
  {{- include "common.images.image" (dict "imageRoot" .Values.global.curl.image "global" .Values.global) -}}
{{- end -}}

{{- define "base-cluster.flux.image" -}}
  {{- include "common.images.image" (dict "imageRoot" .Values.global.flux.image "global" .Values.global) -}}
{{- end -}}

{{- define "base-cluster.gpg.image" -}}
  {{- include "common.images.image" (dict "imageRoot" .Values.global.gpg.image "global" .Values.global) -}}
{{- end -}}

{{- define "base-cluster.defaultRegistry" -}}
docker.io
{{- end -}}
