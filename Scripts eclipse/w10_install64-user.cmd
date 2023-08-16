@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de ECLIPSE 2023-03
ECHO ==============================
ECHO.

SET SRCDIR=%~dp0
SET ICONDEST=%USERPROFILE%\Desktop
SET JAVADEST=C:\java
SET PROGRAMDEST=C:\java

IF NOT DEFINED PROGRAMDEST SET PROGRAMDEST=%ProgramFiles%

ECHO Descomprimiendo «eclipse» en %PROGRAMDEST%:
"%SRCDIR%\unzip" -qnd "%PROGRAMDEST%" "%SRCDIR%\eclipse-java-2023-03-R-win32-x86_64.zip"
ECHO.

ECHO Descomprimiendo «openJDK11» en %JAVADEST%:
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\OpenJDK11U-jdk_x64_windows_hotspot_11.0.20_8.zip"
MOVE "%JAVADEST%\jdk-11*" "%JAVADEST%\jdk11"
ECHO.

ECHO Descomprimiendo «openJDK17» en %JAVADEST%:
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\OpenJDK17U-jdk_x64_windows_hotspot_17.0.8_7.zip"
MOVE "%JAVADEST%\jdk-17*" "%JAVADEST%\jdk17"
ECHO.

ECHO Descomprimiendo «doxygen» y «graphviz» en %JAVADEST%:
MKDIR "%JAVADEST%\doxygen"
"%SRCDIR%\unzip" -qnd "%JAVADEST%\doxygen" "%SRCDIR%\doxygen-1.9.7.windows.x64.bin.zip"
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\windows_10_msbuild_Release_graphviz-8.1.0-win32.zip"

MOVE "%JAVADEST%\Graphviz" "%JAVADEST%\graphviz.0"
MOVE "%JAVADEST%\graphviz.0\bin" "%JAVADEST%\graphviz"
RMDIR /S /Q "%JAVADEST%\graphviz.0"
ECHO.

IF EXIST %ICONDEST% (
	ECHO Copiando accesos directos a %ICONDEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK11.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK17.lnk" "%ICONDEST%"
	ECHO Copiando scripts y accesos directos a %JAVADEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\Entorno JDK11.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\Entorno JDK17.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ijava11W10.cmd" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ijava17W10.cmd" "%JAVADEST%"
	ECHO.
)

SET SRCDIR=
SET ICONDEST=
SET JAVADEST=

PAUSE
