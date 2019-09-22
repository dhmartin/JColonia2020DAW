@mode con cp select=65001 > NUL
@echo off
echo Entorno Java
echo ============
echo.

set PATH=c:\java\jdk11\bin;%PATH%
set PATH=%ProgramFiles%\varios;%PATH%

set CLASSPATH=.\;c:\java\junit\junit.jar

set JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

javac -version

echo.
echo JAVA_TOOL_OPTIONS=%JAVA_TOOL_OPTIONS%
echo CLASSPATH=%CLASSPATH%
echo PATH=%PATH%
echo.