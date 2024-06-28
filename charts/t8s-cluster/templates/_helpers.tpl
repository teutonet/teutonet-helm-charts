{{- define "t8s-cluster.k8s-version" -}}
  {{- with $.Values.version -}}
    {{ printf "v%d.%d.%d" (.major | int) (.minor | int) (.patch | int) }}
  {{- end -}}
{{- end -}}

{{- define "t8s-cluster.hasGPUNodes" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $hasGPUFlavor := false -}}
  {{- range $name, $machineDeploymentClass := .Values.nodePools -}}
    {{- if contains "gpu" (lower $machineDeploymentClass.flavor) -}}
      {{- $hasGPUFlavor = true -}}
    {{- end -}}
  {{- end -}}
  {{- $hasGPUFlavor | ternary true "" -}}
{{- end -}}
