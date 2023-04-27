{{- define "base-cluster.certificate" -}}
{{- if and .context.Values.dns.provider (not .customDomain) -}}
cluster-wildcard-certificate
{{- else -}}
{{- printf "%s-certificate" .name -}}
{{- end -}}
{{- end -}}
