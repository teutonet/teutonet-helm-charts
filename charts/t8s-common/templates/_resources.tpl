{{/*
Return a resource request/limit object based on a given preset or provided resources.
{{ include "common.resources" (dict "resources" (dict) "resourcesPreset" "small") -}}
*/}}
{{- define "common.resources" -}}
  {{- if .resources -}}
    {{- toYaml .resources -}}
  {{- else if ne .resourcesPreset "none" -}}
    {{- include "common.resources.preset" (dict "type" .resourcesPreset) -}}
  {{- end -}}
{{- end -}}

{{/*
Return a (dict resources resourcesPreset) for passing through to capable charts, e.g. bitnami
{{ include "common.resourcesWithPreset" (dict "resources" (dict) "resourcesPreset" "small") -}}
*/}}
{{- define "common.resourcesWithPreset" -}}
  {{- pick . "resources" "resourcesPreset" | toYaml -}}
{{- end -}}
