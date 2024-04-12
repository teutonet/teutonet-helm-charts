{{/*
Creates a labels block for a HelmRelease resource.
{{ include "common.helm.labels" (dict) -}}
*/}}
{{- define "common.helm.labels" -}}
  {{- include "common.labels.standard" (dict "Release" (dict "Name" "{{ .Release.Name }}" "Service" "{{ .Release.Service }}") "Chart" (dict "Name" "{{ .Chart.Name }}" "Version" "{{ .Chart.Version }}") "Values" (dict)) -}}
{{- end -}}

{{/*
Returns the chart version for a given chart in a given repository.
{{ include "common.helm.chartVersion" (dict "context" $ "repo" "bitnami" "chart" "redis") -}}
*/}}
{{- define "common.helm.chartVersion" -}}
  {{- $_ := set . "Values" .context.Values -}}
  {{- dig .repo "charts" .chart nil .Values.global.helmRepositories | required (printf "The repo '%s' is either missing or doesn't contain the chart '%s'" .repo .chart) -}}
{{- end -}}

{{/*
Returns a HelmRelease.spec.chart.spec for a given chart in a given repository.
{{ include "common.helm.chartSpec" (dict "context" $ "repo" "bitnami" "chart" "redis" "prependReleaseName" true) -}}
*/}}
{{- define "common.helm.chartSpec" -}}
  {{- $_ := set . "Release" .context.Release -}}
  {{- dict
        "chart" .chart
        "version" (include "common.helm.chartVersion" (dict "repo" .repo "chart" .chart "context" .context))
        "sourceRef" (dict
          "kind" "HelmRepository"
          "name" (eq .prependReleaseName true | ternary (printf "%s-%s" .Release.Name .repo) .repo)
          "namespace" .Release.Namespace
        )
      | toYaml
   -}}
{{- end -}}

