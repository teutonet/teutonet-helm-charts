{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes secret labels
*/}}
{{- define "common.labels.stable" -}}
{{- omit (include "common.labels.standard" . | fromYaml) "helm.sh/chart" | toYaml -}}
{{- end -}}
