@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de ECLIPSE 2020-03
ECHO ==============================
ECHO.

SET SRCDIR=%~dp0
SET ICONDEST=%PUBLIC%\Desktop
SET JAVADEST=C:\java

ECHO Descomprimiendo «eclipse» en %ProgramFiles%:
"%SRCDIR%\unzip" -qnd "%ProgramFiles%" "%SRCDIR%\eclipse-java-2020-03-R-win32-x86_64.zip"
ECHO.

ECHO Descomprimiendo «openJDK» en %JAVADEST%:
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\OpenJDK11U-jdk_x64_windows_openj9_11.0.7_10_openj9-0.20.0.zip"
MOVE "%JAVADEST%\jdk-11*" "%JAVADEST%\jdk11"
ECHO.

ECHO Descomprimiendo «doxygen» y «graphviz» en %JAVADEST%:
MKDIR "%JAVADEST%\doxygen"
"%SRCDIR%\unzip" -qnd "%JAVADEST%\doxygen" "%SRCDIR%\doxygen-1.8.18.windows.x64.bin.zip"
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\graphviz-2.38.zip"

MOVE "%JAVADEST%\release\bin" "%JAVADEST%\graphviz"
RMDIR /S /Q "%JAVADEST%\release"
ECHO.

IF EXIST %ICONDEST% (
	ECHO Copiando accesos directos en %ICONDEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK11.lnk" "%ICONDEST%"
	ECHO Copiando scripts en %JAVADEST%:
	COPY /Y "%SRCDIR%\ijavaW10.cmd" "%JAVADEST%"
	ECHO.
)

SET SRCDIR=
SET ICONDEST=
SET JAVADEST=

PAUSE
