{{- define "base-cluster.reflector.enabled" -}}
  {{- $needsReflector := false -}}
  {{- $checkAuto := typeIs "string" .context.Values.reflector.enabled -}}
  {{- if $checkAuto -}}
    {{- $needsReflector = not (empty (include "base-cluster.cert-manager.custom-certificates" .context | fromYaml)) -}}
    {{- if not $needsReflector -}}
      {{- $needsReflector = not (empty (.context.Values.global.imageCredentials | keys)) -}}
    {{- end -}}
  {{- else -}}
    {{- $needsReflector = .context.Values.reflector.enabled -}}
  {{- end -}}
  {{- $needsReflector -}}
{{- end }}