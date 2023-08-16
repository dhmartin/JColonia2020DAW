#!/bin/bash

# Limpieza del archivo eclipse PDT (PHP + IDE) para
# integrarlo en «dropins» de una configuración PDT.
# Elimina archivos comunes.


PROG=$(basename $0)
ECLIPSE0=/opt/eclipse
if [[ ! -d "$ECLIPSE0" ]]; then
    echo "$PROG: Se requiere «Eclipse for Java Developers» en $ECLIPSE0" >&2
    exit 1
fi


DESCARGABLE=https://eclipse.mirror.garr.it/technology/epp/downloads/release/2023-03/R/eclipse-php-2023-03-R-linux-gtk-x86_64.tar.gz
ARCHIVO=${DESCARGABLE##*/}

# ARCHIVO=$(echo eclipse-php*.tar.gz)
NOMBRE=${ARCHIVO%.tar.gz}
NOMBRE=pdt${NOMBRE#eclipse-php}
DESTINO=${NOMBRE}.tar.bz2
ARCHIVO_LOG=${NOMBRE}.log

if [[ ! -f  "${ARCHIVO}" ]]; then
	echo "Descargando «${ARCHIVO}»…"
	wget -c "${DESCARGABLE}"
fi

exec &> >(tee $ARCHIVO_LOG)

# Descomprimir todo
if [[ -d $NOMBRE ]]; then
	rm -rf $NOMBRE
fi

mkdir $NOMBRE
tar xf $ARCHIVO -C $NOMBRE


# Dejar solo «features» y «plugins»
find $NOMBRE \
	-mindepth 2 -maxdepth 2 \
	-not \( -name features -or -name plugins \) \
	-print0 |
	xargs -0 rm -rf


# Buscar archivos comunes con JDT
# «eclipse for Java Developers» tiene que estar en /opt/eclipse
N=0
for file in $(find $NOMBRE -mindepth 3 -maxdepth 3); do
	source=${file#*/}
	target=/opt/$source

	if [[ -e $target ]]; then
		rm -rf $NOMBRE/$source
		# echo Borrando $NOMBRE/$source
		(( N++ ))
	fi
done
echo "$N elementos comunes a JDT eliminados"


# Empaquetar y comprimir
echo "Comprimiendo en «$DESTINO»…"
if [[ -f $DESTINO ]]; then
	rm -f $DESTINO
fi

tar cjf $DESTINO $NOMBRE
