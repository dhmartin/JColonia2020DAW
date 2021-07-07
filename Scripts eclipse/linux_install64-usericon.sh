#!/bin/bash

MENUFILE="/usr/share/applications/eclipse.desktop"

USUARIO="$(id -u)"
PROG="$(basename $0)"


if [[ "$USUARIO" -ne 0 ]] ; then
	if [[ -r  "${MENUFILE}" ]] ; then
		test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
		echo "Copiando «$MENUFILE» a «${XDG_DESKTOP_DIR:-$HOME/Desktop}»"
		cp "${MENUFILE}" "${XDG_DESKTOP_DIR:-$HOME/Desktop}"
		chmod +x "${XDG_DESKTOP_DIR:-$HOME/Desktop}/$(basename ${MENUFILE})"
	else
		echo "$PROG: No se encuentra «$MENUFILE». ¿Ha completado antes la instalación de Eclipse?"
	fi
else
	echo "$PROG: Probablemente desee hacer esto con su propio usuario, sin privilegios..."
fi

exit 0
