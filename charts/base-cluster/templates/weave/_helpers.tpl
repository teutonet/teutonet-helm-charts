{{- define "weaveworks.password" -}}
{{ include "common.secrets.passwords.manage" (dict "secret" "cluster-user-auth" "key" "password" "providedValues" (list "weaveworks.adminUser.password") "length" 20 "strong" false "skipB64enc" true "skipQuote" true "context" $) | bcrypt }}
{{- end -}}