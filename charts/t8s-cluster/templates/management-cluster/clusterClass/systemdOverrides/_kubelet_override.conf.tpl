{{- define "t8s-cluster.clusterClass.node.systemdOverride.kubelet" -}}
[Service]
Slice={{- include "t8s-cluster.clusterClass.systemdOverride.slice.runtime" (dict) -}}
{{- end -}}
