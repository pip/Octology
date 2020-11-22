@echo off
:: -- Run Vim --
if        "%VimExeDir%"   == "" set VimExeDir=%HOME%\bin\vim71
if exist  "%VimExeDir%\vim.exe" goto HaveVim
                                set VimExeDir=%HOME%\bin\vim70
if exist  "%VimExeDir%\vim.exe" goto HaveVim
if        "%Vim%"         == "" set       Vim=%HOME%\bin
if exist  "%Vim%\vim70\vim.exe" set VimExeDir=%Vim%\vim70
if exist  "%Vim%\vim71\vim.exe" set VimExeDir=%Vim%\vim71
if exist  "%VimExeDir%\vim.exe" goto HaveVim
if exist "%VimRunTime%\vim.exe" set VimExeDir=%VimRunTime%
if exist  "%VimExeDir%\vim.exe" goto HaveVim
echo      "%VimExeDir%\vim.exe" not found
goto EOF
:HaveVim
if .%ComSpec%==.C:\WINDOWS\system32\cmd.exe goto NTCmd
::if .%OS%==.Windows_NT goto NTCmd
:: collect the arguments in %VimArgs for Win(9[58]|ME)
set VimArgs=
:LoopStart
if .%1==. goto LoopEnd
set VimArgs=%VimArgs% %1
shift
goto LoopStart
:LoopEnd
"%VimExeDir%\vim.exe" %VimArgs%
set VimArgs=
goto EOF
:NTCmd
:: for WinNT's Cmd.exe we can use %*
"%VimExeDir%\vim.exe" %*
:EOF
