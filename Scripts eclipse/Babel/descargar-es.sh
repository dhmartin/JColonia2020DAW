#!/bin/bash

URL0="https://build.eclipse.org/technology/babel/babel_language_packs"
URL1="${URL0}/?C=M;O=D"
VERSION_ECLIPSE="2021-03"

rm -f BabelLanguagePack*.zip


FECHA=$(lynx -dump "${URL1}" |
	grep -E -m 1 "^ \[\DIR].*[NI][[:digit:]]{8}-[[:digit:]]{4}" |
	sed -E 's/.*([NI][[:digit:]]{8}-[[:digit:]]{4}).*/\1/')


lynx -dump "${URL0}/${FECHA}/${VERSION_ECLIPSE}/" |
	grep -E 'https://.+BabelLanguagePack.+-(es|en_AA)_[^\s]+\.zip$' |
	sed -E 's/.+ (https:\/\/[^/s]+)/\1/' |
	grep -E '(datatools-es|eclipse-es|git-es|mylyn-es|rap-es|webtools-es)_' |
	xargs wget -c

ls -la BabelLanguagePack*.zip | wc -l


