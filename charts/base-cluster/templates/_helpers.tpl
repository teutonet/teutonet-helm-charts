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

{{- define "base-cluster.monitoring.alertmanager.receiver.splitName" -}}
  {{- $name := .name -}}
  {{- $type := $name -}}
  {{- $splitted := splitList " " $name -}}
  {{- if eq (len $splitted) 2 -}}
    {{- $type = index $splitted 0 -}}
    {{- $name = index $splitted 1 -}}
  {{- end -}}
  {{- dict "type" $type "name" $name | toYaml -}}
{{- end -}}
