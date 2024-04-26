@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de Babel para ECLIPSE
ECHO =================================
ECHO.

SET SRCDIR=%~dp0
SET PROGRAMDEST=C:\java

IF NOT DEFINED PROGRAMDEST SET PROGRAMDEST=%ProgramFiles%

SET BABELDEST=%PROGRAMDEST%\eclipse\dropins

IF EXIST "%BABELDEST%" (
	FOR /d %%D in ("%BABELDEST%\Babel*") DO RMDIR /S /Q "%%D"
	
	FOR %%F IN ("%SRCDIR%Babel\*.zip") DO (
		ECHO Descomprimiendo %%~nxF…
		MKDIR "%BABELDEST%\%%~nF"
		"%SRCDIR%\7za" x -bso0 -bd -o"%BABELDEST%\%%~nF" "%%~fF"
	)
)

SET SRCDIR=
SET BABELDEST=

PAUSE
