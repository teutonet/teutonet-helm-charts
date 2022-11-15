{{- define "base-cluster.kyverno.ignoredNamespaces" -}}
{{- $ns := list "kube-system" "flux-system" -}}
{{- $ns = append $ns "accounts" -}}
{{- $ns = append $ns "local-provisioner" -}}
{{- $ns = append $ns "mysql" -}}
{{- $ns = append $ns "postgres" -}}
{{- $ns = append $ns "velero" -}}
{{- $ns | sortAlpha | toYaml -}}
{{- end -}}