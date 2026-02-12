{{/*
Return a resource request/limit object based on a given preset or provided resources.
By default no CPU limits are set, as CPU is compressible and setting limits can cause more issues than it solves.
If you want to set CPU limits, set the "setCPULimits" value to true.
{{ include "common.resources" (dict "resources" (dict) "resourcesPreset" "small" "setCPULimits" true) -}}
*/}}
{{- define "common.resources" -}}
  {{- $resources := dict -}}
  {{- if .resources -}}
    {{- $resources = deepCopy .resources | mustMerge $resources -}}
  {{- end -}}
  {{- if and .resourcesPreset (ne .resourcesPreset "none") -}}
    {{- $presetResources := include "common.resources.preset" (dict "type" .resourcesPreset) | fromYaml -}}
    {{- if not .setCPULimits -}}
      {{- $presetResources = set $presetResources "limits" (omit (dig "limits" (dict) $presetResources) "cpu") -}}
    {{- end -}}
    {{- $resources = mustMerge $resources $presetResources -}}
  {{- end -}}
  {{- toYaml $resources -}}
{{- end -}}
