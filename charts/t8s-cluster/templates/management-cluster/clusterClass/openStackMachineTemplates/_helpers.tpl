{{- define "t8s-cluster.clusterClass.openStackMachineTemplate.specHash" -}}
  {{- $inputs := (dict
    "spec" (include "t8s-cluster.clusterClass.openStackMachineTemplate.spec" (dict "name" .name "context" .context))
    "infrastructureApiVersion" (include "t8s-cluster.clusterClass.infrastructureApiVersion" (dict))
    ) -}}
  {{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.openStackMachineTemplate.specHashOfControlPlane" -}}
  {{- include "t8s-cluster.clusterClass.openStackMachineTemplate.specHash" (dict "name" "control-plane" "context" .context) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.openStackMachineTemplate.specHashOfNodePools" -}}
  {{- include "t8s-cluster.clusterClass.openStackMachineTemplate.specHash" (dict "name" "compute-plane" "context" .context) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.securityGroups" -}}
  {{- $_ := set . "Values" .context.Values -}}
  {{- $additionalSecurityGroups := list -}}
  {{- if eq .name "control-plane" -}}
    {{- $additionalSecurityGroups = .Values.controlPlane.additionalSecurityGroups -}}
  {{- else -}}
    {{- $additionalSecurityGroups = .Values.additionalComputePlaneSecurityGroups -}}
  {{- end -}}
  {{- $securityGroups := $additionalSecurityGroups | default (list) -}}
  {{- $securityGroups = append $securityGroups "default" | sortAlpha | uniq }}
  {{- $securityGroupsObject := list -}}
  {{- range $name := $securityGroups -}}
    {{- $securityGroupsObject = append $securityGroupsObject (dict "filter" (dict) "name" $name)}}
  {{- end -}}
  {{- toYaml $securityGroupsObject -}}
{{- end -}}
