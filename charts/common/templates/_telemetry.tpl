{{- define "common.telemetry.env" -}}
  {{- $env := dict -}}
  {{- $config := dig "telemetry" .protocol (dict) .global -}}
  {{- if eq .protocol "otlp" -}}
    {{- $enabled := false -}}
    {{- $endpoint := "" -}}
    {{- $insecure := dig "insecure" true $config -}}
    {{- $serviceProtocol := "" -}}
    {{- if eq (dig "endpoint" "auto" $config) "auto" -}}
      {{- $services := (dict "monitoring" (list "open-telemetry-collector-opentelemetry-collector")) -}}
      {{- range $namespace, $serviceNames := $services -}}
        {{- range $serviceName := $serviceNames -}}
          {{- $service := lookup "v1" "Service" $namespace $serviceName -}}
          {{- if $service -}}
            {{- $servicePort := 0 -}}
            {{- range $portSpec := dig "spec" "ports" (list) $service -}}
              {{- if eq (dig "name" "" $portSpec) "otlp" -}}
                {{- $servicePort = dig "port" 0 $portSpec -}}
                {{- $appProtocol := dig "appProtocol" "" $portSpec -}}
                {{/* see https://opentelemetry.io/docs/specs/otel/protocol/exporter/ */}}
                {{- if has $appProtocol (list "grpc" "http/protobuf" "http/json") -}}
                  {{- $serviceProtocol = $appProtocol -}}
                {{- end -}}
                {{- if $servicePort -}}
                  {{- break -}}
                {{- end -}}
              {{- end -}}
            {{- end -}}
            {{- $enabled = true -}}
            {{- $endpoint = printf "%s.%s:%d" $serviceName $namespace $servicePort -}}
            {{- break -}}
          {{- end -}}
        {{- end -}}
        {{- if $enabled -}}
          {{- break -}}
        {{- end -}}
      {{- end -}}
    {{- else -}}
      {{- $enabled = true -}}
      {{- $endpoint = $config.endpoint -}}
    {{- end -}}
    {{- if $enabled -}}
      {{- /* no METRICS for now, prometheus discourages the usage of remote-write, see https://prometheus.io/docs/prometheus/latest/querying/api/#remote-write-receiver */ -}}
      {{- /* no LOGS for now, loki is running anyways, so we'd even have to deduplicate the logs somehow */ -}}

      {{- range $signal := list "TRACES" -}}
        {{- if not (hasPrefix "https://" $endpoint) -}}
          {{- $env = set $env (printf "OTEL_EXPORTER_OTLP_%s_INSECURE" $signal) $insecure -}}
        {{- end -}}
        {{- if not (mustRegexMatch "https?://" $endpoint) -}}
          {{- $endpoint = printf "http://%s" $endpoint -}}
        {{- end -}}
        {{- if $serviceProtocol -}}
          {{- $env = set $env (printf "OTEL_EXPORTER_OTLP_%s_PROTOCOL" $signal) $serviceProtocol -}}
        {{- end -}}
        {{- $env = set $env (printf "OTEL_EXPORTER_OTLP_%s_ENDPOINT" $signal) $endpoint -}}
      {{- end -}}
    {{- end -}}
  {{- else -}}
    {{- fail "unsupported telemetry protocol" -}}
  {{- end -}}
  {{- if $env -}}
    {{- $podEnv := list -}}
    {{- range $key, $value := $env -}}
      {{- $podEnv = append $podEnv (dict "name" $key "value" ($value | toString)) -}}
    {{- end -}}
    {{- toYaml $podEnv -}}
  {{- end -}}
{{- end -}}
