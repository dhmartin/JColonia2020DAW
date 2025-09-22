#!/bin/bash

# Descarga en bloque de binarios de eclipse
# de un repositorio cercano


PROG=$(basename $0)

ECLIPSE_VERSION=2025-09
ECLIPSE_RELEASE=R
REPO=https://eclipse.mirror.garr.it/technology/epp/downloads/release/${ECLIPSE_VERSION}/${ECLIPSE_RELEASE}/

ARCHIVOS="
	eclipse-java-${ECLIPSE_VERSION}-${ECLIPSE_RELEASE}-linux-gtk-x86_64.tar.gz
	eclipse-java-${ECLIPSE_VERSION}-${ECLIPSE_RELEASE}-win32-x86_64.zip
	eclipse-jee-${ECLIPSE_VERSION}-${ECLIPSE_RELEASE}-linux-gtk-x86_64.tar.gz
	eclipse-jee-${ECLIPSE_VERSION}-${ECLIPSE_RELEASE}-win32-x86_64.zip
"

for file in ${ARCHIVOS}; do
    echo "$REPO$file"
    echo "$REPO$file.sha1"
done | xargs wget -c


ARCHIVOS="
	limpiapdt.sh
	linux_install64.sh
	w10_install64.cmd
	w10_install64-jee.cmd
	w10_install64-user.cmd
	w10_install64-user-jee.cmd
"

for file in ${ARCHIVOS}; do
    echo "$file"
done | xargs sed -i \
	-e "s/[[:digit:]]\{4\}-[[:digit:]]\{2\}\(-\|\/\)\(R\|RC1\|RC2\|M1\|M2\)/${ECLIPSE_VERSION}\1${ECLIPSE_RELEASE}/g" \
	-e "s/[[:digit:]]\{4\}-[[:digit:]]\{2\}\([^-]\)/${ECLIPSE_VERSION}\1/g"

mkdirhier PDT
ln -f limpiapdt.sh PDT
