{{/*
Get service port for api-gateway.
*/}}
{{- define "stellio.api_gateway.service.port" -}}
8080
{{- end -}}

{{/*
Get service port for kafka.
*/}}
{{- define "stellio.kafka.service.port" -}}
29092
{{- end -}}

{{/*
Get service port for postgres.
*/}}
{{- define "stellio.postgres.service.port" -}}
5432
{{- end -}}

{{/*
Get service port for search-service.
*/}}
{{- define "stellio.search.service.port" -}}
8083
{{- end -}}

{{/*
Get service port for subscription-service.
*/}}
{{- define "stellio.subscription.service.port" -}}
8084
{{- end -}}

{{/*
Generate stellio microservice deployment.

Params:
  - name - String. Name of deployment/microservice
  - deployment - Dict - Required. The deployment options:
    - image - Dict - Required. Image settings, see [ImageRoot](https://artifacthub.io/packages/helm/bitnami/common#imageroot) for the structure.
    - podAnnotations - Dict - Optional. The pod annotations.
    - podSecurityContext - Dict - Optional. The pod security context.
    - replicaCount - int - Optional.
    - resources - Dict - Optional. The container resources.
    - securityContext - Dict - Optional. The container security context.
    - service - Dict - Required. Service options.
  - context - Dict - Required. The context for the template evaluation.


*/}}
{{- define "stellio.deployment" -}}
{{- $mySvcPort := printf "stellio.%s.service.port" (.name | replace "-" "_" ) -}}
{{- $svcNameSearch := printf "%s-%s" (include "common.names.fullname" .context) "search" -}}
{{- $svcNameSubscription := printf "%s-%s" (include "common.names.fullname" .context) "subscription" -}}
{{- $svcNameKafka := printf "%s-%s" (include "common.names.fullname" .context) "kafka" -}}
{{- $svcKafkaPort := include "stellio.kafka.service.port" $ -}}
{{- $svcNamePsql := printf "%s-%s" (include "common.names.fullname" .context) "postgres" -}}
{{- $configNamePsql := printf "%s-%s" (include "common.names.fullname" .context) "postgres-config"  -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ printf "%s-%s" (include "common.names.fullname" .context) .name | quote }}
  labels: {{- include "common.labels.standard" .context | nindent 4 }}
    app.kubernetes.io/component: {{ .name }}
spec:
  replicas: {{ .deployment.replicaCount | default 1 }}
  selector:
    matchLabels: {{- include "common.labels.matchLabels" .context | nindent 6 }}
      app.kubernetes.io/component: {{ .name }}
  template:
    metadata:
      {{- with .deployment.podAnnotations | default dict }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels: {{- include "common.labels.matchLabels" .context | nindent 8 }}
        app.kubernetes.io/component: {{ .name }}
    spec:
      {{- include "common.images.renderPullSecrets" ( dict "images" (list .deployment.image) "context" .context) | indent 6 }}
      automountServiceAccountToken: false
      securityContext:
        {{- toYaml .deployment.podSecurityContext | default dict | nindent 8 }}
      containers:
        - name: {{ printf "%s-%s" .context.Chart.Name .name }}
          env:
            - name: APPLICATION_AUTHENTICATION_ENABLED
              value: "false"
            {{- if eq .name "api-gateway" }}
            - name: APPLICATION_SUBSCRIPTION_SERVICE_URL
              value: {{ $svcNameSubscription }}
            - name: APPLICATION_SEARCH_SERVICE_URL
              value: {{ $svcNameSearch }}
            - name: JAVA_OPTIONS
              value: -Dlogging.level.root=DEBUG -Dlogging.level.org.springframework=DEBUG
            - name: SERVER_COMPRESSION_ENABLED
              value: "true"
            {{- else -}}
            {{- if eq .name "subscription" }}
            - name: APPLICATION_ENTITY_SERVICE-URL
              value: http://{{ $svcNameSearch }}:{{ include "stellio.search.service.port" $  }}
            {{- end }}
            - name: SPRING_FLYWAY_URL
              value: jdbc:postgresql://{{ $svcNamePsql }}/stellio_{{ .name }}
            - name: SPRING_PROFILES_ACTIVE
              value: docker
            - name: SPRING_R2DBC_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ $configNamePsql }}
                  key: password
            - name: SPRING_R2DBC_URL
              value: r2dbc:postgresql://{{ $svcNamePsql }}/stellio_{{ .name }}
            - name: SPRING_R2DBC_USERNAME
              valueFrom:
                  secretKeyRef:
                    name: {{ $configNamePsql }}
                    key: username
            - name: SPRING_CLOUD_STREAM_KAFKA_BINDER_BROKERS
              value: {{ $svcNameKafka }}:{{ $svcKafkaPort }}
            - name: SPRING_KAFKA_BOOTSTRAP_SERVERS
              value: {{ $svcNameKafka }}:{{ $svcKafkaPort }}
            {{- end }}
          securityContext:
            {{- toYaml .deployment.securityContext | default dict | nindent 12 }}
          image: {{ include "common.images.image" (dict "imageRoot" .deployment.image "global" .context.Values.global ) }}
          imagePullPolicy: {{ .deployment.image.pullPolicy }}
          ports:
            - name: http
              containerPort: {{ include $mySvcPort .context }}
              protocol: TCP
          resources:
            {{- toYaml .deployment.resources | default dict | nindent 12 }}
{{- end }}

