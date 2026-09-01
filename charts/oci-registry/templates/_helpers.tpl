{{- define "oci-registry.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.registry.image "global" .Values.global) }}
{{- end -}}

{{- define "oci-registry.upstreamSecretName" -}}
{{ printf "%s-upstream" (include "common.names.fullname" .) }}
{{- end -}}

{{- define "oci-registry.s3SecretName" -}}
{{ .Values.registry.storage.s3.authSecret.name | default (printf "%s-s3" (include "common.names.fullname" .)) }}
{{- end -}}

{{- define "oci-registry.tlsSecretName" -}}
{{ printf "%s-tls" (include "common.names.fullname" .) }}
{{- end -}}

{{- define "oci-registry.requiredHostname" -}}
{{ required "registry.ingress.hostname is required when registry.ingress.enabled is true" .Values.registry.ingress.hostname }}
{{- end -}}
