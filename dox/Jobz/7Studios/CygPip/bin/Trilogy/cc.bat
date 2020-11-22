@echo off
d:
cd\tasm\tigger\cubix
if "%1" == "" goto nocmdlnargs
set curfile=%1
if "%2" == "e" goto editistwo 
if "%2" == "q" goto editistwo 
set whichedt=q
goto nocmdlnargs
:editistwo
set whichedt=%2
:nocmdlnargs
if exist %curfile%.asm goto continue
echo File doesn't exist...  Usage: cc <filename w/o extention> <e-edit,q-qedit>
goto end
:continue
@echo on
@call c:\batch\m.bat
@dir/w
@call c:\batch\c.bat %curfile%
%curfile%.com
@c:\batch\med.com
@echo\
@if %whichedt% == q echo Using QEdit to edit %curfile%.asm
@if %whichedt% == e echo Using the MS-DOS Editor to edit %curfile%.asm
@pause
@if %whichedt% == q q %curfile%
@if %whichedt% == e edit %curfile%.asm
:end
