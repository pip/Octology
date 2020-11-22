@echo off
:: 356 is the line to find...
:: the only better way is to stick the list in a dedicated file =(
:storPal
    set savd=0
    >batcopy1.pal
    setdos /x-4
    copy %_batchname batcopy0.pal /q
    set cpbt=%@fileopen[batcopy0.pal,read,t]
:storlineloopie
    set junk=%@fileread[%cpbt]
        echo %junk
        pause
    setdos /x+7
    echo %junk >> batcopy1.pal
    setdos /x-7
    if "%junk" != "*******FindMe*******" goto storlineloopie
    setdos /x+15678
:storpalsloopie
    set junk=%@fileread[%cpbt]
    if not exist %junk goto noStor
    if "%@left[10,%@line[%junk,0]]" == "rem BaTpal" echo %junk >> batcopy1.pal
:noStor
    if "%junk" == "%savf" set savd=1
    if "%junk" != "**EOF**" goto storpalsloopie
    if "%savd" == "0" echo %savf >> batcopy1.pal
    set savd=
    copy batcopy1.pal %_batchname /q
    set junk=%@fileclose[%cpbt]
    del batcopy0.pal /q
    del batcopy1.pal /q
    setdos /x0
return
