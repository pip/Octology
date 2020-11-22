@echo off
if "%1" == "" goto not1
if "%1" == "e" goto clear
if "%1" == "a" goto not1
if "%1" == "c" goto not1
iff "%1" == "l" then ^
    iff not defined lastfile then ^
        echo  *** ERROR ***    No lastfile exists!!! ^ pause ^
    else ^ set dumbfile=%lastfile% ^ set lastfile=%editfile% ^
        set editfile=%dumbfile% ^ set dumbfile= ^ goto not1 ^
    endiff ^
else ^
    iff not exist %1 then ^
        iff defined editfile then ^
            if "%@truename[%@truename[.]\%1]" != "%@truename[%editfile%]" set lastfile=%@truename[%editfile%] ^
        endiff ^
        set editfile=%@truename[.] ^
        if "%@len[%@truename[.]]" != "3" set editfile=%editfile%\ ^
        set editfile=%editfile%%1 ^
    elseiff "%@truename[%1]" != "%editfile" then ^
        if defined editfile set lastfile=%editfile ^
        set editfile=%@truename[%1] ^
    endiff ^
endiff
:not1
if "%1" == "a" set editfile=C:\AutoExec.bat
if "%1" == "c" set editfile=C:\Config.sys
set edit_lfn=%@lfn[%editfile]
q %editfile%
goto end
:clear
set editfile=
set lastfile=
:end
iff "%_win" != "0" then
REM    if defined edit_lfn .and. exist %edit_lfn ren %edit_lfn %edit_lfn /q
    iff defined edit_lfn then
        iff exist %edit_lfn then
            ren "%edit_lfn" "%edit_lfn" /q /e
        endiff
    endiff
    iff exist %@path[%editfile]%@name[%editfile].bak then ^
        set temp_bak="%@path[%editfile]%@name[%@truename["%edit_lfn"]].bak" ^
        ren %temp_bak "%@path[%editfile]%@name["%edit_lfn"].bak" /q ^
        set temp_bak= ^
    endiff
endiff
