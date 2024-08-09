{{- define "t8s-cluster.clusterClass.node.systemdOverrides" -}}
  {{- $files := list -}}
{{/* TODO: containerd is already running when this is set, therefore this is not working {{- range $service := list "containerd" "kubelet" -}}*/}}
  {{- range $service := list "kubelet" -}}
    {{- $files = append $files (dict "content" (include (printf "t8s-cluster.clusterClass.node.systemdOverride.%s" $service) (dict)) "path" (printf "/etc/systemd/system/%s.service.d/slice.conf" $service)) -}}
  {{- end -}}
  {{- $files | toYaml -}}
{{- end -}}
