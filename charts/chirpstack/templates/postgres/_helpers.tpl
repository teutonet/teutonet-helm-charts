{{- define "chirpstack.postgres.env" -}}
- name: POSTGRES_PASSWORD
  value: root
- name: CS_POSTGRESQL_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postgres.existingSecretName | default (include "chirpstack.fullname" (dict "context" . "component" "postgres")) }}
      key: username
- name: CS_POSTGRESQL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postgres.existingSecretName | default (include "chirpstack.fullname" (dict "context" . "component" "postgres")) }}
      key: password
- name: CS_POSTGRESQL_DB
  value: {{ .Values.postgres.dbname }}
{{- end -}}
