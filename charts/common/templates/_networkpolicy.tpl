{{- define "common.networkPolicy.identity.kube-apiserver" -}}
  {{- $identities := list -}}
  {{- $kubeSystemNamespace := "kube-system" -}}
  {{- $konnectivityName := "konnectivity-agent" -}}
  {{- if or (lookup "apps/v1" "DaemonSet" $kubeSystemNamespace $konnectivityName) (lookup "apps/v1" "Deployment" $kubeSystemNamespace $konnectivityName) -}}
    {{- $identities = append $identities (dict "endpoint" (dict
        "namespace" $kubeSystemNamespace
        "pod" (dict
          "k8s-app" $konnectivityName
        )
        "serviceAccount" $konnectivityName
      ))
    -}}
  {{- else -}}
    {{- $identities = append $identities (dict "endpoint" (dict
        "namespace" $kubeSystemNamespace
        "pod" (dict
          "tier" "control-plane"
          "component" "kube-apiserver"
        )
      ))
     -}}
    {{- $identities = append $identities (dict "entity" "kube-apiserver") -}}
  {{- end -}}
  {{- toYaml $identities -}}
{{- end -}}
