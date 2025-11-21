{{/*
Common labels
*/}}
{{- define "urbanstack-shared-app.labels" -}}
{{ include "common.labels.standard" . }}
tenant: {{ .Values.tenant | quote }}
citytool: {{ .Values.citytool | quote }}
{{- end }}
