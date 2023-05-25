{{- define "t8s-cluster.clusterClass.openStackMachineTemplate.specHash" -}}
  {{- $inputs := (dict
    "spec" (include "t8s-cluster.clusterClass.openStackMachineTemplate.spec" (dict "machineDeploymentClass" .machineDeploymentClass "name" .name "context" .context))
    "infrastructureApiVersion" (include "t8s-cluster.clusterClass.infrastructureApiVersion" (dict))
    ) -}}
  {{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.openStackMachineTemplate.specHashOfControlPlane" -}}
  {{- include "t8s-cluster.clusterClass.openStackMachineTemplate.specHash" (dict "machineDeploymentClass" .context.Values.controlPlane "name" "control-plane" "context" .context) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.openStackMachineTemplate.specHashOfWorkers" -}}
  {{- include "t8s-cluster.clusterClass.openStackMachineTemplate.specHash" (dict "machineDeploymentClass" .worker "name" "worker" "context" .context) -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.securityGroups" -}}
  {{- $securityGroups := .additionalSecurityGroups | default (list) -}}
  {{- $securityGroups = append $securityGroups "default" | sortAlpha | uniq }}
  {{- $securityGroupsObject := list -}}
  {{- range $name := $securityGroups -}}
    {{- $securityGroupsObject = append $securityGroupsObject (dict "filter" (dict) "name" $name)}}
  {{- end -}}
  {{- $securityGroupsObject | toYaml -}}
{{- end -}}
