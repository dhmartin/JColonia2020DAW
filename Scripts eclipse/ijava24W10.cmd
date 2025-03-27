@CHCP 65001 > NUL
@ECHO OFF

SET PS1=JDK24
SET PROMPT=$e[0;33m$c%PS1%$f$s$e[0;32m$p$g$e[m$s

ECHO Entorno Java
ECHO ============
ECHO.

SET PATH=c:\java\jdk24\bin;%PATH%
SET PATH=c:\java\doxygen;c:\java\graphviz;%PATH%
SET PATH=%ProgramFiles%\varios;%PATH%

SET CLASSPATH=bin

javac -version

ECHO.
ECHO CLASSPATH=%CLASSPATH%
ECHO PATH=%PATH%
ECHO.
