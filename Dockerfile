FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /
COPY . .
ARG os
RUN make $os

FROM scratch
WORKDIR /
COPY --from=builder / .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot"]
