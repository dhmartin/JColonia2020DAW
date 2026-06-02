#!/bin/bash

DEST="/opt"

USUARIO="$(id -u)"
PROG="$(basename $0)"

# function unzip_dest() { unzip -nd $1 $2; }
function unzip_dest() { 7za x -bso0 -bd -o$1 $2; }


if [[ "$USUARIO" -eq 0 ]] ; then
	rm -rf ${DEST}/eclipse/dropins/Babel*

	# Comprobar si hay algún ZIP
	for file in $(echo Babel/*.zip | grep -v [*]); do
		DEST2="$(basename ${file} .zip)"
		DEST1="${DEST}/eclipse/dropins"

		echo "Descomprimiendo $file en $DEST1"
		unzip_dest "$DEST1" "$file" > /dev/null
		mv "${DEST1}/eclipse" "${DEST1}/${DEST2}"

		chown -R root:root "${DEST1}/${DEST2}"
		chmod -R go+r-w "${DEST1}/${DEST2}"
	done
else
	echo "$PROG: Probablemente no dispone de permisos suficientes"
	exit 1
fi

exit 0
