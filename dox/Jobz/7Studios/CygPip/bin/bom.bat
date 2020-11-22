pushd c:\4dos\command
iff not defined bomb then ^
  keystack /w8 "p" /w2 "q" ^ bombplay ^ set bomb=1 ^
elseiff "%1" == "n" then ^
  keystack /w8 "n" /w2 "q" ^ bombplay ^
elseiff "%1" == "p" then ^
  keystack /w8 "v" /w2 "q" ^ bombplay ^
else ^
  bombplay ^
endiff
call m.bat
call TigsFavs.bat
popd
set bomb_off=n
inkey /w2 /x /k"yn" Did you stop the cd? %%bomb_off
if "%bomb_off" == "y" set bomb=
set bomb_off=
