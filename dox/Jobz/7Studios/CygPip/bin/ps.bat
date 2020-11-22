pushd c:\pip\muz\s3m
iff "%1" == "" then ^
  set S3Mdelay=160 ^
else ^
  set S3Mdelay=%1 ^
endiff
set sd=%@int[%@eval[%S3Mdelay/80]]
for %x in (*.s3m) do ( %x ^ echo Now playing %x ... ^ echo type cs to quit after Esc ^ echo. ^ echos `Begin  °±²Û  ----->  °±²Û  ¯¯¯¯¯¯  °±²Û   >>>>>>  °±²Û    °±²Û  Time is Up`^ set z=0 ^ gosub keyz ^ @call cs.bat n )
goto done
:keyz
set y=
inkey /PX /W%sd %%y
if %z LT 20 echos °
if %z GE 20 .and. %z LT 40 echos ±
if %z GE 40 .and. %z LT 60 echos ²
if %z GE 60 echos Û
iff %y==x .or. %y==%@char[27] then
    set x=
    set y=
    set z=
    set sd=
    set S3Mdelay=
    popd
    cancel
endiff
if %y==@45 goto done
if "%y"=="%@char[32]" set z=80
set z=%@inc[%z]
if %z LE 79 goto keyz
return
:done
echo exiting Play S3ms...
set S3Mdelay=
set sd=
set x=
set y=
set z=
popd
cancel
