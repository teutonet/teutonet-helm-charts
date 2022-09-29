{{- define "common.networkPolicy.type" -}}
{{- if eq .Values.global.networkPolicy.type "auto" -}}
{{- if .Capabilities.APIVersions.Has "cilium.io/v2/CiliumNetworkPolicy" -}}
cilium
{{- else -}}
none
{{- end -}}
{{- else -}}
{{- .Values.global.networkPolicy.type -}}
{{- end -}}
{{- end -}}

{{- define "common.dict.filterEmptyValues" -}}
{{- $out := dict -}}
{{- range $key, $value := . -}}
{{- if $value -}}
{{- $out = set $out $key $value -}}
{{- end -}}
{{- end -}}
{{- $out | toYaml -}}
{{- end -}}

{{- define "base-cluster.helm.labels" -}}
{{- include "common.labels.standard" (dict "Release" (dict "Name" "{{ .Release.Name }}" "Service" "{{ .Release.Service }}") "Chart" (dict "Name" "{{ .Chart.Name }}" "Version" "{{ .Chart.Version }}") "Values" (dict)) -}}
{{- end -}}