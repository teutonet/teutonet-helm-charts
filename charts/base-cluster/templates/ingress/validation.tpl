{{- if .Values.ingress.IP -}}
  {{- $loadBalancerIP := (list nil) | first -}}
  {{- $existingService := lookup "v1" "Service" "ingress-nginx" "ingress-nginx-controller" -}}
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
      {{- fail "You cannot change the LoadBalancerIP on an existing service, if you really want to, please delete the service 'ingress-nginx/ingress-nginx-controller' beforehand" -}}
  {{- end -}}
{{- end -}}
