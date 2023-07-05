{{- define "chirpstack.chirpstack.env" -}}
- name: MQTT_BROKER_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "mosquitto") }}
- name: POSTGRESQL_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "postgres") }}
- name: POSTGRESQL_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "chirpstack.fullname" (dict "context" . "component" "postgres") }}
      key: username
- name: POSTGRESQL_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "chirpstack.fullname" (dict "context" . "component" "postgres") }}
      key: password
- name: POSTGRESQL_DB
  value: {{ .Values.postgres.dbname }}
- name: REDIS_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "redis") }}
{{- end -}}
