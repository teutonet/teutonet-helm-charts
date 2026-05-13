{{- define "t8s-cluster.k8s-version" -}}
  {{- with $.Values.version -}}
    {{ printf "v%d.%d.%d" (.major | int) (.minor | int) (.patch | int) }}
  {{- end -}}
{{- end -}}

{{- define "t8s-cluster.hasGPUNodes" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $hasGPUFlavor := false -}}
  {{- range $name, $machineDeploymentClass := .Values.nodePools -}}
    {{- if contains "gpu" (lower $machineDeploymentClass.flavor) -}}
      {{- $hasGPUFlavor = true -}}
    {{- end -}}
  {{- end -}}
  {{- $hasGPUFlavor | ternary true "" -}}
{{- end -}}

{{- define "t8s-cluster.autoscaler.enabled" -}}
  {{- $enabled := false -}}
  {{- range $_, $nodePool := .Values.nodePools -}}
    {{- $maxReplicas := $nodePool.maxReplicas | default $nodePool.replicas -}}
    {{- if ne $nodePool.replicas $maxReplicas -}}
      {{- $enabled = true -}}
    {{- end -}}
  {{- end -}}
  {{- $enabled | ternary true "" -}}
{{- end -}}

{{- define "t8s-cluster.cni" -}}
  {{- if eq .Values.cni "auto" -}}
    {{- if lookup "kustomize.toolkit.fluxcd.io/v1" "Kustomization" .Release.Namespace (printf "%s-cni" .Release.Name) -}}
      calico
    {{- else -}}
      cilium
    {{- end -}}
  {{- else -}}
    {{- .Values.cni -}}
  {{- end -}}
{{- end -}}

{{- define "t8s-cluster.networkPolicy.healthIngress" -}}
- fromEntities:
    - health
{{- end -}}

{{- define "t8s-cluster.networkPolicy.dnsEgress" -}}
  {{- with . -}}
- toEndpoints:
    - matchLabels: {{- . | toYaml | nindent 8 }}
  toPorts:
    - ports:
        - port: "53"
      rules:
        dns:
          - matchPattern: "*"
  {{- end -}}
{{- end -}}

{{- define "t8s-cluster.networkPolicy.kubeApiserverEgress" -}}
- toEntities:
    - kube-apiserver
{{- end -}}

{{- define "t8s-cluster.networkPolicy.controlPlaneEndpointEgress" -}}
  {{- $cluster := lookup "cluster.x-k8s.io/v1beta1" "Cluster" .Release.Namespace .Release.Name -}}
  {{- $host := ((($cluster).spec).controlPlaneEndpoint).host -}}
  {{- if $host -}}
    {{- $port := ((($cluster).spec).controlPlaneEndpoint).port | toString -}}
    {{- if regexMatch "[a-zA-Z]" $host -}}
- toFQDNs:
    - matchName: {{ $host }}
    {{- else if contains ":" $host -}}
- toCIDR:
    - {{ printf "%s/128" $host }}
    {{- else -}}
- toCIDR:
    - {{ printf "%s/32" $host }}
    {{- end }}
  toPorts:
    - ports:
        - port: {{ $port | quote }}
          protocol: TCP
  {{- end -}}
{{- end -}}
