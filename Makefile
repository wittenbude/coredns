LOCKFILE = lockfile.env

.PHONY: build
.SILENT: build
build:
	cat lockfile.env | while read line; do echo --build-arg "$$line"; done | xargs docker build -t local/coredns .

.PHONY: update
.SILENT: update
update:
	> $(LOCKFILE)
	printf "COREDNS_VERSION=" >> $(LOCKFILE)
	git -c 'versionsort.suffix=-' ls-remote --tags --refs --sort='-v:refname' https://github.com/coredns/coredns | head -n 1 | cut -d '/' -f 3 >> $(LOCKFILE)
	printf "GATEWAY_VERSION=" >> $(LOCKFILE)
	git -c 'versionsort.suffix=-' ls-remote --tags --refs --sort='-v:refname' https://github.com/ori-edge/k8s_gateway | head -n 1 | cut -d '/' -f 3 >> $(LOCKFILE)

.PHONY: help
.SILENT: help
help:
	echo "This Makefile contains the following commands:"
	echo ""
	echo "    build (default) - Builds the docker image."
	echo "    update          - Updates dependencies."
	echo "    help            - Displays this help message."
	echo ""
	echo "make build"
	echo "  The build step is intended to be used for manual testing. It does"
	echo "  not produce a correctly tagged image. During CI this is not executed."
