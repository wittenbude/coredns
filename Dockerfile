ARG TARGETPLATFORM
FROM --platform=${TARGETPLATFORM:-linux/amd64} gcr.io/distroless/static

COPY ./build/coredns /coredns
USER 53:53

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
