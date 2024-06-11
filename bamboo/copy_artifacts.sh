#!/bin/bash

PACKAGE_NAME="pib-repo"
PACKAGE_VERSION="1.${bamboo.buildNumber}"
ARTIFACTS_DIR="artifacts"

if [ ! -d "$ARTIFACTS_DIR" ]; then
        mkdir $ARTIFACTS_DIR
fi

rm -Rf $ARTIFACTS_DIR/*

mkdir "$ARTIFACTS_DIR/${bamboo.buildNumber}"

mv *.deb "${ARTIFACTS_DIR}/${bamboo.buildNumber}"
