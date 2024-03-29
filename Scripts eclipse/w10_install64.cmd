@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de ECLIPSE 2023-12
ECHO ==============================
ECHO.

SET SRCDIR=%~dp0
SET ICONDEST=%PUBLIC%\Desktop
SET JAVADEST=C:\java
SET PROGRAMDEST=C:\java

IF NOT DEFINED PROGRAMDEST SET PROGRAMDEST=%ProgramFiles%

ECHO Descomprimiendo «eclipse» en %PROGRAMDEST%:
"%SRCDIR%\unzip" -qnd "%PROGRAMDEST%" "%SRCDIR%\eclipse-java-2023-12-R-win32-x86_64.zip"
ECHO.

ECHO Descomprimiendo «openJDK17» en %JAVADEST%:
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\OpenJDK17U-jdk_x64_windows_hotspot_17.0.10_7.zip"
MOVE "%JAVADEST%\jdk-17*" "%JAVADEST%\jdk17"
ECHO.

ECHO Descomprimiendo «openJDK21» en %JAVADEST%:
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\OpenJDK21U-jdk_x64_windows_hotspot_21.0.2_13.zip"
MOVE "%JAVADEST%\jdk-21*" "%JAVADEST%\jdk21"
ECHO.

ECHO Descomprimiendo «doxygen» y «graphviz» en %JAVADEST%:
MKDIR "%JAVADEST%\doxygen"
"%SRCDIR%\unzip" -qnd "%JAVADEST%\doxygen" "%SRCDIR%\doxygen-1.10.0.windows.x64.bin.zip"
"%SRCDIR%\unzip" -qnd "%JAVADEST%" "%SRCDIR%\windows_10_msbuild_Release_graphviz-9.0.0-win32.zip"

MOVE "%JAVADEST%\Graphviz" "%JAVADEST%\graphviz.0"
MOVE "%JAVADEST%\graphviz.0\bin" "%JAVADEST%\graphviz"
RMDIR /S /Q "%JAVADEST%\graphviz.0"
ECHO.

IF EXIST %ICONDEST% (
	ECHO Copiando accesos directos a %ICONDEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK17.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK21.lnk" "%ICONDEST%"
	ECHO Copiando scripts y accesos directos a %JAVADEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\Entorno JDK17.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\Entorno JDK21.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ijava17W10.cmd" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ijava21W10.cmd" "%JAVADEST%"
	ECHO.
)

SET SRCDIR=
SET ICONDEST=
SET JAVADEST=

PAUSE
