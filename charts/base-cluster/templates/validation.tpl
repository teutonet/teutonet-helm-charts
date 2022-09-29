{{- if not .Values.global.clusterName }}
{{- fail "You need to specify a .Values.global.clusterName" -}}
{{- end -}}

{{- if not .Values.global.baseDomain }}
{{- fail "You need to specify a .Values.global.baseDomain" -}}
{{- end -}}

{{- if not .Values.global.serviceLevelAgreement }}
{{- fail "You need to specify a .Values.global.serviceLevelAgreement" -}}
{{- end -}}
