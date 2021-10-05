@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de WindowBuilder para ECLIPSE
ECHO =========================================
ECHO.

SET SRCDIR=%~dp0
SET PROGRAMDEST=

IF NOT DEFINED PROGRAMDEST SET PROGRAMDEST=%ProgramFiles%

SET WBDEST=%PROGRAMDEST%\eclipse\dropins

IF EXIST "%WBDEST%" (
	IF EXIST "%WBDEST%\WindowBuilder" RMDIR /S /Q "%WBDEST%\WindowBuilder"
	
	FOR %%F IN ("%SRCDIR%WindowBuilder\repository.zip") DO (
		ECHO Descomprimiendo %%~nxF…
		MKDIR "%WBDEST%\%%~nF"
		MKDIR "%WBDEST%\%%~nF\eclipse"
		"%SRCDIR%unzip" -qnd "%WBDEST%\%%~nF\eclipse" "%%~fF"
		DEL /Q "%WBDEST%\%%~nF\eclipse\*.*"
		MOVE "%WBDEST%\%%~nF" "%WBDEST%\WindowBuilder"
	)
)

SET SRCDIR=
SET WBDEST=

PAUSE
