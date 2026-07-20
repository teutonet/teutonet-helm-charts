# base-cluster ingress architecture

- `.Values.ingress.provider` is the sole source of truth for which controller HelmRelease actually deploys (`templates/ingress/nginx.yaml`/`traefik.yaml`) — never gate that on dual-mode detection.
- "Dual-mode" (`base-cluster.ingress.dualMode`/`hasNginx`/`hasTraefik` in `_helpers.tpl`) only widens *supporting* config — cert-manager's `enableGatewayAPI`, gateway-api CRDs, Grafana dashboards — for a manual provider migration. It is not a supported deployment topology.
