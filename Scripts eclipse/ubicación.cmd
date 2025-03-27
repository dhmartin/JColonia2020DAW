@CHCP 65001 > NUL
@ECHO OFF

SET PS1=JDK
SET PROMPT=$e[0;33m$c%PS1%$f$s$e[0;32m$p$g$e[m$s

ECHO Entorno Java/Eclipse
ECHO ====================
ECHO.

SET ruta=%~dp0
SET ruta=%ruta:~0,-1%
ECHO Instalado en %ruta%…

SET oldpath=%PATH%
SET PATH=%ruta%\jdk21\bin;%PATH%
SET PATH=%ruta%\doxygen;%ruta%\graphviz;%PATH%
SET PATH=%ProgramFiles%\varios;%PATH%

ECHO.
ECHO PATH=%PATH%

ECHO.
ECHO Opciones de ejecución de «Entorno JDK21»:
ECHO %windir%\system32\cmd.exe /K "%ruta%\ijava21W10.cmd"

ECHO.
ECHO Opciones de ejecución de «Entorno JDK24»:
ECHO %windir%\system32\cmd.exe /K "%ruta%\ijava24W10.cmd"
ECHO.
ECHO Opciones de ejecución de «eclipse IDE»:
ECHO %ruta%\eclipse\eclipse.exe -vm "%ruta%\jdk24\bin\javaw.exe" -data "Mis proyectos"

ECHO.
SET PATH=%oldpath%
PAUSE
