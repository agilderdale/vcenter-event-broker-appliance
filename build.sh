#!/bin/bash -x
# Copyright 2019 VMware, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-2

echo "Building OVA ..."
rm -f output-vmware-iso/*.ova

if [[ "$1" -gt "-1" ]] && [[ $1 == "dev" ]]; then
    echo "Applying packer build to photon-dev.json ..."
#    packer build -var-file=photon-builder.json -var-file=photon-version.json photon-dev.json
    docker run -i -t -v ${PWD}:/tmp/config licja/ovftool-packer-openfaas:0.3 build -var-file=/tmp/config/photon-builder.json -var-file=/tmp/config/photon-version.json /tmp/config/photon-dev.json
else
    echo "Applying packer build to photon.json ..."
#    packer build -var-file=photon-builder.json -var-file=photon-version.json photon.json
    docker run -i -t -v ${PWD}:/tmp/config licja/ovftool-packer-openfaas:0.3 build -var-file=/tmp/config/photon-builder.json -var-file=/tmp/config/photon-version.json /tmp/config/photon.json
fi
