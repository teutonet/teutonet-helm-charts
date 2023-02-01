{{- define "t8s-cluster.helm.labels" -}}
{{- include "common.labels.standard" (dict "Release" (dict "Name" "{{ .Release.Name }}" "Service" "{{ .Release.Service }}") "Chart" (dict "Name" "{{ .Chart.Name }}" "Version" "{{ .Chart.Version }}") "Values" (dict)) -}}
{{- end -}}