{{- define "base-cluster.reflector.enabled" -}}
  {{- $needsReflector := false -}}
  {{- $hardSet := typeIs "bool" .context.Values.reflector.enabled -}}
  {{- if $hardSet -}}
    {{- $needsReflector = .context.Values.reflector.enabled -}}
  {{- else -}}
    {{- $needsReflector = not (empty (include "base-cluster.cert-manager.custom-certificates" .context | fromYaml)) -}}
    {{- if not $needsReflector -}}
      {{- $needsReflector = not (empty (.context.Values.global.imageCredentials | keys)) -}}
    {{- end -}}
  {{- end -}}
  {{- $needsReflector -}}
{{- end }}