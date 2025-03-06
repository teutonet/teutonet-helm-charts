{{- define "chirpstack.securityContext" -}}
runAsGroup: 65534
runAsUser: 65534
runAsNonRoot: true
fsGroup: 65534
{{- end -}}

{{- define "chirpstack.containerSecurityContext" -}}
capabilities:
  drop:
    - ALL
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
privileged: false
{{- end -}}

{{- define "chirpstack.securityOptions" -}}
hostIPC: false
hostNetwork: false
hostPID: false
{{- end -}}

{{- define "chirpstack.commonMetadata" -}}
name: {{ include "chirpstack.fullname" . }}
namespace: {{ .context.Release.Namespace }}
labels: {{- include "common.labels.standard" .context | nindent 2 }}
  app.kubernetes.io/component: {{ .component }}
{{- end -}}

{{- define "chirpstack.fullname" -}}
{{- $_ := .component | required "Param `.component` is missing for `chirpstack.fullname`" -}}
{{- printf "%s-%s" (include "common.names.fullname" .context) .component -}}
{{- end -}}