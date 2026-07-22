{{- define "common.dict.filterEmptyValues" -}}
  {{- $out := dict -}}
  {{- range $key, $value := . -}}
    {{- if $value -}}
      {{- $out = set $out $key $value -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $out -}}
{{- end -}}

{{- define "base-cluster.helm.chartSpec" -}}
  {{- include "common.helm.chartSpec" (dict "context" .context "repo" .repo "chart" .chart "prependReleaseName" false "reconcileStrategy" .reconcileStrategy) -}}
{{- end -}}

{{- define "base-cluster.ingress.existingNginx" -}}
  {{- not (empty (lookup "helm.toolkit.fluxcd.io/v2" "HelmRelease" "ingress-nginx" "ingress-nginx")) | ternary "true" "" -}}
{{- end -}}

{{- define "base-cluster.ingress.existingTraefik" -}}
  {{- not (empty (lookup "helm.toolkit.fluxcd.io/v2" "HelmRelease" "ingress" "ingress-controller")) | ternary "true" "" -}}
{{- end -}}

{{- define "base-cluster.ingress.dualMode" -}}
  {{- and (eq (include "base-cluster.ingress.existingNginx" .) "true") (eq (include "base-cluster.ingress.existingTraefik" .) "true") | ternary "true" "" -}}
{{- end -}}

{{- define "base-cluster.ingress.hasNginx" -}}
  {{- or (eq .Values.ingress.provider "nginx") (eq (include "base-cluster.ingress.dualMode" .) "true") | ternary "true" "" -}}
{{- end -}}

{{- define "base-cluster.ingress.hasTraefik" -}}
  {{- or (eq .Values.ingress.provider "traefik") (eq (include "base-cluster.ingress.dualMode" .) "true") | ternary "true" "" -}}
{{- end -}}

{{- define "base-cluster.monitoring.alertmanager.receiver.splitName" -}}
  {{- $name := .name -}}
  {{- $type := $name -}}
  {{- $splitted := splitList " " $name -}}
  {{- if eq (len $splitted) 2 -}}
    {{- $type = index $splitted 0 -}}
    {{- $name = index $splitted 1 -}}
  {{- end -}}
  {{- dict "type" $type "name" $name | toYaml -}}
{{- end -}}
