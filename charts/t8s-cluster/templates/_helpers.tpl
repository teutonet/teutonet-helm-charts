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

{{- define "t8s-cluster.helm.dynamicInterval" -}}
  {{- $existing := lookup "helm.toolkit.fluxcd.io/v2" "HelmRelease" .namespace .name -}}
  {{- $ready := false -}}
  {{- if $existing -}}
    {{- range (dig "status" "conditions" (list) $existing) -}}
      {{- if and (eq .type "Ready") (eq .status "True") -}}
        {{- $ready = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $ready | ternary "1h" "10s" -}}
{{- end -}}

{{- define "t8s-cluster.helm.daemonSetTimeout" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $maxNodes := 0 -}}
  {{- range $name, $nodePool := .Values.nodePools -}}
    {{- $maxNodes = add $maxNodes (max (int $nodePool.replicas) (int (default $nodePool.replicas $nodePool.maxReplicas))) -}}
  {{- end -}}
  {{- printf "%ds" (max 300 (mul $maxNodes 60)) -}}
{{- end -}}

{{- define "t8s-cluster.singleNode" -}}
  {{- $_ := mustMerge . (pick .context "Values") -}}
  {{- $maxWorkerNodes := 0 -}}
  {{- range $name, $nodePool := .Values.nodePools -}}
    {{- $maxWorkerNodes = add $maxWorkerNodes (max (int $nodePool.replicas) (int (default $nodePool.replicas $nodePool.maxReplicas))) -}}
  {{- end -}}
  {{- and .Values.controlPlane.singleNode (eq $maxWorkerNodes 0) | ternary true "" -}}
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
