{{/*
Return a resource request/limit object based on a given preset or provided resources.
{{ include "common.resources" (dict "resources" (dict) "resourcesPreset" "small") -}}
*/}}
{{- define "common.resources" -}}
  {{- $resources := dict -}}
  {{- if .resources -}}
    {{- $resources = .resources | merge $resources -}}
  {{- end -}}
  {{- if and .resourcesPreset (ne .resourcesPreset "none") -}}
    {{- $resources = include "common.resources.preset" (dict "type" .resourcesPreset) | fromYaml | merge $resources -}}
  {{- end -}}
  {{- toYaml $resources -}}
{{- end -}}

{{/*
Return a (dict resources resourcesPreset) for passing through to capable charts, e.g. bitnami
{{ include "common.resourcesWithPreset" (dict "resources" (dict) "resourcesPreset" "small") -}}
*/}}
{{- define "common.resourcesWithPreset" -}}
  {{- pick . "resources" "resourcesPreset" | toYaml -}}
{{- end -}}
