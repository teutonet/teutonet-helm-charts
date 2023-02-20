{{- if not (hasKey .Values.clouds .Values.cloud) -}}
  {{- fail "You need to use a cloud thats defined" -}}
{{- end -}}
