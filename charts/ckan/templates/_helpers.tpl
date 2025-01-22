{{- define "ckan.ckan.service.port" -}}
5000
{{- end -}}
{{- define "ckan.datapusher.service.port" -}}
8800
{{- end -}}
{{- define "ckan.redis.service.port" -}}
6379
{{- end -}}
{{- define "ckan.postgres.service.port" -}}
5432
{{- end -}}
{{- define "ckan.solr.service.port" -}}
8983
{{- end -}}

{{- define "ckan.postgresql.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "postgresql" "chartValues" .Values.postgresql "context" $) -}}
{{- end -}}

{{- define "ckan.solr.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "solr" "chartValues" .Values.solr "context" $) -}}
{{- end -}}

{{- define "ckan.redis.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "redis" "chartValues" .Values.redis "context" $) -}}
{{- end -}}

{{- define "ckan.defaultRegistry" -}}
docker.io
{{- end -}}

{{- define "ckan.ckan.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.ckan.image) "context" $) -}}
{{- end }}

{{- define "ckan.datapusher.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.datapusher.image) "context" $) -}}
{{- end }}
