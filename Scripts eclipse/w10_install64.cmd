@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de ECLIPSE 2021-12
ECHO ==============================
ECHO.

SET SRCDIR=%~dp0
SET ICONDEST=%PUBLIC%\Desktop
SET JAVADEST=C:\java
SET PROGRAMDEST=

IF NOT DEFINED PROGRAMDEST SET PROGRAMDEST=%ProgramFiles%

ECHO Descomprimiendo «eclipse» en %PROGRAMDEST%:
"%SRCDIR%\unzip" -qnd "%PROGRAMDEST%" "%SRCDIR%\eclipse-java-2021-12-R-win32-x86_64.zip"
ECHO.

ECHO Descomprimiendo «openJDK11» en %JAVADEST%:
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\ibm-semeru-open-jdk_x64_windows_11.0.13_8_openj9-0.29.0.zip"
MOVE "%JAVADEST%\jdk-11*" "%JAVADEST%\jdk11"
ECHO.

ECHO Descomprimiendo «openJDK17» en %JAVADEST%:
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\openjdk-17.0.1_windows-x64_bin.zip"
MOVE "%JAVADEST%\jdk-17*" "%JAVADEST%\jdk17"
ECHO.

ECHO Descomprimiendo «doxygen» y «graphviz» en %JAVADEST%:
MKDIR "%JAVADEST%\doxygen"
"%SRCDIR%\unzip" -qnd "%JAVADEST%\doxygen" "%SRCDIR%\doxygen-1.9.3.windows.x64.bin.zip"
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\stable_windows_10_msbuild_Release_Win32_graphviz-2.49.0-win32.zip"

MOVE "%JAVADEST%\Graphviz" "%JAVADEST%\graphviz.0"
MOVE "%JAVADEST%\graphviz.0\bin" "%JAVADEST%\graphviz"
RMDIR /S /Q "%JAVADEST%\graphviz.0"
ECHO.

IF EXIST %ICONDEST% (
	ECHO Copiando accesos directos en %ICONDEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK11.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK17.lnk" "%ICONDEST%"
	ECHO Copiando scripts en %JAVADEST%:
	COPY /Y "%SRCDIR%\ijava11W10.cmd" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ijava17W10.cmd" "%JAVADEST%"
	ECHO.
)

SET SRCDIR=
SET ICONDEST=
SET JAVADEST=

PAUSE
