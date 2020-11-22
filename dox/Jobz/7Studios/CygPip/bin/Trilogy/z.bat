@echo off
c:
cd\zengraf
if "%1" == "" call c:\batch\ls.bat
if "%1" == "" goto end
cd chap%1
if "%2" == "" call c:\batch\dr.bat e
if not "%2" == "" l%1-%2.exe
if not "%2" == "" call c:\batch\m.bat
:end
