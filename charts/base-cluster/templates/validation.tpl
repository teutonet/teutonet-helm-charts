{{/* Don't fail in namespace default -> this allows artifacthub to check for images */}}
{{- if not (eq .Release.Namespace "default") -}}
  {{- if not .Values.global.clusterName }}
    {{- fail "You need to specify a .Values.global.clusterName" -}}
  {{- end -}}

  {{- if not .Values.global.baseDomain }}
    {{- fail "You need to specify a .Values.global.baseDomain" -}}
  {{- end -}}

  {{- if not .Values.global.serviceLevelAgreement }}
    {{- fail "You need to specify a .Values.global.serviceLevelAgreement" -}}
  {{- end -}}
{{- else -}}
{{/* This is no problem during dry-run but fails on normal installations / upgrades */}}
apiVersion: v1
kind: Namespace
metadata:
  name: Please don't install me in `default`
{{- end -}}