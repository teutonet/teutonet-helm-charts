{{- if and (eq .Values.ingress.provider "traefik") .Values.ingress.allowNginxConfigurationSnippets -}}
  {{- fail "allowNginxConfigurationSnippets cannot be enabled when using traefik as the ingress provider" -}}
{{- end -}}

{{- if eq .Values.ingress.provider "traefik" -}}
  {{- $existingNginx := lookup "helm.toolkit.fluxcd.io/v2" "HelmRelease" "ingress-nginx" "ingress-nginx" -}}
  {{- if $existingNginx -}}
    {{- fail "Cannot switch to traefik while nginx is installed. If you want to switch to traefik, please delete the HelmRelease 'ingress-nginx/ingress-nginx' first. Note: You might want to set .Values.ingress.IP to the current nginx LoadBalancer IP to keep the same IP. Warning: Switching providers will cause downtime until the new provider is fully deployed." -}}
  {{- end -}}
{{- else if eq .Values.ingress.provider "nginx" -}}
  {{- $existingTraefik := lookup "helm.toolkit.fluxcd.io/v2" "HelmRelease" "ingress" "ingress-controller" -}}
  {{- if $existingTraefik -}}
    {{- fail "Cannot switch to nginx while traefik is installed. If you want to switch to nginx, please delete the HelmRelease 'ingress/ingress-controller' first. Note: You might want to set .Values.ingress.IP to the current traefik LoadBalancer IP to keep the same IP. Warning: Switching providers will cause downtime until the new provider is fully deployed." -}}
  {{- end -}}
{{- end -}}

{{- if .Values.ingress.IP -}}
  {{- $loadBalancerIP := (list nil) | first -}}
  {{- $serviceName := (eq .Values.ingress.provider "traefik") | ternary "ingress-controller" "ingress-nginx-controller" -}}
  {{- $serviceNamespace := (eq .Values.ingress.provider "traefik") | ternary "ingress" "ingress-nginx" -}}
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
