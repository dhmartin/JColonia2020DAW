@CHCP 65001 > NUL
@ECHO OFF

ECHO Instalación de ECLIPSE 2024-06
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
%UNZIP_DEST%"%PROGRAMDEST%" "%SRCDIR%\eclipse-jee-2024-06-R-win32-x86_64.zip"
ECHO.

ECHO Descomprimiendo «openJDK17» en %JAVADEST%:
%UNZIP_DEST%"%JAVADEST%" "%SRCDIR%\OpenJDK17U-jdk_x64_windows_hotspot_17.0.12_7.zip"
MOVE "%JAVADEST%\jdk-17*" "%JAVADEST%\jdk17"
ECHO.

ECHO Descomprimiendo «openJDK21» en %JAVADEST%:
%UNZIP_DEST%"%JAVADEST%" "%SRCDIR%\OpenJDK21U-jdk_x64_windows_hotspot_21.0.4_7.zip"
MOVE "%JAVADEST%\jdk-21*" "%JAVADEST%\jdk21"
ECHO.

ECHO Descomprimiendo «doxygen» y «graphviz» en %JAVADEST%:
MKDIR "%JAVADEST%\doxygen"
%UNZIP_DEST%"%JAVADEST%\doxygen" "%SRCDIR%\doxygen-1.11.0.windows.x64.bin.zip"
%UNZIP_DEST%"%JAVADEST%" "%SRCDIR%\windows_10_cmake_Release_Graphviz-12.0.0-win64.zip"

MOVE "%JAVADEST%\Graphviz*" "%JAVADEST%\graphviz.0"
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
