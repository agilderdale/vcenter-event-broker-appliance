FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8
ENV GOVERSION 1.13.4
ENV GOROOT /opt/go
ENV GOPATH /root/.go
ENV OVFTOOL_FILENAME=VMware-ovftool-4.3.0-14746126-lin.x86_64.bundle
ENV PACKER_DEV=1


ADD $OVFTOOL_FILENAME /tmp/

WORKDIR /root

RUN apt-get update
RUN apt-get install -y git bash openssl
RUN apt-get install -y curl wget 
RUN apt-get install -y docker.io

RUN /bin/sh /tmp/$OVFTOOL_FILENAME --console --required --eulas-agreed \
    && rm -f /tmp/$OVFTOOL_FILENAME \
    && ovftool -v

RUN curl -sSL https://cli.openfaas.com | sh

RUN cd /opt && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz && \
    tar zxf go${GOVERSION}.linux-amd64.tar.gz && rm go${GOVERSION}.linux-amd64.tar.gz && \
    ln -s /opt/go/bin/go /usr/bin/ && \
    mkdir $GOPATH

ENV PATH /opt/go/bin:/usr/bin:${PATH}

RUN go get github.com/mitchellh/gox
RUN go get github.com/hashicorp/packer


WORKDIR $GOPATH/src/github.com/hashicorp/packer

RUN /bin/bash scripts/build.sh

ENTRYPOINT ["ovftool"]

ENTRYPOINT ["bin/packer"]