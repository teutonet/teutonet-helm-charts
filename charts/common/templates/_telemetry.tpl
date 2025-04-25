{{- define "common.telemetry.env" -}}
  {{- $conf := include "common.telemetry.conf" (dict "protocol" .protocol "global" .global) | fromYaml -}}
  {{- if $conf.enabled -}}
    {{- $env := dict -}}
    {{/* for now only otlp is supported */}}
    {{- if eq .protocol "otlp" -}}
      {{- $endpoint := $conf.endpoint -}}
      {{- $serviceProtocol := $conf.serviceProtocol -}}
      {{- /* no METRICS for now, prometheus discourages the usage of remote-write, see https://prometheus.io/docs/prometheus/latest/querying/api/#remote-write-receiver */ -}}
      {{- /* no LOGS for now, loki is running anyways, so we'd even have to deduplicate the logs somehow */ -}}

      {{- range $signal := list "TRACES" -}}
        {{- if not (hasPrefix "https://" $endpoint) -}}
          {{- $env = set $env (printf "OTEL_EXPORTER_OTLP_%s_INSECURE" $signal) $conf.insecure -}}
        {{- end -}}
        {{- if not (mustRegexMatch "https?://" $endpoint) -}}
          {{- $endpoint = printf "http://%s" $endpoint -}}
        {{- end -}}
        {{- if $serviceProtocol -}}
          {{- $env = set $env (printf "OTEL_EXPORTER_OTLP_%s_PROTOCOL" $signal) $serviceProtocol -}}
        {{- end -}}
        {{- $env = set $env (printf "OTEL_EXPORTER_OTLP_%s_ENDPOINT" $signal) $endpoint -}}
      {{- end -}}
    {{- else -}}
      {{- fail "unsupported telemetry protocol" -}}
    {{- end -}}
    {{- $podEnv := list -}}
    {{- range $key, $value := $env -}}
      {{- $podEnv = append $podEnv (dict "name" $key "value" ($value | toString)) -}}
    {{- end -}}
    {{- toYaml $podEnv -}}
  {{- end -}}
{{- end -}}

{{/*
Returns a dict for configuring otel traces, containing `enabled`, `host`, `port`, `endpoint`, `serviceProtocol`, `insecure`.
{{- $telemetryConf := include "common.telemetry.conf" (dict "protocol" "otlp" "serviceProtocol" "grpc" "global" $) | fromYaml }}
`serviceProtocol` is optional, will just not be used (probably using `grpc`).
Be sure to cast the port back to int by using `{{ int64 $telemetryConf.port }}` for usage, it's a float by default
*/}}
{{- define "common.telemetry.conf" -}}
  {{- $conf := dict "enabled" false -}}
  {{- $protocol := .protocol -}}
  {{- $config := dig "telemetry" $protocol (dict) (.global | default (dict)) -}}
  {{- $enabled := false -}}
  {{- $host := "" -}}
  {{- $port := 0 -}}
  {{- $endpoint := "" -}}
  {{- $serviceProtocol := .serviceProtocol -}}
  {{- $insecure := dig "insecure" true $config -}}
  {{- if eq (dig "endpoint" "auto" $config) "auto" -}}
    {{- $services := (dict "monitoring" (list "telemetry-collector" "alloy" "open-telemetry-collector-opentelemetry-collector")) -}}
    {{- range $namespace, $serviceNames := $services -}}
      {{- range $serviceName := $serviceNames -}}
        {{- $service := lookup "v1" "Service" $namespace $serviceName -}}
        {{- if $service -}}
          {{- $servicePortPort := 0 -}}
          {{- range $portSpec := dig "spec" "ports" (list) $service -}}
            {{- $servicePortName := dig "name" "" $portSpec -}}
            {{- $appProtocol := dig "appProtocol" "" $portSpec -}}
            {{- if and (hasPrefix $protocol $servicePortName) (or (not $serviceProtocol) (hasSuffix (printf "-%s" $serviceProtocol) $servicePortName) (eq $appProtocol $serviceProtocol)) -}}
              {{- $servicePortPort = dig "port" 0 $portSpec -}}
              {{/* see https://opentelemetry.io/docs/languages/sdk-configuration/otlp-exporter/#otel_exporter_otlp_protocol */}}
              {{- if and (not $serviceProtocol) (eq $protocol "otlp") (has $appProtocol (list "grpc" "http/protobuf" "http/json")) -}}
                {{- $serviceProtocol = $appProtocol -}}
              {{- end -}}
              {{- $enabled = true -}}
              {{- break -}}
            {{- end -}}
          {{- end -}}
          {{- if $enabled -}}
            {{- $host = printf "%s.%s" $serviceName $namespace -}}
            {{- $port = $servicePortPort -}}
            {{- $endpoint = printf "%s:%d" $host $port -}}
            {{- break -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
      {{- if $enabled -}}
        {{- break -}}
      {{- end -}}
    {{- end -}}
  {{- else -}}
    {{- $enabled = true -}}
    {{- $endpoint = $config.endpoint -}}
    {{- $splittedEndpoint := splitList $endpoint ":" -}}
    {{- $host = $config.host | default ($splittedEndpoint | first) -}}
    {{- if $config.port -}}
      {{- $port = $config.port -}}
    {{- else if eq ($splittedEndpoint | len) 2 -}}
      {{- $port = $splittedEndpoint | last | int64 -}}
    {{- else -}}
      {{- fail "You need to provide the port, at least in the endpoint" -}}
    {{- end -}}
  {{- end -}}
  {{- if $enabled -}}
    {{- $conf = set $conf "enabled" true -}}
    {{- if not (hasPrefix "https://" $endpoint) -}}
      {{- $conf = set $conf "insecure" $insecure -}}
    {{- end -}}
    {{- if $serviceProtocol -}}
      {{- $conf = set $conf "serviceProtocol" $serviceProtocol -}}
    {{- end -}}
    {{- if not (mustRegexMatch "https?://" $endpoint) -}}
      {{- $endpoint = printf "http://%s" $endpoint -}}
    {{- end -}}
    {{- $conf = set $conf "host" $host -}}
    {{- $conf = set $conf "port" $port -}}
    {{- $conf = set $conf "endpoint" $endpoint -}}
  {{- end -}}
  {{- toYaml $conf -}}
{{- end -}}
