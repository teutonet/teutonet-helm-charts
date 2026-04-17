{{- define "base-cluster.enabled-namespaces" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $context := .context -}}
  {{- $blackList := list "default" "kube-system" "kube-public" "kube-node-lease" -}}
  {{- $namespaces := dict -}}
  {{- range $name, $namespace := .Values.global.namespaces -}}
    {{- if has $name $blackList -}}
      {{- fail (printf "Using namespace '%s' is not allowed" $name) -}}
    {{- end -}}
    {{- $create := true -}}
    {{- if $namespace.condition -}}
      {{- $create = eq (include "common.tplvalues.render" (dict "value" $namespace.condition "context" (deepCopy $context))) "true" -}}
    {{- end -}}
    {{- if $create -}}
      {{- $namespaces = set $namespaces $name (omit $namespace "condition") -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $namespaces -}}
{{- end -}}

{{- define "base-cluster.namespace.podSecurityStandardsLabels" -}}
  {{- $prefix := "pod-security.kubernetes.io" -}}
  {{- $labels := dict -}}
  {{- $podSecurityStandards := dig "podSecurityStandards" (dict) .namespace -}}
  {{- $levels := dict
      "enforce" (dig "enforce" "none" $podSecurityStandards)
      "warn" (dig "warn" "restricted" $podSecurityStandards)
      "audit" (dig "audit" "restricted" $podSecurityStandards)
  -}}
  {{- range $level, $value := $levels -}}
    {{- if ne $value "none" -}}
      {{- $labels = set $labels (printf "%s/%s" $prefix $level) $value -}}
    {{- end -}}
  {{- end -}}
  {{- toYaml $labels -}}
{{- end -}}
