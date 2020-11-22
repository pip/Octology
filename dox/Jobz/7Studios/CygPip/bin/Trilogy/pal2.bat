@echo off
if %1x==x goto menu
if %1==a  goto dark_purple
if %1==b  goto label2
if %1==c  goto label3
if %1==d  goto default
:menu
echo [0;30mлн[1;37m0 [0;34mлн[1;37m1 [0;32mлн[1;37m2 [0;36mлн[1;37m3
echo џ
echo [0;31mлн[1;37m4 [0;35mлн[1;37m5 [0;33mлн[1;37m6 [0;37mлн[1;37m7
echo џ
echo [1;30mлн[1;37m8 [1;34mлн[1;37m9 [1;32mлн[1;37ma [1;36mлн[1;37mb
echo џ
echo [1;31mлн[1;37mc [1;35mлн[1;37md [1;33mлн[1;37me [1;37mлн[1;37mf
echo [0m
  echo a - dark purple
  echo b - ?
  echo c - ?
  echo d - default
  choice /C:abcd /N
  if errorlevel==4 goto default:
  if errorlevel==3 goto label3:
  if errorlevel==2 goto label2:
  if errorlevel==1 goto dark_purple:
  goto end:

:dark_purple
  setpal 00090204 01120608 07322c28
  goto end:

:label2
  goto end:

:label3
  goto end:

:default
  setpal 00000000 0100002a 02002a00 03002a2a 042a0000 052a002a 142a1500 072a2a2a
  setpal 38151515 3915153f 3a153f15 3b153f3f 3c3f1515 3d3f153f 3e3f3f15 3f3f3f3f

:end
