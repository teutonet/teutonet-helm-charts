# teuto.net Kubernetes Helm Charts

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/teuto-net)](https://artifacthub.io/packages/search?repo=teuto-net)

The code is provided as-is with no warranties.

## Charts

### base-cluster - Probably the chart you're looking for 😉

Basic components that should be in every cluster, opinionated.

[CLICK ME](./charts/base-cluster)

### t8s-cluster - internal chart used by teuto.net

This chart deploys a TeutonetesCluster and all it's necessary infrastructure components.

[CLICK ME](./charts/t8s-cluster)

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add teutonet https://teutonet.github.io/teutonet-helm-charts
```

You can then run `helm search repo teutonet` to see the charts.

## License

[MIT](https://github.com/teutonet/teutonet-helm-charts/blob/main/LICENSE).

