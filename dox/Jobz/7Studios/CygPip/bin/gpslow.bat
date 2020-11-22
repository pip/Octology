REM Attempt to port GetPrimes from my HP48GX into 4dos batch
timer on /2
inkey /c /w0 %%ky
set pfil=c:\PrimeSlo.txt
set y=0
set ky=0
set strt=5
set esiz=%1
iff exist %pfil then
    set strt=%@line[%pfil,%@lines[%pfil]]
    if %1 LE %@lines[%pfil] set esiz=%@eval[%@lines[%pfil]+4]
    if "%1" == "" set esiz=1048576
    if "%1" == "" call darkPrim.bat
else
    echo 1
    echo 1 > %pfil
    echo 2
    echo 2 >> %pfil
    echo 3
    echo 3 >> %pfil
    echo 5
    echo 5 >> %pfil
    if %1 LE %@lines[%pfil] set esiz=%@eval[%@lines[%pfil]+4]
    if "%1" == "" set esiz=256
endiff
set esiz=%@dec[%esiz]
set x=%strt
set strt=1
set phnd=%@fileopen[%pfil,read,t]
:loopie
timer on
set poop=%@fileseekl[%phnd,1]
set y=1
set x=%@eval[%x+2]
if "%@instr[%@len[%x],1,%x]" == "5" set x=%@eval[%x+2]
:repeet
set poop=%@fileread[%phnd]
if %@eval[%poop*%poop] GT %x goto found1
    inkey /p /w0 /x %%ky
    if "%ky" == "b" .or. "%ky" == "B" set strt=1
    if "%ky" == "s" .or. "%ky" == "S" set strt=0
    if "%ky" == "%@char[27]" echo  *** Quitting GetPrime ***        ... last prime found:  n=%@inc[%@lines[%pfil]]
    if "%ky" == "%@char[27]" goto end
    set y=%@inc[%y]
    set junk=%@eval[%x/%poop]
    if %junk != %@int[%junk] goto repeet
        set x=%@eval[%x+2]
        if "%@instr[%@len[%x],1,%x]" == "5" set x=%@eval[%x+2]
        set poop=%@fileseekl[%phnd,1]
        set y=1
        goto repeet
:found1
echo %x >> %pfil
set poop=%@inc[%@lines[%pfil]]
set ky=%@line[%pfil,%y]
if "%strt" == "0" screen 23 0 Prime [1;33m%poop: [1;32m%x[0;37m        { Press Esc to Quit }
if "%strt" == "1" screen 23 0 Prime [1;33m%poop: [1;32m%x[0;37m  MaxChk is P%@inc[%y]: %ky*%ky=%@eval[%ky*%ky]  Prcnt: %@eval[100*(%y/%poop)] {Esc}
echo.
timer
if %@lines[%pfil] LT %esiz goto loopie
:end
set poop=%@fileclose[%phnd]
set x=
set y=
set ky=
set mcln=
set mcps=
set phnd=
set poop=
set pfil=
set strt=
set esiz=
set junk=
timer /2
