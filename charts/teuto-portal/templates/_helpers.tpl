{{- define "portalworker.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.worker.image "global" .Values.global) }}
{{- end -}}

{{- define "portalworker.jdbc" -}}
{{- $portString := .Values.worker.database.port | int -}}
{{ printf "jdbc:postgresql://%s:%d/teuto_domain?currentSchema=app_public" .Values.worker.database.host $portString }}
{{- end -}}