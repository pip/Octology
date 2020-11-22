REM Attempt to port GetPrimes from my HP48GX into 4dos batch
inkey /c /w0 /p /x %%ky
set pfil=c:\Primes.txt
set ky=0
set strt=1
set esiz=%1
set esiz=%@dec[%esiz]
iff exist %pfil then
    set strt=%@line[%pfil,%@lines[%pfil]]
    if "%1" == "" .or. %1 LE %@lines[%pfil] set esiz=%@eval[%@lines[%pfil]+4]
else
    echo 1
    echo 1 > %pfil
    echo 2
    echo 2 >> %pfil
    set strt=1
    if "%1" == "" .or. %1 LE %@lines[%pfil] set esiz=%@eval[%@lines[%pfil]+4]
endiff
set x=%strt
REM set pf=%@fileopen[%pfil,read,t]
:loopie
REM set poop=%@fileseekl[%pf,1]
set x=%@eval[%x+2]
set y=1
:repeet
REM set poop=%@fileread[%pf]
set poop=%@line[%pfil,%y]
if %poop GT %@int[%@eval[%x/3]] goto found1
    inkey /p /w0 /x %%ky
    if "%ky" == "%@char[27]" echo Quitting GetPrime... last line=%@inc[%@lines[%pfil]]
    if "%ky" == "%@char[27]" goto end
    set junk=%@eval[%x/%poop]
    if %junk != %@int[%junk] goto thisOkay
        set x=%@eval[%x+2]
        set y=1
        goto repeet
:thisOkay
        set y=%@inc[%y]
goto repeet
:found1
echo %x
echo %x >> %pfil
if %@lines[%pfil] LT %esiz goto loopie
:end
REM set poop=%@fileclose[%pf]
set x=
set y=
set ky=
set pf=
set poop=
set pfil=
set strt=
set esiz=
set junk=
