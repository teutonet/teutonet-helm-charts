{{- define "base-cluster.kyverno.ignoredNamespaces" -}}
{{- $ns := list "kube-system" "flux-system" -}}
{{- $ns = append $ns "accounts" -}}
{{- $ns = append $ns "cert-manager" -}}
{{- $ns = append $ns "ingress-nginx" -}}
{{- $ns = append $ns "local-provisioner" -}}
{{- $ns = append $ns "monitoring" -}}
{{- $ns = append $ns "mysql" -}}
{{- $ns = append $ns "postgres" -}}
{{- $ns = append $ns "velero" -}}
{{- $ns = append $ns "metrics" -}}
{{- $ns = append $ns "loki" -}}
{{- $ns | sortAlpha | toYaml -}}
{{- end -}}