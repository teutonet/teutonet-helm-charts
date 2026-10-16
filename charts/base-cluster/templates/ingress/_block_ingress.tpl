{{- define "base-cluster.ingress.blockIngressResource" -}}
  {{- if kindIs "string" .Values.ingress.blockIngressResource -}}
    {{- /* ValidatingAdmissionPolicy is only available as v1 since kubernetes 1.30 */ -}}
    {{- and (eq .Values.ingress.provider "envoy") (.Capabilities.APIVersions.Has "admissionregistration.k8s.io/v1/ValidatingAdmissionPolicy") -}}
  {{- else -}}
    {{- .Values.ingress.blockIngressResource -}}
  {{- end -}}
{{- end -}}
