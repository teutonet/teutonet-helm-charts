{{- define "t8s-cluster.clusterClass.node.systemdOverride.containerd" -}}
[Service]
Slice={{- include "t8s-cluster.clusterClass.systemdOverride.slice.runtime" (dict) -}}
{{- end -}}
