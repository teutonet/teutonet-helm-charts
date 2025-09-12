{{- define "t8s-cluster.clusterClass.hostedControlPlaneTemplate.specHash" -}}
  {{/* the full context is needed for .Files.Get */}}
  {{- $inputs := dict "spec" (include "t8s-cluster.clusterClass.hostedControlPlaneTemplate.spec" $) -}}
  {{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 -}}
{{- end -}}
