FROM golang:alpine AS builder
ARG COREDNS_VERSION
ARG GATEWAY_VERSION

RUN apk update && apk add git ca-certificates && update-ca-certificates

RUN git clone https://github.com/coredns/coredns --depth=1 --branch="$COREDNS_VERSION"
WORKDIR /go/coredns

RUN go get \
    "github.com/infobloxopen/kubenodes" \
    "github.com/ori-edge/k8s_gateway@$GATEWAY_VERSION"

COPY plugin.cfg .

RUN go generate
RUN CGO_ENABLED=0 go build -v -o /coredns


FROM scratch

COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
