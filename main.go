package main

// This file purely exists to tell go our requirements
// This enables us to use things like go mod tidy

import (
	"github.com/coredns/coredns/core/dnsserver"
	_ "github.com/coredns/coredns/core/plugin"
	"github.com/coredns/coredns/coremain"

	_ "github.com/infobloxopen/kubenodes"
	_ "github.com/ori-edge/k8s_gateway"
)

var insertAfter = "kubernetes"

func init() {
	var directives []string

	for _, name := range dnsserver.Directives {
		directives = append(directives, name)
		if name == insertAfter {
			directives = append(directives, "kubenodes", "k8s_gateway")
		}
	}
	directives = append(directives, "kubeapi")

	dnsserver.Directives = directives
}

func main() {
	coremain.Run()
}
