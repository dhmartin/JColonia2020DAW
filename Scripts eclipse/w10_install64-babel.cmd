@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de Babel para ECLIPSE
ECHO =================================
ECHO.

SET SRCDIR=%~dp0
SET BABELDEST=%ProgramFiles%\eclipse\dropins

IF EXIST "%BABELDEST%" (
	FOR /d %%D in ("%BABELDEST%\Babel*") DO RMDIR /S /Q "%%D"
	
	FOR %%F IN ("%SRCDIR%Babel\*.zip") DO (
		ECHO Descomprimiendo %%~nxF…
		MKDIR "%BABELDEST%\%%~nF"
		"%SRCDIR%\unzip" -qnd "%BABELDEST%\%%~nF" "%%~fF"
	)
)

SET SRCDIR=
SET BABELDEST=

PAUSE
