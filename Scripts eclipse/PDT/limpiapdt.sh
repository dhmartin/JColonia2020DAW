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


DESCARGABLE=https://eclipse.mirror.garr.it/technology/epp/downloads/release/2026-06/R/eclipse-php-2026-06-R-linux-gtk-x86_64.tar.gz
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
[[ -d $NOMBRE ]] && rm -rf $NOMBRE
[[ -d eclipse ]] && rm -rf eclipse
tar xf $ARCHIVO \
	--warning=no-unknown-keyword > /dev/null


# Dejar solo «features» y «plugins»
find eclipse \
	-mindepth 1 -maxdepth 1 \
	-not \( -name features -or -name plugins \) \
	-print0 |
	xargs -0 rm -rf


# Buscar archivos comunes con JDT
# «eclipse for Java Developers» tiene que estar en /opt/eclipse
N=0
for file in $(find eclipse -mindepth 2 -maxdepth 2); do
	source=${file#*/}
	target=/opt/eclipse/$source

	if [[ -e $target ]]; then
		rm -rf eclipse/$source
		# echo Borrando eclipse/$source
		(( N++ ))
	fi
done
echo "$N elementos comunes a JDT eliminados"
mv eclipse $NOMBRE


# Empaquetar y comprimir
echo "Comprimiendo en «$DESTINO»…"
[[ -f $DESTINO ]] && rm -f $DESTINO

tar cjf $DESTINO $NOMBRE
