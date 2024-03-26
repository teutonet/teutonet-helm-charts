{{/*
Kubernetes secret labels
{{ include "common.labels.stable" . -}}
{{ include "common.labels.stable" (dict "customLabels" .Values.commonLabels "context" $) -}}
*/}}
{{- define "common.labels.stable" -}}
  {{- omit (include "common.labels.standard" . | fromYaml) "helm.sh/chart" | toYaml -}}
{{- end -}}
