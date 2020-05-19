@CHCP 65001 > NUL
@ECHO OFF

ECHO Entorno Java
ECHO ============
ECHO.

SET PATH=c:\java\jdk11\bin;%PATH%
SET PATH=c:\java\doxygen;c:\java\graphviz;%PATH%
SET PATH=%ProgramFiles%\varios;%PATH%

SET CLASSPATH=bin

SET JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

javac -version

ECHO.
ECHO JAVA_TOOL_OPTIONS=%JAVA_TOOL_OPTIONS%
ECHO CLASSPATH=%CLASSPATH%
ECHO PATH=%PATH%
ECHO.
