@CHCP 65001 > NUL
@ECHO OFF

SET OLDPATH=%PATH%
SET PATH=c:\java\jdk11\bin;%PATH%
SET CLASSPATH=bin
SET JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

ECHO Procesado «dropins» para ECLIPSE
ECHO =================================
ECHO.

SET SRCDIR=%~dp0
SET DEST=%ProgramFiles%\eclipse\plugins

IF EXIST "%DEST%" (
	FOR %%F in ("%DEST%\org.eclipse.equinox.launcher_*") DO SET LAUNCHER_JAR="%%F"
)

java -cp %LAUNCHER_JAR% org.eclipse.equinox.launcher.Main -application org.eclipse.equinox.p2.reconciler.application

ECHO.

PAUSE
SET SRCDIR=
SET DEST=
SET PATH=%OLDPATH%
