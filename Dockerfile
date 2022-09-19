FROM alpine:3.16 as builder

ARG TEE_VERSION=v2.8.0

RUN mkdir -p /download/

WORKDIR /download

RUN wget https://s3.amazonaws.com/traefikee/binaries/${TEE_VERSION}/teectl_${TEE_VERSION}_linux_amd64.tar.gz && \
    tar xzvf teectl_${TEE_VERSION}_linux_amd64.tar.gz

FROM bitnami/kubectl:latest

ARG TEE_VERSION=v2.8.0

LABEL maintainer="deas"

COPY --from=builder /download/teectl .

ADD ./entrypoint.sh /

ENTRYPOINT ["./entrypoint.sh"]