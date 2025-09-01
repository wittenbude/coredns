package main

// This file purely exists to tell go our requirements
// This enables us to use things like go mod tidy

import (
	"github.com/coredns/coredns/core/dnsserver"
	_ "github.com/coredns/coredns/core/plugin"
	"github.com/coredns/coredns/coremain"

	_ "github.com/infobloxopen/kubenodes"
	_ "github.com/k8s-gateway/k8s_gateway"
	_ "github.com/relekang/coredns-blocklist"
)

var insertAfter = "kubernetes"

func init() {
	directives := make([]string, 0, len(dnsserver.Directives)+4)

	for _, name := range dnsserver.Directives {
		directives = append(directives, name)
		switch name {
		case "kubernetes":
			directives = append(directives, "kubenodes", "k8s_gateway")
		case "acl":
			directives = append(directives, "blocklist")
		}
	}
	directives = append(directives, "kubeapi")

	dnsserver.Directives = directives
}

func main() {
	coremain.Run()
}
