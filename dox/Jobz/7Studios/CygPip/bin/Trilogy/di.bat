@echo off
if "%1" == "e" set string= *.exe
if "%1" == "E" set string= *.exe
if "%1" == "b" set string= *.bat
if "%1" == "B" set string= *.bat
if "%1" == "c" set string= *.com
if "%1" == "C" set string= *.com
if "%1" == "t" set string= *.txt
if "%1" == "T" set string= *.txt
if "%1" == "d" set string= *.doc
if "%1" == "D" set string= *.doc
if "%1" == "z" set string= *.zip
if "%1" == "Z" set string= *.zip
if "%1" == "dog" set string= /ogd
if not "%string%" == "" dir %string% %2 %3 %4 %5 %6 %7 %8 %9
if "%string%" == "" dir %1 %2 %3 %4 %5 %6 %7 %8 %9
set string=
