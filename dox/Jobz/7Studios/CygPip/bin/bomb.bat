pushd c:\4dos\command
iff not defined bomb then ^
  keystack /w8 "p" /w2 "q" ^ bombplay ^ set bomb=1 ^
elseiff "%1" == "n" then ^
  keystack /w8 "n" /w2 "q" ^ bombplay ^
elseiff "%1" == "p" then ^
  keystack /w8 "v" /w2 "q" ^ bombplay ^
else ^
  keystack /w8 "s" /w2 "q" ^ bombplay ^ set bomb=^
endiff
call m.bat
popd
