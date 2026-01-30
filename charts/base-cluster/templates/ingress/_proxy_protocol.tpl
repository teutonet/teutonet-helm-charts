{{- define "base-cluster.ingress.useProxyProtocol" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- if eq .Values.ingress.useProxyProtocol "auto" -}}
    {{- $cloudProvider := .Values.global.autoConfiguration.cloudProvider }}
    {{- if eq $cloudProvider "auto" }}
      {{- $randomNodeProviderID := dig "spec" "providerID" "" (dig "items" (list) (lookup "v1" "Node" "" "") | first | default (dict)) -}}
      {{- if regexMatch "^openstack://" $randomNodeProviderID -}}
        {{- $cloudProvider = "openstack" -}}
      {{- end -}}
    {{- end -}}

    {{- $useProxyProtocol := true -}}

    {{- if eq $cloudProvider "auto" -}}
      {{/* Cloud provider could not be detected (including empty/missing providerID); treat as unknown cloud and keep proxy protocol enabled as a safe default. */}}
    {{- else if eq $cloudProvider "openstack" -}}
      {{- with .Values.global.autoConfiguration.openstack -}}
        {{- $cloudConfig := lookup "v1" .cloudConfiguration.type .cloudConfiguration.namespace .cloudConfiguration.name -}}
        {{- if $cloudConfig -}}
          {{- $cloudConfigData := dig "data" .cloudConfiguration.field "" $cloudConfig -}}
          {{- if eq .cloudConfiguration.type "Secret" -}}
            {{- $cloudConfigData = b64dec $cloudConfigData -}}
          {{- end -}}
          {{- $lbProvider := regexFind "lb-provider.*" $cloudConfigData -}}
          {{- if regexMatch "ovn" $lbProvider -}}
            {{- $useProxyProtocol = false -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- $useProxyProtocol -}}
  {{- else -}}
    {{- .Values.ingress.useProxyProtocol -}}
  {{- end -}}
{{- end -}}
