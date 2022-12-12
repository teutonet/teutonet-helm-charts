{{- define "base-cluster.enabled-namespaces" -}}
{{- $blackList := list "default" "kube-system" "kube-public" "kube-node-lease" -}}
{{- $namespaces := dict -}}
{{- range $name, $namespace := .Values.global.namespaces -}}
  {{- if has $name $blackList -}}
    {{- fail (printf "Using namespace '%s' is not allowed" $name) -}}
  {{- end -}}
  {{- $create := true -}}
  {{- if $namespace.condition -}}
    {{- $create = eq (include "common.tplvalues.render" (dict "value" $namespace.condition "context" (deepCopy $))) "true" -}}
  {{- end -}}
  {{- if $create -}}
    {{- $namespaces := set $namespaces $name (omit $namespace "condition") -}}
  {{- end -}}
{{- end -}}
{{- $namespaces | toYaml -}}
{{- end -}}