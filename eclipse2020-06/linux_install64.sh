#!/bin/bash

DEST="/opt"
PROFILE="eclipse.sh"
PROFILEDIR="/etc/profile.d"
MENUFILE="/usr/share/applications/eclipse.desktop"

LISTA="
	eclipse-java-2020-06-R-linux-gtk-x86_64.tar.gz
	"

USUARIO="$(id -u)"
PROG="$(basename $0)"


if [[ "$USUARIO" -eq 0 ]] ; then
	for file in $LISTA; do
		if [[ $? -eq 0 ]]; then
			echo "Descomprimiendo $file en $DEST"
			if [[ "${file##*.}" == 'zip' ]]; then
				unzip -nd "$DEST" "$file" > /dev/null
			elif [[ "${file##*.}" == 'gz' ]]; then
				tar xzf "$file" -C "$DEST" > /dev/null
			fi
		else
			break;
		fi
	done

	chown -R root:root "$DEST"
	chmod -R go+r-w "$DEST"

	echo -e "Verifique que el JRE empleado por Eclipse es" &&
	echo -e "el JDK deseado. Edítelo y apunte URL Javadoc" &&
	echo -e "a una réplica de:" &&
	echo -e "   https://docs.oracle.com/javase/8/docs/api/\n"

	if [ $? -eq 0 -a -d "$PROFILEDIR" ]; then
		if [[ ! -f "$PROFILEDIR/$PROFILE" ]] ||
			! cmp "./$PROFILE" "$PROFILEDIR/$PROFILE"; then
				cp -af "./$PROFILE" "$PROFILEDIR/$PROFILE"
				chmod -x "$PROFILEDIR/$PROFILE"
				echo "Copiado $PROFILE en $PROFILEDIR/$PROFILE"
		fi
	fi

	cat <<- EOF > "$MENUFILE"
		[Desktop Entry]
		Comment=
		Exec=/opt/eclipse/eclipse -data $HOME/eclipse
		GenericName=Entorno de desarrollo Java
		Icon=/opt/eclipse/icon.xpm
		Categories=Development;
		Name=Eclipse
		NoDisplay=false
		Path[$e]=
		StartupNotify=true
		Terminal=0
		TerminalOptions=
		Type=Application
		X-KDE-SubstituteUID=false
		X-KDE-Username=
	EOF
	chmod a+r "$MENUFILE"

else
	echo "$PROG: Probablemente no dispone de permisos suficientes"
fi

exit 0