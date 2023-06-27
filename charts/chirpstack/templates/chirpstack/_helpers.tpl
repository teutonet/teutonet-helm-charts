{{- define "chirpstack.chirpstack.env" -}}
- name: MQTT_BROKER_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "mosquitto") }}
- name: POSTGRESQL_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "postgres") }}
- name: REDIS_HOST
  value: {{ include "chirpstack.fullname" (dict "context" . "component" "redis") }}
{{- end -}}