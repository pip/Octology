::convert 11-9-98 -> soc to text delimited
:: converted on Sun. 11-15-99 linez=929,111 numco=44,944  **scrapped**
:: converted on Thu. 11-18-99               numco=44,975
@echo off
set dent=DataEntr.txt
if "%1" != "" set dent=%1
call db /q /e
set kaka= ^ set linz=0 ^ set cmpz=0
if not exist %dent echo **** INVALID FILE ****   Please specify a data entry file for Convert to use.
if not exist %dent goto errorQuit
set dhnd=%@fileopen[%dent,read]
:blankReadAnother
if "%kaka" == "" set kaka=%@fileread[%dhnd]
set linz=%@inc[%linz]
if "%kaka" == "" goto blankReadAnother
if "%kaka" == "**EOF**" goto errorQuit
set cmpz=%@inc[%cmpz]
:datumReadAnother
if "%kaka" != "" set kaka=%@fileread[%dhnd]
set linz=%@inc[%linz]
if "%kaka" == "**EOF**" goto errorQuit
if "%kaka" != "" goto datumReadAnother
goto blankReadAnother

:errorQuit
if exist %dent set poop=%@fileclose[%dhnd]
if "%kaka" != "**EOF**" goto end
call db /e /q

:end
if "%linez" == "" set linez=0
set linez=%@eval[%linez+%linz]
if "%numco" == "" set numco=0
set numco=%@eval[%numco+%cmpz]
echo [1;35mFile: [35m%dent  [33mTotal Linez: [1;34m%@comma[%linez]  [31mTotal Read: [1;34m%@comma[%numco][32m
set dent= ^ set kaka= ^ set linz= ^ set cmpz= ^ set dhnd= ^ set poop=
