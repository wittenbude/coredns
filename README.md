# Custom CoreDNS Image

This repository contains a custom CoreDNS docker image that uses select plugins. Primarily this image includes the plugins:

- [`k8s_gateway`](https://github.com/k8s-gateway/k8s_gateway)
- [`kubenodes`](https://coredns.io/explugins/kubenodes/)
- [`warnlist`](https://coredns.io/explugins/warnlist/)
