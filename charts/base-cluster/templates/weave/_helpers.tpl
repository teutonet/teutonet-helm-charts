{{- define "weaveworks.username" -}}
{{- .Values.weaveworks.username | default "admin" -}}
{{- end -}}

{{- define "weaveworks.password" -}}
{{- $secret := (lookup "v1" "Secret" "flux-system" "cluster-user-auth") -}}
{{- $password:= dig "data" "password-dec" "" $secret -}}
{{- $value := .Values.weaveworks.password -}}
{{- if and $password $value (ne $password (.Values.weaveworks.password | b64enc)) -}}
{{ $value }}
{{- else -}}
{{- include "common.secrets.passwords.manage" (dict "secret" "cluster-user-auth" "key" "password-dec" "providedValues" (list "weaveworks.password") "length" 20 "strong" false "skipB64enc" true "skipQuote" true "context" $) -}}
{{- end -}}
{{- end -}}