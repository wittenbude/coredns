ARG TARGETPLATFORM
FROM --platform=${TARGETPLATFORM:-linux/amd64} gcr.io/distroless/static

COPY ./build/coredns /coredns
USER nonroot:nonroot

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
