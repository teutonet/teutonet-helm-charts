{{- define "t8s-cluster.clusterClass.openStackClusterTemplate.specHash" -}}
  {{- $inputs := dict
    "spec" (include "t8s-cluster.clusterClass.openStackClusterTemplate.spec" (dict "context" .context))
    "infrastructureApiVersion" (include "t8s-cluster.clusterClass.infrastructureApiVersion" (dict))
  -}}
  {{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 -}}
{{- end -}}
