#!/bin/bash

PACKAGE_DIR="package"
BIN_DIR="bin"
BIN_DIR_SRC="BIN"
DEBIAN_DIR="DEBIAN"
ETC_DIR="etc"
REPO_DIR="opt/repo"
BIN_BASH_STR="#!/bin/bash"

PACKAGE_NAME="pib-repo"
PACKAGE_VERSION="1.${bamboo.buildNumber}"
PACKAGE_SECTION="unknown"
PACKAGE_PRIORITY="optional"
PACKAGE_ARCHITECTURE="all"
PACKAGE_MAINTAINER="pib.pro<piborisovich@gmail.com>"
PACKAGE_DESCRIPTION="Applications of PIB repo"

if [ ! -z "$(ls -A $BIN_DIR_SRC)" ]; then

    if [ ! -d "$PACKAGE_DIR" ]; then
        mkdir $PACKAGE_DIR
    fi

    if [ ! -z "$(ls -A $PACKAGE_DIR)" ]; then
	rm -Rf $PACKAGE_DIR/*
    fi

    mkdir -p "$PACKAGE_DIR/$REPO_DIR/$BIN_DIR"
    mkdir -p "$PACKAGE_DIR/$REPO_DIR/$ETC_DIR"
    mkdir "${PACKAGE_DIR}/${DEBIAN_DIR}"

    cp -v "$BIN_DIR_SRC"/* "$PACKAGE_DIR/$REPO_DIR/$BIN_DIR"

    #Create postinst file
    touch "${PACKAGE_DIR}/${DEBIAN_DIR}/postinst"

    echo  "$BIN_BASH_STR"         >> "${PACKAGE_DIR}/${DEBIAN_DIR}/postinst"
    echo  "echo 'Hello from PIB'" >> "${PACKAGE_DIR}/${DEBIAN_DIR}/postinst"

    #Create preinst file
    touch "${PACKAGE_DIR}/${DEBIAN_DIR}/preinst"
    echo  "$BIN_BASH_STR" >> "${PACKAGE_DIR}/${DEBIAN_DIR}/preinst"

    #Create postrm file
    touch "${PACKAGE_DIR}/${DEBIAN_DIR}/postrm"
    echo  "$BIN_BASH_STR" >> "${PACKAGE_DIR}/${DEBIAN_DIR}/postrm"

    #Create prerm file
    touch "${PACKAGE_DIR}/${DEBIAN_DIR}/prerm"
    echo  "$BIN_BASH_STR" >> "${PACKAGE_DIR}/${DEBIAN_DIR}/prerm"

    chmod 775 "${PACKAGE_DIR}/${DEBIAN_DIR}/postinst"
    chmod 775 "${PACKAGE_DIR}/${DEBIAN_DIR}/preinst"
    chmod 775 "${PACKAGE_DIR}/${DEBIAN_DIR}/postrm"
    chmod 775 "${PACKAGE_DIR}/${DEBIAN_DIR}/prerm"

    #Create manifest file
    touch "${PACKAGE_DIR}/${DEBIAN_DIR}/control"

    echo "Package: ${PACKAGE_NAME}"              >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Version: ${PACKAGE_VERSION}"           >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Section: ${PACKAGE_SECTION}"           >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Priority: ${PACKAGE_PRIORITY}"         >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Depends:"                              >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Architecture: ${PACKAGE_ARCHITECTURE}" >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Installed-Size:"                       >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Maintainer: ${PACKAGE_MAINTAINER}"     >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"
    echo "Description: ${PACKAGE_DESCRIPTION}"   >> "${PACKAGE_DIR}/${DEBIAN_DIR}/control"

    dpkg-deb --build "./${PACKAGE_DIR}" "${PACKAGE_NAME}-${PACKAGE_VERSION}.deb"
fi
