#!/bin/bash

DEST="/opt"

USUARIO="$(id -u)"
PROG="$(basename $0)"


DEST1="${DEST}/eclipse/dropins/WindowBuilder"
DEST2="${DEST1}/eclipse"
DEST3="${DEST2}/plugins"


if [[ "$USUARIO" -eq 0 ]] ; then
        rm -rf ${DEST}/eclipse/dropins/WindowBuilder

        # Comprobar si hay ZIP y ¡solo uno!
        for file in $(echo WindowBuilder/*.zip | grep -v [*[:space:]]); do
                mkdir "$DEST1"
                mkdir "$DEST2"

                echo "Descomprimiendo $file en $DEST2"
                unzip -nd "$DEST2" "$file" > /dev/null

                if [[ $? -eq 0 ]]; then
                        for jarfile in $(echo WindowBuilder/*.jar | grep -v [*]); do
                                echo "Copiando $jarfile en $DEST3"
                                cp -a "$jarfile" "$DEST3" > /dev/null
                        done
                fi
        done

        rm  -f "${DEST}/eclipse/dropins/WindowBuilder/eclipse"/*

        chown -R root:root "$DEST1"
        chmod -R go+r-w "$DEST1"
else
        echo "$PROG: Probablemente no dispone de permisos suficientes"
        exit 1
fi

exit 0
