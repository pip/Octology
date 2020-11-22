@echo off
if "%1" == "" goto not1
if "%1" == "c" goto clear
set execfile=%_cwds%%1
:not1
if not "execfile" == "" goto noset
if "editfile" == "" set editfile=d:\tasm\tigger\cubix\kaka
if "%execfile%" == "" set execfile=%editfile%
:noset
tasm %execfile% /m2
tlink %execfile% /x %2 %3 %4 %5 %6 %7 %8
goto end
:clear
set execfile=
:end
