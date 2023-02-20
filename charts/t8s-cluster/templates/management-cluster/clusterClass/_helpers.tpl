{{- define "t8s-cluster.clusterClass.infrastructureApiVersion" -}}
infrastructure.cluster.x-k8s.io/v1alpha5
{{- end -}}

{{- define "t8s-cluster.clusterClass.cloudName" -}}
openstack
{{- end -}}

{{- define "t8s-cluster.clusterClass.imageVersion" -}}
t8s-engine-2004-kube-{{ include "t8s-cluster.k8s-version" $ }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.getIdentityRefSecretName" -}}
cloud-config-{{ .Release.Name }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.sshKeyName" -}}
  {{ .Values.sshKeyName }}
{{- end -}}

{{- define "t8s-cluster.clusterClass.cloud" -}}
  {{- get .Values.clouds .Values.cloud | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.controlPlaneAvailabilityZones" -}}
  {{- get (include "t8s-cluster.clusterClass.cloud" . | fromYaml) "controlPlaneAvailabilityZones" | default (list) | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.dnsNameservers" -}}
  {{- get (include "t8s-cluster.clusterClass.cloud" . | fromYaml) "dnsNameservers" | toYaml -}}
{{- end -}}

{{- define "t8s-cluster.clusterClass.managedSecurityGroups" -}}
  {{- $managedSecurityGroups := true -}}
  {{- range $name, $machineDeploymentClass := (dict "worker" .Values.worker "control-plane" .Values.controlPlane) }}
    {{- if $machineDeploymentClass -}}
      {{- if not (empty $machineDeploymentClass.securityGroups) -}}
        {{- $managedSecurityGroups = false -}}
        {{- break -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $managedSecurityGroups -}}
{{- end -}}