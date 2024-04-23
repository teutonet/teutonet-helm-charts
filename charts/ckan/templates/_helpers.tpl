{{/*
Get service port for ckan.
*/}}
{{- define "ckan.ckan.service.port" -}}
5000
{{- end -}}

{{/*
Get service port for datapusher.
*/}}
{{- define "ckan.datapusher.service.port" -}}
8800
{{- end -}}

{{/*
Get service port for redis.
*/}}
{{- define "ckan.redis.service.port" -}}
6379
{{- end -}}

{{/*
Get service port for postgres.
*/}}
{{- define "ckan.postgres.service.port" -}}
5432
{{- end -}}

{{/*
Get service port for ssolr.
*/}}
{{- define "ckan.solr.service.port" -}}
8983
{{- end -}}

{{- define "ckan.helm.chartSpec" -}}
  {{- include "common.helm.chartSpec" (dict "context" .context "repo" .repo "chart" .chart "prependReleaseName" false) -}}
{{- end -}}