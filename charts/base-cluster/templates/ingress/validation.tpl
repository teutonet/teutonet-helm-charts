{{- if and (eq .Values.ingress.provider "traefik") .Values.ingress.allowNginxConfigurationSnippets -}}
  {{- fail "allowNginxConfigurationSnippets cannot be enabled when using traefik as the ingress provider" -}}
{{- end -}}

{{- if and (eq .Values.ingress.provider "nginx") .Values.ingress.useTraefikNginxCompatibility -}}
  {{- fail "useTraefikNginxCompatibility cannot be enabled when using nginx as the ingress provider" -}}
{{- end -}}

{{- if and (eq .Values.ingress.provider "envoy") .Values.ingress.allowNginxConfigurationSnippets -}}
  {{- fail "allowNginxConfigurationSnippets cannot be enabled when using envoy as the ingress provider" -}}
{{- end -}}

{{- if and (eq .Values.ingress.provider "envoy") .Values.ingress.useTraefikNginxCompatibility -}}
  {{- fail "useTraefikNginxCompatibility cannot be enabled when using envoy as the ingress provider" -}}
{{- end -}}

{{- if eq .Values.ingress.provider "envoy" -}}
  {{- $telemetryConf := include "common.telemetry.conf" (dict "protocol" "otlp" "global" .Values.global) | fromYaml -}}
  {{- if and $telemetryConf.enabled (not $telemetryConf.serviceName) -}}
    {{- fail "Explicit (non-auto-discovered) telemetry endpoints are not supported with the envoy ingress provider yet" -}}
  {{- end -}}
  {{- range $name, $cfg := .Values.ingress.extraPorts -}}
    {{- if or (eq $name "http") (eq $name "https") -}}
      {{- fail (printf "ingress.extraPorts key %q is reserved for the envoy Gateway's built-in http/https listeners, please choose a different name" $name) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- $existingNginx := include "base-cluster.ingress.existingNginx" . -}}
{{- $existingTraefik := include "base-cluster.ingress.existingTraefik" . -}}
{{- if and $existingNginx $existingTraefik -}}
  {{/* both are deployed, skip any checks; manual dual-mode */}}
{{- else -}}
  {{- if eq .Values.ingress.provider "traefik" -}}
    {{- if $existingNginx -}}
      {{- fail "Cannot switch to traefik while nginx is installed. If you want to switch to traefik, please delete the HelmRelease 'ingress-nginx/ingress-nginx' first. Note: You might want to set .Values.ingress.IP to the current nginx LoadBalancer IP to keep the same IP. Warning: Switching providers will cause downtime until the new provider is fully deployed." -}}
    {{- end -}}
  {{- else if eq .Values.ingress.provider "nginx" -}}
    {{- if $existingTraefik -}}
      {{- fail "Cannot switch to nginx while traefik is installed. If you want to switch to nginx, please delete the HelmRelease 'ingress/ingress-controller' first. Note: You might want to set .Values.ingress.IP to the current traefik LoadBalancer IP to keep the same IP. Warning: Switching providers will cause downtime until the new provider is fully deployed." -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- if .Values.ingress.IP -}}
  {{- $loadBalancerIP := (list nil) | first -}}
  {{- $serviceName := (eq .Values.ingress.provider "nginx") | ternary "ingress-nginx-controller" "ingress-controller" -}}
  {{- $serviceNamespace := (eq .Values.ingress.provider "nginx") | ternary "ingress-nginx" "ingress" -}}
  {{- $existingService := lookup "v1" "Service" $serviceNamespace $serviceName -}}
  {{- if $existingService -}}
    {{- $existingSpecIP := $existingService.spec.loadBalancerIP -}}
    {{- if $existingSpecIP -}}
      {{- $loadBalancerIP = $existingSpecIP -}}
    {{- else -}}
      {{- $existingStatusLoadbalancerIngresses := dig "status" "loadBalancer" "ingress" (list) $existingService -}}
      {{- if not (empty $existingStatusLoadbalancerIngresses) -}}
        {{- $existingStatusLoadbalancerIngress := $existingStatusLoadbalancerIngresses | first -}}
        {{- if $existingStatusLoadbalancerIngress.ip -}}
          {{- $loadBalancerIP = $existingStatusLoadbalancerIngress.ip -}}
        {{- else if $existingStatusLoadbalancerIngress.hostname -}}
          {{- $nipIOIP := $existingStatusLoadbalancerIngress.hostname | trimSuffix ".nip.io" -}}
          {{- if regexMatch "^((25[0-5]|(2[0-4]|1\\d|[1-9]|)\\d)\\.?\\b){4}$" $nipIOIP -}}
            {{- $loadBalancerIP = $nipIOIP -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- if and $loadBalancerIP (ne $loadBalancerIP .Values.ingress.IP) -}}
      {{- fail (printf "You cannot change the LoadBalancerIP on an existing service, if you really want to, please delete the service '%s/%s' beforehand" $serviceNamespace $serviceName) -}}
  {{- end -}}
{{- end -}}
