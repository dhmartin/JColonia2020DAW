#!/bin/bash

DEST="/opt"

USUARIO="$(id -u)"
PROG="$(basename $0)"


if [[ "$USUARIO" -eq 0 ]] ; then
	rm -rf ${DEST}/eclipse/dropins/Babel*

	for file in Babel/*.zip ; do
		if [[ $? -eq 0 ]]; then
			DEST2="$(basename ${file} .zip)"
			DEST1="${DEST}/eclipse/dropins/${DEST2}"
			mkdir "$DEST1"

			echo "Descomprimiendo $file en $DEST1"
			unzip -nd "$DEST1" "$file" > /dev/null
		else
			break;
		fi
	done

	rm  -f "${DEST}/eclipse/dropins/WindowBuilder/eclipse"/*

	chown -R root:root "$DEST1"
	chmod -R go+r-w "$DEST1"
else
	echo "$PROG: Probablemente no dispone de permisos suficientes"
fi

exit 0
