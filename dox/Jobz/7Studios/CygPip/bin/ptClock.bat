@echo off
::goto ptClockNew
:loop
perl C:\home\Pip\bin\pt
::perl -e "print qq(\n); sleep 1"
perl -e "select(undef, undef, undef, 0.63); print qq(\n)"
if "%_kbhit" == "0" goto loop
:ptClockNew
::perl C:\home\Pip\bin\ptClock.pl
