@CHCP 65001 > NUL
@ECHO OFF

SET PS1=JDK25
SET PROMPT=$e[0;33m$c%PS1%$f$s$e[0;32m$p$g$e[m$s

ECHO Entorno Java
ECHO ============
ECHO.

SET ruta=%~dp0
SET ruta=%ruta:~0,-1%

SET PATH=%ruta%\jdk25\bin;%PATH%
SET PATH=%ruta%\doxygen;%ruta%\graphviz;%PATH%
SET PATH=%ProgramFiles%\varios;%PATH%

SET CLASSPATH=bin

javac -version

ECHO.
ECHO CLASSPATH=%CLASSPATH%
ECHO PATH=%PATH%
ECHO.
