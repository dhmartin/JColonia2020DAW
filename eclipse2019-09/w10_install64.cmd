@mode con cp select=65001 > NUL
@ECHO off

ECHO Instalación de ECLIPSE 2019-06
ECHO ==============================
ECHO.

SET SRCDIR=%~dp0
SET ICONDEST=%PUBLIC%\Desktop
SET JAVADEST=C:\java

ECHO Descomprimiendo «eclipse» en %ProgramFiles%:
"%SRCDIR%/unzip" -qnd "%ProgramFiles%" "%SRCDIR%/BabelLanguagePack-eclipse-es_4.12.0.v20190713060001.zip"
"%SRCDIR%/unzip" -qnd "%ProgramFiles%" "%SRCDIR%/eclipse-java-2019-06-R-win32-x86_64.zip"
ECHO.

ECHO Descomprimiendo «openJDK» en %JAVADEST%:
"%SRCDIR%/unzip" -qnd "%JAVADEST%" "%SRCDIR%/OpenJDK11U-jdk_x64_windows_openj9_11.0.4_11_openj9-0.15.1.zip"
MOVE "%JAVADEST%/jdk-11.0.4+11" "%JAVADEST%/jdk11"
ECHO.

IF EXIST %ICONDEST% (
	ECHO Copiando accesos directos en %ICONDEST%:
	COPY /Y "%SRCDIR%/eclipse.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%/Entorno JDK11.lnk" "%ICONDEST%"
	ECHO Copiando scripts en %JAVADEST%:
	COPY /Y "%SRCDIR%/ijavaW10.cmd" "%JAVADEST%"
	ECHO.
)

SET SRCDIR=
SET ICONDEST=
SET JAVADEST=

PAUSE