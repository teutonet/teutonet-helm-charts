{{- define "t8s-cluster.helm.labels" -}}
  {{- include "common.labels.standard" (dict "Release" (dict "Name" "{{ .Release.Name }}" "Service" "{{ .Release.Service }}") "Chart" (dict "Name" "{{ .Chart.Name }}" "Version" "{{ .Chart.Version }}") "Values" (dict)) -}}
{{- end -}}

{{- define "t8s-cluster.k8s-version" -}}
  {{- with $.Values.version -}}
    {{ printf "v%d.%d.%d" (.major | int) (.minor | int) (.patch | int) }}
  {{- end -}}
{{- end -}}

{{- define "t8s-cluster.helm.chartVersion" -}}
  {{- $_ := set . "Values" .context.Values -}}
  {{- dig .repo "charts" .chart nil .Values.global.helmRepositories | required (printf "The repo '%s' is either missing or doesn't contain the chart '%s'" .repo .chart) -}}
{{- end -}}

{{- define "t8s-cluster.helm.chartSpec" -}}
chart: {{ .chart | quote }}
version: {{ include "t8s-cluster.helm.chartVersion" (dict "repo" .repo "chart" .chart "context" .context) | quote }}
sourceRef:
  kind: HelmRepository
  name: {{ printf "%s-%s" .context.Release.Name .repo | quote }}
  namespace: {{ .context.Release.Namespace }}
{{- end -}}

{{- define "t8s-cluster.hasGPUNodes" -}}
  {{- $_ := set . "Values" .context.Values -}}
  {{- $hasGPUFlavor := false -}}
  {{- range $name, $machineDeploymentClass := .Values.nodePools -}}
    {{- if contains "gpu" (lower $machineDeploymentClass.flavor) -}}
      {{- $hasGPUFlavor = true -}}
    {{- end -}}
  {{- end -}}
  {{- $hasGPUFlavor | ternary true "" -}}
{{- end -}}
