#!/bin/bash

# ¿Visor «SWT» para Javadoc?
# sudo apt install libswt-webkit-gtk-4-jni


DEST="/opt"
PROFILE="eclipse.sh"
PROFILEDIR="/etc/profile.d"
MENUFILE="/usr/share/applications/eclipse.desktop"

LISTA="
	eclipse-jee-2025-09-R-linux-gtk-x86_64.tar.gz
	"

USUARIO="$(id -u)"
PROG="$(basename $0)"

# function unzip_dest() { unzip -nd $1 $2; }
function unzip_dest() { 7za x -bso0 -bd -o$1 $2; }


if [[ "$USUARIO" -eq 0 ]] ; then
	for file in $LISTA; do
		if [[ $? -eq 0 ]]; then
			echo "Descomprimiendo $file en $DEST"
			if [[ "${file##*.}" == 'zip' ]]; then
				unzip_dest "$DEST" "$file" > /dev/null
			elif [[ "${file##*.}" == 'gz' ]]; then
				tar xzf "$file" -C "$DEST" \
					--warning=no-unknown-keyword > /dev/null
				[[ $? -eq 0 ]] && echo -e "\t→ Descompresión completa"
			fi
		else
			break;
		fi
	done

	chown -R root:root "$DEST/eclipse"
	chmod -R go+r-w "$DEST/eclipse"

	echo -e "\nVerifique que el JRE empleado por Eclipse es" &&
	echo -e "el JDK deseado. Edítelo y apunte URL Javadoc" &&
	echo -e "a una réplica de:" &&
	echo -e "\thttps://docs.oracle.com/en/java/javase/21/docs/api/\n"

	if [ $? -eq 0 -a -d "$PROFILEDIR" ]; then
		if [[ ! -f "$PROFILEDIR/$PROFILE" ]] ||
			! cmp "./$PROFILE" "$PROFILEDIR/$PROFILE"; then
				cp -af "./$PROFILE" "$PROFILEDIR/$PROFILE"
				chmod -x "$PROFILEDIR/$PROFILE"
				echo "Copiado $PROFILE en $PROFILEDIR/$PROFILE"
		fi
	fi

	cat <<- 'EOF' > "$MENUFILE"
		[Desktop Entry]
		Comment=
		Exec=/opt/eclipse/eclipse -data $HOME/eclipse -vm /usr/bin/java
		GenericName=Entorno de desarrollo Java
		Icon=/opt/eclipse/icon.xpm
		Categories=Development;
		Name=Eclipse
		NoDisplay=false
		StartupNotify=true
		Terminal=false
		Type=Application
	EOF
	chmod a+r "$MENUFILE"

else
	echo "$PROG: Probablemente no dispone de permisos suficientes"
fi

exit 0
