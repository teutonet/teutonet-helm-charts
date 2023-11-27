{{- define "portalworker.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.worker.image "global" .Values.global) }}
{{- end -}}

{{- define "portalworker.jdbc" -}}
{{- $port := .Values.worker.database.port | int -}}
{{ printf "jdbc:postgresql://%s:%d/teuto_domain?currentSchema=app_public" .Values.worker.database.host $port }}
{{- end -}}

{{- define "portalworker.dbcredentials.secretName" -}}
{{ required "A secretName containing the database credentials is required" .Values.worker.database.credentials.secret.name }}
{{- end -}}
