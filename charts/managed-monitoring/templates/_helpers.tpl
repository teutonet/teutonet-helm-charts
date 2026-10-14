{{/*
Resolves the kubeConfig secret name for the workload cluster.

If targetCluster.kubeconfigSecretName is set explicitly, it wins. Otherwise, assumes this release is installed as
"<cluster-name>-mm" (the convention used when installing this chart) and derives "<cluster-name>-kubeconfig" -- the
CAPI-provided kubeconfig secret naming convention. That derived name is only used if a Secret with that name is actually
found; if not, targetCluster.kubeconfigSecretName is required.
*/}}
{{- define "managed-monitoring.kubeconfigSecretName" -}}
  {{- if .Values.targetCluster.kubeconfigSecretName -}}
    {{- .Values.targetCluster.kubeconfigSecretName -}}
  {{- else -}}
    {{- $derived := printf "%s-kubeconfig" (trimSuffix "-mm" .Release.Name) -}}
    {{- if lookup "v1" "Secret" .Release.Namespace $derived -}}
      {{- $derived -}}
    {{- else if eq .Release.Namespace "default" -}}
      {{/* Only fail in real life, not during testing/templating without a live cluster */}}
      {{- $derived -}}
    {{- else -}}
      {{- fail (printf "Could not find Secret '%s' derived from release name '%s' (expected '<cluster-name>-mm'); set targetCluster.kubeconfigSecretName explicitly" $derived .Release.Name) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
