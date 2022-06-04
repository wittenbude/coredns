FROM golang:alpine AS builder
ARG COREDNS_VERSION
ARG GATEWAY_VERSION

RUN apk add git ca-certificates && update-ca-certificates

RUN git clone https://github.com/coredns/coredns --depth=1 --branch="$COREDNS_VERSION"
WORKDIR /go/coredns

RUN go get \
    "github.com/infobloxopen/kubenodes" \
    "github.com/ori-edge/k8s_gateway@$GATEWAY_VERSION"

COPY plugin.cfg .

RUN go generate && go build


FROM scratch

COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /go/coredns/coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
