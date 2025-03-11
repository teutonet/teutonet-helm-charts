{{- define "common.dict.filterEmptyValues" -}}
  {{- $out := dict -}}
  {{- range $key, $value := . -}}
    {{- if $value -}}
      {{- $out = set $out $key $value -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $out -}}
{{- end -}}

{{- define "base-cluster.helm.chartSpec" -}}
  {{- include "common.helm.chartSpec" (dict "context" .context "repo" .repo "chart" .chart "prependReleaseName" false "reconcileStrategy" .reconcileStrategy) -}}
{{- end -}}
