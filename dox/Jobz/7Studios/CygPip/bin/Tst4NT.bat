@echo off
if not "%@eval[2+2]%" == "4" goto No4NT
echo 4NT is loaded! =)
goto End
:No4NT
echo No 4NT! =(
:End
