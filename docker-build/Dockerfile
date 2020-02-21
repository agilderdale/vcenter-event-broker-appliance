# FROM ubuntu:xenial
FROM golang:alpine

ENV OVFTOOL_FILENAME=VMware-ovftool-4.3.0-14746126-lin.x86_64.bundle
ENV PACKER_DEV=1

ADD $OVFTOOL_FILENAME /tmp/

WORKDIR /root

RUN apt-get update
RUN apt-get install -y git bash openssl
RUN apt-get install -y curl wget 

RUN /bin/sh /tmp/$OVFTOOL_FILENAME --console --required --eulas-agreed \
    && rm -f /tmp/$OVFTOOL_FILENAME \
    && ovftool -v

RUN curl -sSL https://cli.openfaas.com | sh
RUN apt-get install -y docker.io

RUN go get github.com/mitchellh/gox
RUN go get github.com/hashicorp/packer

WORKDIR $GOPATH/src/github.com/hashicorp/packer

RUN /bin/bash scripts/build.sh

WORKDIR $GOPATH

ENTRYPOINT ["ovftool"]

ENTRYPOINT ["bin/packer"]