@echo off
set RemoteSCpBoxIP=%RyuIP%
iff     "%@left[1,%1]" == ":" then
  pscp pip@%RemoteSCpBoxIP%%1 %2 %3 %4 %5 %6 %7 %8 %9
elseiff "%@left[1,%2]" == ":" then
  pscp %1 pip@%RemoteSCpBoxIP%%2 %3 %4 %5 %6 %7 %8 %9
elseiff "%@left[1,%3]" == ":" then
  pscp %1 %2 pip@%RemoteSCpBoxIP%%3 %4 %5 %6 %7 %8 %9
else
  echo No pip@$box: colon found!  Using normal pscp...
  pscp %1 %2 %3 %4 %5 %6 %7 %8 %9
endiff
