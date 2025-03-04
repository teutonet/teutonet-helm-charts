{{- define "t8s-cluster.clusterClass.kamajiControlPlaneTemplate.specHash" -}}
  {{/* the full context is needed for .Files.Get */}}
  {{- $inputs := dict "spec" (include "t8s-cluster.clusterClass.kamajiControlPlaneTemplate.spec" $) -}}
  {{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 -}}
{{- end -}}
