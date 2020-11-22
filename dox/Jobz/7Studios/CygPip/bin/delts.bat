set pfil=%@fileopen[c:\Primes.txt,read,t]
set wfil=%1
if "%wfil" == "" set wfil=c:\Del.txt
REM set x0=%@fileread[%pfil]
set x1=%@fileread[%pfil]
REM echo %@eval[%x1-%x0] > %wfil
echo %x1 %@eval[%x1*%x1] > %wfil
:loopie
REM set x0=%x1
set x1=%@fileread[%pfil]
if "%x1" == "**EOF**" goto end
echo %x1 %@eval[(%x1*%x1)] >> %wfil
REM echo %@eval[(%x1-%x0)/2] >> %wfil
goto loopie
:end
set x0=%@fileclose[%pfil]
set x0=
set x1=
set pfil=
set wfil=
