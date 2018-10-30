#!/bin/bash

echo "Installing the latest version of Istio"

OUTPUT="$(curl -L https://git.io/getLatestIstio | sh -)"
ISTIO_VERSION="$(echo $OUTPUT | cut -d ' ' -f 2)"
VER="$(echo $ISTIO_VERSION | cut -d '-' -f 2)"
echo "Istio is installed into directory: istio-$VER"

EX_PATH=$(echo $OUTPUT|awk -F= '/PATH/ { getline; print $2 }')
echo "Please add the following path to your PATH variable: $EX_PATH"

