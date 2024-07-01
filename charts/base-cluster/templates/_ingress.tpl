{{- define "base-cluster.certificate" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- if and .Values.dns.provider (not .customDomain) -}}
    cluster-wildcard-certificate
  {{- else -}}
    {{- printf "%s-certificate" .name -}}
  {{- end -}}
{{- end -}}
