@echo off

setlocal

REM 64 bit build
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\vcvars64.bat"

set macro_flags=/DDEBUG=1 /D_CRT_SECURE_NO_WARNINGS
set include_flags=-I External\SDL\include
set compiler_flags=-W3 -Od -nologo -fp:fast -fp:except- -Gm -GR- -EHa- -Zo -Oi -FC -GS- %macro_flags% %include_flags% /std:c++latest /Zi /EHsc /GA /MD
set common_linker_flags=/link /LIBPATH:"External\SDL\lib" /LIBPATH:"C:\Program Files\Microsoft SDKs\Windows\v6.0A\Lib\x64"
set lib_linker_flags=%common_linker_flags% Advapi32.lib
set linker_flags=%common_linker_flags% SDL2.lib opengl32.lib User32.lib winmm.lib

del *.pdb > NUL 2> NUL

set datetimef=%date:~-4%_%date:~3,2%_%date:~0,2%__%time:~0,2%_%time:~3,2%_%time:~6,2%
set datetimef=%datetimef: =_%

cl %compiler_flags% game.cpp -Fegame.dll -Fmgame.map /LD %lib_linker_flags% -PDB:game_%datetimef%.pdb -EXPORT:GameInit -EXPORT:GameUpdate -EXPORT:GameRender
set last_error=%ERRORLEVEL%

cl %compiler_flags% platform.cpp -Fmgame.map %linker_flags% /SUBSYSTEM:CONSOLE
