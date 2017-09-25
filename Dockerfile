FROM alpine:3.6

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

WORKDIR /

COPY ./scripts/* /
