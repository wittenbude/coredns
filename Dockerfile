FROM gcr.io/distroless/static

COPY ./build/coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
