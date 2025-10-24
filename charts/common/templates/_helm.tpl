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
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- dig .repo "charts" .chart nil .Values.global.helmRepositories | required (printf "The repo '%s' is either missing or doesn't contain the chart '%s'" .repo .chart) -}}
{{- end -}}

{{/*
Returns a HelmRelease.spec.chart.spec for a given chart in a given repository.
{{ include "common.helm.chartSpec" (dict "context" $ "repo" "bitnami" "chart" "redis" "prependReleaseName" true) -}}
*/}}
{{- define "common.helm.chartSpec" -}}
  {{- $_ := mustMerge . (pick .context "Values" "Release") -}}
  {{- $spec := dict -}}
  {{- if eq (dig .repo "type" "helm" .Values.global.helmRepositories) "helm" -}}
    {{- $spec = mustMerge (dict
        "chart" .chart
        "sourceRef" (dict
          "kind" "HelmRepository"
          "name" (eq .prependReleaseName true | ternary (printf "%s-%s" .Release.Name .repo) .repo)
          "namespace" (.repoNamespace | default .Release.Namespace)
        )
        "version" (include "common.helm.chartVersion" (dict "repo" .repo "chart" .chart "context" .context))
      )
      $spec
    -}}
  {{- else -}}
    {{- $spec = mustMerge (dict
        "chart" (dig .repo "charts" .chart "path" (printf "charts/%s" .chart) .Values.global.helmRepositories)
        "sourceRef" (dict
          "kind" "GitRepository"
          "name" (eq .prependReleaseName true | ternary (printf "%s-%s-%s" .Release.Name .repo .chart) (printf "%s-%s" .repo .chart))
          "namespace" (.repoNamespace | default .Release.Namespace)
        )
        "reconcileStrategy" (.reconcileStrategy | default "Revision")
      )
      $spec
    -}}
  {{- end -}}
  {{- toYaml $spec -}}
{{- end -}}
