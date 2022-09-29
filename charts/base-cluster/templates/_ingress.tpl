{{- define "base-cluster.certificate" -}}
{{- if .context.Values.dns.provider -}}
cluster-wildcard-certificate
{{- else -}}
{{- printf "%s-certificate" .name -}}
{{- end -}}
{{- end -}}