{{- $existingKyverno := lookup "helm.toolkit.fluxcd.io/v2" "HelmRelease" "kyverno" "kyverno" -}}
{{- $lastAttemptedRevision := dig "status" "lastAttemptedRevision" "" $existingKyverno }}
{{- $lastAppliedRevision := dig "status" "lastAppliedRevision" "" $existingKyverno }}
{{- if or $lastAppliedRevision $lastAttemptedRevision -}}
  {{- if semverCompare "<3.x.x" ($lastAppliedRevision | default $lastAttemptedRevision) -}}
    {{- fail "Cannot upgrade kyverno in-place, please backup your resources and delete it beforehand, see https://artifacthub.io/packages/helm/kyverno/kyverno#option-1---uninstallation-and-reinstallation" -}}
  {{- end -}}
{{- end -}}
