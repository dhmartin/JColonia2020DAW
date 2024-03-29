#!/bin/bash

URL0="https://download.eclipse.org/technology/babel/babel_language_packs/"
VERSION_ECLIPSE="2022-12"

rm -f BabelLanguagePack*.zip


FECHA=$(lynx -dump "${URL0}" |
	grep -E "https://.+/[IN][[:digit:]]{8}-[[:digit:]]{4}$" |
	sed -E 's/.*([IN][[:digit:]]{8}-[[:digit:]]{4}).*/\1/' |
	sort -k1.2 |
	tail -1)


lynx -dump "${URL0}/${FECHA}/${VERSION_ECLIPSE}/${VERSION_ECLIPSE}.php" |
	grep -E 'https://.+BabelLanguagePack.+-(es|en_AA)_[^\s]+\.zip$' |
	sed -E 's/.+ (https:\/\/[^/s]+)/\1/' |
	grep -E '(eclipse-es|cdt-es|datatools-es|git-es|lsp4e-es|mpc-es|tm4e-es|mylyn-es|rap-es|webtools-es)_' |
	xargs wget -c

ls -la BabelLanguagePack*.zip | wc -l
