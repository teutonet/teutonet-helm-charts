{{- define "base-cluster.reflector.enabled" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $needsReflector := false -}}
  {{- $hardSet := typeIs "bool" .Values.reflector.enabled -}}
  {{- if $hardSet -}}
    {{- $needsReflector = .Values.reflector.enabled -}}
  {{- else -}}
    {{- $needsReflector = not (empty (include "base-cluster.cert-manager.custom-certificates" .context | fromYaml)) -}}
    {{- if not $needsReflector -}}
      {{- $needsReflector = not (empty (.Values.global.imageCredentials | keys)) -}}
    {{- end -}}
  {{- end -}}
  {{- $needsReflector | ternary true "" -}}
{{- end }}
