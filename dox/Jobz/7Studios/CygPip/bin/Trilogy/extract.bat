::extract all files specified by file paths in a specified file to a specified place =)
::  ie. c:> extract badfiles.txt d:\trash
::  normally copies but /m parameter will force movement
@echo off
set kaka=
set linz=0
set copi=1
:re1loadParam
set sour=BadFiles.txt
if "%1" != "" set sour=%1
if "%sour" == "/m" .or. "%sour" == "-m" set copi=0
if "%sour" == "/m" .or. "%sour" == "-m" shift
if "%sour" == "/m" .or. "%sour" == "-m" goto re1loadParam
:re2loadParam
set dest=%_cwd
if "%2" != "" set dest=%2
if "%dest" == "/m" .or. "%dest" == "-m" set copi=0
if "%dest" == "/m" .or. "%dest" == "-m" shift
if "%dest" == "/m" .or. "%dest" == "-m" goto re2loadParam
if "%3" == "/m" .or. "%3" == "-m" set copi=0
if not exist %sour echo **** INVALID FILE ****   Please specify a file for Extract to use.
if not exist %sour goto errorQuit
set shnd=%@fileopen[%sour,read]
:extractAnother
set kaka=%@fileread[%shnd]
if "%kaka" == "**EOF**" goto errorQuit
set linz=%@inc[%linz]
if exist %kaka .and. "%copi" == "1" echo copying %kaka to %dest...
if exist %kaka .and. "%copi" == "1" copy %kaka %dest /e /q
if exist %kaka .and. "%copi" == "0" echo moving %kaka to %dest...
if exist %kaka .and. "%copi" == "0" move %kaka %dest /e /q
goto extractAnother

:errorQuit
if exist %sour set poop=%@fileclose[%shnd]

:end
echo [1;35mFile: [35m%sour  [33mTotal Extracted: [1;34m%@comma[%linz][32m
set sour= ^ set kaka= ^ set linz= ^ set shnd= ^ set poop= ^ set dest= ^ set copi=
