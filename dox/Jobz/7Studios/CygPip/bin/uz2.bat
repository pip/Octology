pkunzip -doq %&
iff exist %@name[%1].DIR then
  set fhnd=%@fileopen[%@name[%1].DIR, read]
  set fatn=%@fileread[%fhnd]
  set nfat=%@word["\",-0,%fatn]
  set vfat=%@word["\",-0,%@fileread[%fhnd]]
  ren %nfat %vfat
  cd %vfat
  set nfat=
  do while "%nfat" != "EOF"
rem echo Looking for Directory Line:
    do while "%@index[%nfat, Directory of  %fatn]" != "0" .and. "%nfat" != "EOF"
      set nfat=%@fileread[%fhnd]
      if "%nfat" != "" set nfat=%@strip[*,%nfat]
rem if "%nfat" == "" echo.
rem if "%nfat" != "" echo %nfat
    enddo
rem pause
rem echo Strip DirText from:%nfat
    set nfat=%@right[%@eval[%@len[%nfat]-%@len[%fatn]-15],%nfat]
echo Entering Directory: "%nfat"
    pushd
rem cd
    if "%nfat" != "" .and. direxist %nfat cd "%nfat"
rem cd
rem pause
    set kaka=%@fileread[%fhnd]
rem echo blankaka:%kaka
    set kaka="%@fileread[%fhnd]"
    do while "%@right[1,%@left[4,%kaka]]" == "-"
rem echo file:%kaka
rem echo %@trim[%@instr[33,16,%kaka]] "%@trim[%@instr[49,%kaka]]
rem pause
      ren %@trim[%@instr[33,16,%kaka]] "%@trim[%@instr[49,%kaka]] /q
      set kaka="%@fileread[%fhnd]"
    enddo
    popd
  enddo
  set kaka=%@fileclose[%fhnd]
  set fhnd= ^ set fatn= ^ set nfat= ^ set vfat= ^ set kaka=
endiff
