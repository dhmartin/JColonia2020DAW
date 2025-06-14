#!/bin/bash

# Descarga en bloque de binarios de eclipse
# de un repositorio cercano


PROG=$(basename $0)

ECLIPSE_VERSION=2025-06
REPO=https://eclipse.mirror.garr.it/technology/epp/downloads/release/${ECLIPSE_VERSION}/R/

ARCHIVOS="
    eclipse-java-${ECLIPSE_VERSION}-R-linux-gtk-x86_64.tar.gz
    eclipse-java-${ECLIPSE_VERSION}-R-win32-x86_64.zip
    eclipse-jee-${ECLIPSE_VERSION}-R-linux-gtk-x86_64.tar.gz
    eclipse-jee-${ECLIPSE_VERSION}-R-win32-x86_64.zip
"

for file in ${ARCHIVOS}; do
    echo "$REPO$file"
    echo "$REPO$file.sha1"
done | xargs wget -c
