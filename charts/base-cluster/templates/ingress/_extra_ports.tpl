{{- define "base-cluster.ingress.extraPorts.normalize" -}}
{{- if kindIs "map" .cfg -}}
{{- $port := .cfg.port | int -}}
{{- dict "port" $port "exposedPort" ((.cfg.exposedPort | default $port) | int) "protocol" (.cfg.protocol | default "TCP") | toYaml -}}
{{- else -}}
{{- $port := .cfg | int -}}
{{- dict "port" $port "exposedPort" $port "protocol" "TCP" | toYaml -}}
{{- end -}}
{{- end -}}
