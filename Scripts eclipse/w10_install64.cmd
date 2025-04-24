@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de ECLIPSE 2025-03
ECHO ==============================
ECHO.

SET SRCDIR=%~dp0
SET ICONDEST=%PUBLIC%\Desktop
SET JAVADEST=C:\java
SET PROGRAMDEST=C:\java

REM SET UNZIP_DEST="%SRCDIR%\unzip" -nd
SET UNZIP_DEST="%SRCDIR%\7za" x -bso0 -bd -o


IF NOT DEFINED PROGRAMDEST SET PROGRAMDEST=%ProgramFiles%

ECHO Descomprimiendo «eclipse» en %PROGRAMDEST%:
%UNZIP_DEST%"%PROGRAMDEST%" "%SRCDIR%\eclipse-java-2025-03-R-win32-x86_64.zip"
ECHO.

ECHO Descomprimiendo «openJDK21» en %JAVADEST%:
%UNZIP_DEST%"%JAVADEST%" "%SRCDIR%\OpenJDK21U-jdk_x64_windows_hotspot_21.0.7_6.zip"
MOVE "%JAVADEST%\jdk-21*" "%JAVADEST%\jdk21"
ECHO.

ECHO Descomprimiendo «openJDK24» en %JAVADEST%:
%UNZIP_DEST%"%JAVADEST%" "%SRCDIR%\OpenJDK24U-jdk_x64_windows_hotspot_24.0.1_9.zip"
MOVE "%JAVADEST%\jdk-24*" "%JAVADEST%\jdk24"
ECHO.

ECHO Descomprimiendo «doxygen» y «graphviz» en %JAVADEST%:
MKDIR "%JAVADEST%\doxygen"
%UNZIP_DEST%"%JAVADEST%\doxygen" "%SRCDIR%\doxygen-1.13.2.windows.x64.bin.zip"
%UNZIP_DEST%"%JAVADEST%" "%SRCDIR%\windows_10_cmake_Release_Graphviz-12.2.1-win64.zip"

MOVE "%JAVADEST%\Graphviz*" "%JAVADEST%\graphviz.0"
MOVE "%JAVADEST%\graphviz.0\bin" "%JAVADEST%\graphviz"
RMDIR /S /Q "%JAVADEST%\graphviz.0"
ECHO.

IF EXIST %ICONDEST% (
	ECHO Copiando accesos directos a %ICONDEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK21.lnk" "%ICONDEST%"
	COPY /Y "%SRCDIR%\Entorno JDK24.lnk" "%ICONDEST%"
	ECHO Copiando scripts y accesos directos a %JAVADEST%:
	COPY /Y "%SRCDIR%\eclipse.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\Entorno JDK21.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\Entorno JDK24.lnk" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ijava21W10.cmd" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ijava24W10.cmd" "%JAVADEST%"
	COPY /Y "%SRCDIR%\ubicación.cmd" "%JAVADEST%"
	ECHO.
)

SET SRCDIR=
SET ICONDEST=
SET JAVADEST=

PAUSE
