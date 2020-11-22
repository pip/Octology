@echo off
::if "%COMSPEC%" == "C:\WINDOWS\system32\cmd.exe" echo "dir /n /o:gne /q %*"
if "%COMSPEC%" == "C:\WINDOWS\system32\cmd.exe" dir /n /o:gne /q %*
if "%COMSPEC%" == "C:\WINDOWS\system32\cmd.exe" goto End
::if "%1" == "" dir /km %@execstr[perl "%HOME%\bin\pls.pl" "%_cwd"]
::dir /hkmno:agne %1 %2 %3 %4 %5 %6 %7 %8 %9
dir /hkmno:agne %*
:End
