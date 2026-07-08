{{- define "chirpstack.chirpstack.env" -}}
- name: CS_API_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "chirpstack.fullname" (dict "context" . "component" "chirpstack") }}
      key: apisecret
- name: LOGLEVEL
  value: {{ .Values.chirpstack.logLevel | default "info" }}
- name: MQTT_BROKER_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "mosquitto") }}
- name: POSTGRESQL_HOST
  value: {{ .Values.postgres.existingPsqlUrl | default (include "chirpstack.fullname" (dict "context" . "component" "postgres")) }}
- name: POSTGRESQL_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postgres.existingSecretName | default (include "chirpstack.fullname" (dict "context" . "component" "postgres")) }}
      key: username
- name: POSTGRESQL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postgres.existingSecretName | default (include "chirpstack.fullname" (dict "context" . "component" "postgres")) }}
      key: password
- name: POSTGRESQL_DB
  value: {{ .Values.postgres.dbname }}
- name: REDIS_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "redis") }}
{{- end -}}
