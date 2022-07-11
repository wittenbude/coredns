FROM golang:alpine AS builder

ENV CGO_ENABLED=0
WORKDIR /work

RUN apk update && apk add ca-certificates && update-ca-certificates

COPY go.mod go.sum ./
RUN go mod download -x

COPY cmd ./cmd
RUN go build -v ./cmd/coredns


FROM scratch

COPY --from=builder /etc/ssl/certs /etc/ssl/certs
COPY --from=builder /work/coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
