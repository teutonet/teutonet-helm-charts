{{- define "t8s-cluster.networkPolicy.gpu-operator" -}}
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: gpu-operator
  namespace: kube-system
  labels: {{- include "common.helm.labels" (dict) | nindent 4 }}
spec:
  endpointSelector:
    matchLabels:
      app: gpu-operator
      app.kubernetes.io/component: gpu-operator
  ingress:
    {{- include "t8s-cluster.networkPolicy.healthIngress" . | nindent 4 }}
  egress:
    {{- include "t8s-cluster.networkPolicy.dnsEgress" .dnsLabels | nindent 4 }}
    {{- include "t8s-cluster.networkPolicy.kubeApiserverEgress" . | nindent 4 }}
    - toEntities:
        - world # controller talks to workload cluster API and registries
{{- end -}}

{{- define "t8s-cluster.networkPolicy.gpu-operator-nfd-master" -}}
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: gpu-operator-node-feature-discovery-master
  namespace: kube-system
  labels: {{- include "common.helm.labels" (dict) | nindent 4 }}
spec:
  endpointSelector:
    matchLabels:
      app.kubernetes.io/instance: gpu-operator
      app.kubernetes.io/name: node-feature-discovery
      role: master
  ingress:
    {{- include "t8s-cluster.networkPolicy.healthIngress" . | nindent 4 }}
    - fromEndpoints:
        - matchLabels:
            io.kubernetes.pod.namespace: kube-system
            app.kubernetes.io/instance: gpu-operator
            app.kubernetes.io/name: node-feature-discovery
            role: worker
      toPorts:
        - ports:
            - port: "8080"
              protocol: TCP
  egress:
    {{- include "t8s-cluster.networkPolicy.dnsEgress" .dnsLabels | nindent 4 }}
    {{- include "t8s-cluster.networkPolicy.kubeApiserverEgress" . | nindent 4 }}
{{- end -}}

{{- define "t8s-cluster.networkPolicy.gpu-operator-nfd-gc" -}}
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: gpu-operator-node-feature-discovery-gc
  namespace: kube-system
  labels: {{- include "common.helm.labels" (dict) | nindent 4 }}
spec:
  endpointSelector:
    matchLabels:
      app.kubernetes.io/instance: gpu-operator
      app.kubernetes.io/name: node-feature-discovery
      role: gc
  ingress:
    {{- include "t8s-cluster.networkPolicy.healthIngress" . | nindent 4 }}
  egress:
    {{- include "t8s-cluster.networkPolicy.dnsEgress" .dnsLabels | nindent 4 }}
    {{- include "t8s-cluster.networkPolicy.kubeApiserverEgress" . | nindent 4 }}
{{- end -}}

{{- define "t8s-cluster.networkPolicy.gpu-operator-nfd-worker" -}}
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: gpu-operator-node-feature-discovery-worker
  namespace: kube-system
  labels: {{- include "common.helm.labels" (dict) | nindent 4 }}
spec:
  endpointSelector:
    matchLabels:
      app.kubernetes.io/instance: gpu-operator
      app.kubernetes.io/name: node-feature-discovery
      role: worker
  ingress:
    {{- include "t8s-cluster.networkPolicy.healthIngress" . | nindent 4 }}
  egress:
    {{- include "t8s-cluster.networkPolicy.dnsEgress" .dnsLabels | nindent 4 }}
    {{- include "t8s-cluster.networkPolicy.kubeApiserverEgress" . | nindent 4 }}
    - toEndpoints:
        - matchLabels:
            io.kubernetes.pod.namespace: kube-system
            app.kubernetes.io/instance: gpu-operator
            app.kubernetes.io/name: node-feature-discovery
            role: master
      toPorts:
        - ports:
            - port: "8080"
              protocol: TCP
{{- end -}}
