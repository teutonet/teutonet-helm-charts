{{- define "t8s-cluster.workload.hasServiceMonitorResource" -}}
{{- .Capabilities.APIVersions.Has "monitoring.coreos.com/v1/ServiceMonitor" -}}
{{- end -}}