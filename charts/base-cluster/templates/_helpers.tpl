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

{{- define "base-cluster.helm.chartVersion" -}}
{{- dig .repo "charts" .chart nil .context.Values.global.helmRepositories | required (printf "The repo '%s' is either missing or doesn't contain the chart '%s'" .repo .chart) -}}
{{- end -}}

{{- define "base-cluster.helm.chartSpec" -}}
chart: {{ .chart | quote }}
version: {{ include "base-cluster.helm.chartVersion" (dict "repo" .repo "chart" .chart "context" .context) | quote }}
sourceRef:
  kind: HelmRepository
  name: {{ .repo | quote }}
  namespace: {{ .context.Release.Namespace }}
{{- end -}}