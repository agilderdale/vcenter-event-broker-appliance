FROM ubuntu:xenial

ENV OVFTOOL_FILENAME=VMware-ovftool-4.3.0-14746126-lin.x86_64.bundle

ADD $OVFTOOL_FILENAME /tmp/

WORKDIR /root

RUN /bin/sh /tmp/$OVFTOOL_FILENAME --console --required --eulas-agreed \
    && rm -f /tmp/$OVFTOOL_FILENAME \
    && ovftool -v

RUN apt-get update
RUN apt-get install -y curl wget 
RUN curl -sSL https://cli.openfaas.com | sh
RUN apt-get install -y docker.io

ENTRYPOINT ["ovftool"]

