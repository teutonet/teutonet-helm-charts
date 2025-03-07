{{- define "common.networkpolicy.cilium.from.kube-apiserver" -}}
  {{- $identities := include "common.networkpolicy.identities.kube-apiserver" (dict "cilium" true) | fromYamlArray -}}
  {{- $policies := list -}}
  {{- $toPorts := .toPorts -}}
  {{- if .ports -}}
    {{- $toPorts = $toPorts | default (list) -}}
    {{- $ports := list -}}
    {{- range $port, $protocols := (.ports | default (list)) -}}
      {{- $_protocols := $protocols -}}
      {{- if kindIs "string" $protocols -}}
        {{- $_protocols = list $protocols -}}
      {{- end -}}
      {{- range $protocol := $_protocols -}}
        {{- $ports = append $ports (dict "port" $port "protocol" $protocol) -}}
      {{- end }}
    {{- end -}}
    {{- $toPorts = append $toPorts (dict "ports" $ports) -}}
  {{- end -}}
  {{- range $identity := $identities -}}
    {{- $_identity := $identity -}}
    {{- if $toPorts -}}
      {{- $_identity = mustMerge $identity (dict "toPorts" $toPorts) -}}
    {{- end -}}
    {{- $policies = append $policies $_identity -}}
  {{- end -}}
  {{- toYaml $policies -}}
{{- end -}}
