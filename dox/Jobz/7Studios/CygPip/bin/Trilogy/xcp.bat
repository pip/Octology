:: Super X-copy copies all files in subdirectories to a single dir
:: xcp c:\pip d:\dump .or. xcp mp3 .or. xcp . kaka .or. xcp
set from=.\
if "%1" != "" .and. direxist %1 set from=%1
set dest=%@lfn[.\]
if "%2" != "" set dest=%@lfn[%2]
if not direxist %@lfn[%dest] md %@lfn[%dest]
set dest=%@lfn[%dest]
if "%@right[1,%from]" == "*" set from=%@left[%@dec[%@len[%from]],%from]
if "%@right[1,%from]" == "." set from=%@left[%@dec[%@len[%from]],%from]
if "%@right[1,%from]" == "*" set from=%@left[%@dec[%@len[%from]],%from]
if "%@right[1,%from]" != "\" set from=%from\
if "%from" == "\" set from=.\
echo %@sfn[%@path["%from"]] > c:\tmptmp00.dir
echo %@lfn[%@path["%from"]] >> c:\tmptmp00.dir
dir /hx /s %@sfn[%@path["%from"]] >> c:\tmptmp00.dir
if "%dest" != "" .and. "%@right[1,%dest]" != "\" set dest=%dest\
if not exist c:\tmptmp00.dir quit
echo  !! Copying files...
set fhnd=%@fileopen[c:\tmptmp00.dir,read]
if "%fhnd" == "-1" quit
pushd %@lfn[%from]
set fatn=%@fileread[%fhnd]
set nfat=%@word["\",-0,%fatn]
set vfat=%@word["\",-0,%@fileread[%fhnd]]
set nfat= ^ set kaka=
do while "%nfat" != "EOF" .and. %kaka != "**EOF**"
  do while "%@index[%nfat, Directory of  %fatn]" != "0" .and. "%nfat" != "EOF"
    set nfat=%@fileread[%fhnd]
    if "%nfat" != "" set nfat=%@strip[*,%nfat]
  enddo
  if "%nfat" == "EOF" goto done
  set nfat=%@right[%@eval[%@len[%nfat]-%@len[%fatn]-15],%nfat]
  if "%nfat" == "" echos %vfat\
  if "%nfat" != "" echos %nfat
  pushd
  if "%nfat" != "" .and. direxist %nfat cd "%nfat"
  set kaka=%@fileread[%fhnd]
  set kaka="%@fileread[%fhnd]"
  do while "%@right[1,%@left[4,%kaka]]" == "-"
    set vfat="%@trim[%@instr[49,%kaka]]
    set poop=
    if "%@trim[%@instr[24,6,%kaka]]" != "<DIR>" .and. "%@path[%@lfn[%@trim[%@instr[33,16,%kaka]]]]" != "%@path[%@lfn[%dest]]" copy /e /q %@trim[%@instr[33,16,%kaka]] %dest
    if "%@trim[%@instr[24,6,%kaka]]" != "<DIR>" .and. "%@path[%@lfn[%@trim[%@instr[33,16,%kaka]]]]" != "%@path[%@lfn[%dest]]" echos .
    set kaka="%@fileread[%fhnd]"
  enddo
  popd
  echo.
enddo
:done
set kaka=%@fileclose[%fhnd]
popd
del c:\tmptmp00.dir /q
echo    ***********************************************************
echo  ** Thanks for using my tools... I don't want your money but  **
echo *** I would like your utilities if they are worthwhile...     ***
echo *** Please email me any 4dos batch files, shell scripts, or   ***
echo *** Perl scripts that you like or use or both. TTFN & Shalom. ***
echo  **    Tools:  xcp      By: nitemare@uci.edu         10-28-99 **
echo    ***********************************************************
set fhnd= ^ set fatn= ^ set nfat= ^ set vfat= ^ set kaka= ^ set name=
set poop= ^ set dung= ^ set plop=
