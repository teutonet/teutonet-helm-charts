{{- define "common.networkPolicy.rule.from.kube-apiserver" -}}
  {{- $useCilium := eq .cilium true -}}
  {{- $identities := include "common.networkPolicy.identity.kube-apiserver" (dict) | fromYamlArray -}}
  {{- $rules := list -}}
  {{- $ports := list -}}
  {{/* Process ports from input, handling both a single as well as a list of protocols */}}
  {{- if hasKey . "ports" -}}
    {{- range $port, $protocols := (.ports | default (list)) -}}
      {{- $_protocols := $protocols -}}
      {{- if kindIs "string" $protocols -}}
        {{- $_protocols = list $protocols -}}
      {{- end -}}
      {{- range $protocol := $_protocols -}}
        {{- $ports = append $ports (dict "port" $port "protocol" $protocol) -}}
      {{- end }}
    {{- end -}}
  {{- end -}}
  {{/* Create rules for each identity based on network policy type */}}
  {{- range $identity := $identities -}}
    {{- $rule := dict -}}
    {{- $endpoint := $identity.endpoint -}}
    {{/* For cilium use entity or endpoint based rules */}}
    {{- if $useCilium -}}
      {{- if hasKey $identity "entity" -}}
        {{- $rule = dict "fromEntities" (list $identity.entity) -}}
      {{- else -}}
        {{- $matchLabels := dict "io.kubernetes.pod.namespace" $endpoint.namespace -}}
        {{- if hasKey $endpoint "serviceAccount" -}}
          {{- $matchLabels = set $matchLabels "io.cilium.k8s.policy.serviceaccount" $endpoint.serviceAccount -}}
        {{- else -}}
          {{- $matchLabels = mustMerge $matchLabels $endpoint.pod -}}
        {{- end -}}
        {{- $rule = dict "fromEndpoints" (list (dict "matchLabels" $matchLabels)) -}}
      {{- end -}}
      {{- if $ports }}
        {{- $rule = set $rule "toPorts" (list (dict "ports" $ports)) -}}
      {{- end -}}
    {{/* For native k8s use namespace- and podSelector */}}
    {{- else -}}
      {{- $from := dict "namespaceSelector" (dict "matchLabels" (dict "kubernetes.io/metadata.name" $endpoint.namespace)) -}}
      {{- $from = set $from "podSelector" (dict "matchLabels" $endpoint.pod) -}}
      {{- $rule = set $rule "from" (list $from) -}}
      {{- if $ports -}}
        {{- $rule = set $rule "ports" $ports -}}
      {{- end -}}
    {{- end -}}

    {{- $rules = append $rules $rule -}}
  {{- end -}}

  {{- toYaml ($rules | default (dict)) -}}
{{- end -}}
