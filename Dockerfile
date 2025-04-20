FROM gcr.io/distroless/static

ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY --chmod=755 build/${TARGETOS}/${TARGETARCH}/coredns /coredns
USER nonroot:nonroot

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
