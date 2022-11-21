{{- define "base-cluster.domain" -}}
{{- printf "%s.%s" (required "You must provide a cluster name" $.Values.global.clusterName) (required "You must provide a base domain" $.Values.global.baseDomain) -}}
{{- end -}}

{{- define "base-cluster.grafana.host" -}}
{{- printf "%s.%s" (required "You must provide a host for the grafana server" .Values.monitoring.grafana.ingress.host) (include "base-cluster.domain" $) }}
{{- end -}}

{{- define "base-cluster.prometheus.host" -}}
{{- printf "%s.%s" (required "You must provide a host for the prometheus server" .Values.monitoring.prometheus.ingress.host) (include "base-cluster.domain" $) }}
{{- end -}}

{{- define "base-cluster.alertmanager.host" -}}
{{- printf "%s.%s" (required "You must provide a host for the prometheus alertmanager server" .Values.monitoring.prometheus.alertmanager.ingress.host) (include "base-cluster.domain" $) }}
{{- end -}}
