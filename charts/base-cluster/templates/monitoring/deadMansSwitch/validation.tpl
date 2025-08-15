{{- if .Values.monitoring.deadMansSwitch -}}
  {{- if not .Values.global.baseDomain -}}
    {{- fail "You need to provide a `.Values.global.baseDomain` when enabling the dead mans switch" -}}
  {{- end -}}
{{- end -}}
