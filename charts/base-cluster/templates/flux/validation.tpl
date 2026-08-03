{{- $existingKustomization := lookup "kustomize.toolkit.fluxcd.io/v1" "Kustomization" "ingress" "gateway-api" -}}
{{- if $existingKustomization -}}
  {{- $deletionPolicy := dig "spec" "deletionPolicy" "" $existingKustomization -}}
  {{- if ne $deletionPolicy "Orphan" -}}
    {{- fail "The existing 'gateway-api' Kustomization must have spec.deletionPolicy set to 'Orphan' before upgrading, otherwise the gateway-api CRDs (and everything relying on them) will be pruned when it is replaced: kubectl patch kustomization gateway-api -n ingress --type=merge -p '{\"spec\":{\"deletionPolicy\":\"Orphan\"}}'" -}}
  {{- end -}}
{{- end -}}
