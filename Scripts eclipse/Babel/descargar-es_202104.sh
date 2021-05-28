#!/bin/bash

URL0="https://download.eclipse.org/technology/babel/babel_language_packs/"
VERSION_ECLIPSE="2021-03"

rm -f BabelLanguagePack*.zip


FECHA=$(lynx -dump "${URL0}" |
	grep -E "\[[[:digit:]]+\][I][[:digit:]]{8}-[[:digit:]]{4}$" |
	sort -t "]" -k3.2 |
	tail -1 |
	sed -E 's/.*([I][[:digit:]]{8}-[[:digit:]]{4}).*/\1/')


lynx -dump "${URL0}/${FECHA}/${VERSION_ECLIPSE}/${VERSION_ECLIPSE}.php" |
	grep -E 'https://.+BabelLanguagePack.+-(es|en_AA)_[^\s]+\.zip$' |
	sed -E 's/.+ (https:\/\/[^/s]+)/\1/' |
	grep -E '(cdt-es|datatools-es|eclipse-es|git-es|mylyn-es|rap-es|webtools-es)_' |
	xargs wget -c

ls -la BabelLanguagePack*.zip | wc -l
