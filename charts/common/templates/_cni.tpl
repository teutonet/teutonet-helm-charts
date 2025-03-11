{{- define "common.networkPolicy.type" -}}
  {{- if eq .Values.global.networkPolicy.type "auto" -}}
    {{- if .Capabilities.APIVersions.Has "cilium.io/v2/CiliumNetworkPolicy" -}}
      cilium
    {{- else -}}
      native
    {{- end -}}
  {{- else -}}
    {{- .Values.global.networkPolicy.type -}}
  {{- end -}}
{{- end -}}
