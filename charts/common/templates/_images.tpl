{{/*
Return the correct image pullPolicy.
If digest is set or tag contains "@" the pullPolicy is set to "IfNotPresent", otherwise "Always"
{{ include "common.images.pullPolicy" .Values.path.to.the.image }}
*/}}
{{- define "common.images.pullPolicy" -}}
  {{- if or (.tag | contains "@") .digest -}}
    IfNotPresent
  {{- else -}}
    Always
  {{- end -}}
{{- end -}}
