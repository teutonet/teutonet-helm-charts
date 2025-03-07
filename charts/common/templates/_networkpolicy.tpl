{{- define "common.networkpolicy.identities.kube-apiserver" -}}
  {{- $identities := list -}}
  {{- $inClusterControlPlaneEntity := (dict "fromEntities" (list "kube-apiserver")) -}}
  {{- $konnectivityDaemonSetNamespace := "kube-system" -}}
  {{- $konnectivityDameonSetName := "konnectivity-agent" -}}
  {{- $konnectivityProxiedControlPlaneMatchLabels := dict
      "io.kubernetes.pod.namespace" $konnectivityDaemonSetNamespace
      "k8s-app" $konnectivityDameonSetName
  -}}
  {{- $konnectivityProxiedControlPlaneEndpoint := (dict "fromEndpoints" (list (dict "matchLabels" $konnectivityProxiedControlPlaneMatchLabels))) -}}
  {{- $matchLabels := dict -}}
  {{- if lookup "apps/v1" "DaemonSet" $konnectivityDaemonSetNamespace $konnectivityDameonSetName -}}
    {{- $identities = append $identities $konnectivityProxiedControlPlaneEndpoint -}}
  {{- else -}}
    {{- $identities = append $identities $inClusterControlPlaneEntity -}}
  {{- end -}}
  {{- toYaml $identities -}}
{{- end -}}
