# Custom CoreDNS Image

[![Build and Publish](https://github.com/wittenbude/coredns/actions/workflows/build-release.yaml/badge.svg)](https://github.com/wittenbude/coredns/actions/workflows/build-release.yaml)

This repository contains a custom CoreDNS docker image that uses select plugins. Primarily this image includes the plugins:

- `k8s_gateway`
- `kubenodes`
