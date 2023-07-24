{{- define "t8s-cluster.clusterClass.infrastructureApiVersion" -}}
infrastructure.cluster.x-k8s.io/v1alpha6
{{- end -}}

{{- define "t8s-cluster.clusterClass.cloudName" -}}
openstack
{{- end -}}

{{- define "t8s-cluster.clusterClass.getIdentityRefSecretName" -}}
  {{- printf "cloud-config-%s" .Release.Name -}}
{{- end -}}
