{{- define "base-cluster.domain" -}}
  {{- printf "%s.%s" (required "You must provide a cluster name" $.Values.global.clusterName) (required "You must provide a base domain" $.Values.global.baseDomain) -}}
{{- end -}}

{{- define "base-cluster.grafana.host" -}}
  {{- if .Values.monitoring.grafana.ingress.customDomain -}}
    {{- .Values.monitoring.grafana.ingress.customDomain -}}
  {{- else -}}
    {{- printf "%s.%s" (required "You must provide a host for the grafana server" .Values.monitoring.grafana.ingress.host) (include "base-cluster.domain" $) -}}
  {{- end -}}
{{- end -}}

{{- define "base-cluster.prometheus.host" -}}
  {{- if .Values.monitoring.prometheus.ingress.customDomain -}}
    {{- .Values.monitoring.prometheus.ingress.customDomain -}}
  {{- else -}}
    {{- printf "%s.%s" (required "You must provide a host for the prometheus server" .Values.monitoring.prometheus.ingress.host) (include "base-cluster.domain" $) -}}
  {{- end -}}
{{- end -}}

{{- define "base-cluster.alertmanager.host" -}}
  {{- if .Values.monitoring.prometheus.alertmanager.ingress.customDomain -}}
    {{- .Values.monitoring.prometheus.alertmanager.ingress.customDomain -}}
  {{- else -}}
    {{- printf "%s.%s" (required "You must provide a host for the prometheus alertmanager server" .Values.monitoring.prometheus.alertmanager.ingress.host) (include "base-cluster.domain" $) -}}
  {{- end -}}
{{- end -}}

{{- define "base-cluster.weaveworks.host" -}}
  {{- if .Values.weaveworks.ingress.customDomain -}}
    {{- .Values.weaveworks.ingress.customDomain -}}
  {{- else -}}
    {{- printf "%s.%s" (required "You must provide a host for the gitops-server" .Values.weaveworks.ingress.host) (include "base-cluster.domain" $) -}}
  {{- end -}}
{{- end -}}
