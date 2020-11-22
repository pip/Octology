@echo off
set upldflag=0
set sdirflag=0
set cdirflag=0
set linenumb=0
set linetext=Not Found!!!
set scrpfile=
set scrplist="\home\Pip\bin\eall.ls"
::set scrplist="%USERPROFILE%\My Documents\escripts.lst"
set scrpdire="%USERPROFILE%\My Documents\maya\3.0\scripts"
if "%_cmdproc" == "4NT" goto ntstuff
if "%1" == "" goto not1
if "%1" == "e" goto clear
if "%1" == "a" goto not1
if "%1" == "c" goto not1
if "%1" == "2" goto not1
if "%1" == "2do" goto not1
iff "%1" == "l" then
    iff not defined lastfile then
        echo  *** ERROR ***    No lastfile exists!!! ^ pause
    else ^ set dumbfile=%lastfile% ^ set lastfile=%editfile%
        set editfile=%dumbfile% ^ set dumbfile= ^ goto not1
    endiff
else
    iff not exist %1 then
        iff defined editfile then
            if "%@truename[%@truename[.]\%1]" != "%@truename[%editfile%]" set lastfile=%@truename[%editfile%]
        endiff
        set editfile=%@truename[.]
        if "%@len[%@truename[.]]" != "3" .and. "%@right[1,%editfile]" != "\" set editfile=%editfile%\
        set editfile=%editfile%%1
    elseiff "%@truename[%1]" != "%editfile" then
        if defined editfile set lastfile=%editfile
        set editfile=%@truename[%1]
        iff "%@lfn[%1]" != "%editfile" then
            set editfile=%@truename[.]
            if "%@len[%@truename[.]]" != "3" set editfile=%editfile%\
            set editfile=%editfile%%1
        endiff
rem        if "%@lfn[%1]" != "%@expand[%1]" set editfile=%@expand[%1]
    endiff
endiff
:not1
if "%1" == "a"   set editfile=C:\AutoExec.bat
if "%1" == "c"   set editfile=C:\Config.sys
if "%1" == "2"   set editfile=C:\home\Pip\dox\2do-DESI.txt
if "%1" == "2do" set editfile=C:\home\Pip\dox\2do-DESI.txt
set edit_lfn=%@lfn[%editfile]
q %editfile%
goto end
:clear
set editfile=
set lastfile=
:end
if "%@ext[%editfile]" == "pl"  call d2u %editfile
if "%@ext[%editfile]" == "cgi" call d2u %editfile
iff "%_win" != "0" then
REM    if defined edit_lfn .and. exist %edit_lfn ren %edit_lfn %edit_lfn /q
    iff defined edit_lfn then
        iff exist %edit_lfn then
            ren "%edit_lfn" "%edit_lfn" /q /e
        endiff
    endiff
    iff exist %@path[%editfile]%@name[%editfile].bak then
        set temp_bak="%@path[%editfile]%@name[%@truename["%edit_lfn"]].bak"
        ren %temp_bak "%@path[%editfile]%@name["%edit_lfn"].bak" /q /e
        set temp_bak=
    endiff
endiff
goto realend
:ntstuff
if "%1" == "" goto not14
if "%1" == "?" goto helplist
if "%1" == "e" goto clear4
if "%1" == "a" goto not14
if "%1" == "c" goto not14
if "%1" == "2"   goto not14
if "%1" == "2do" goto not14
if "%1" == "u" set upldflag=1
if "%1" == "ul" set upldflag=2
if "%1" == "ut" set upldflag=3
if "%1" == "cd" set cdirflag=1
if "%1" == "ls" set sdirflag=1
if "%1" == "dr" set sdirflag=1
if "%1" == "dir" set sdirflag=1
if "%1" == "add" echo %@lfn[%2] >> %scrplist
if "%1" == "u" .or. "%1" == "ul" .or. "%1" == "ut" .or. "%1" == "cd" .or. "%1" == "ls" .or. "%1" == "dr" .or. "%1" == "dir" .or. "%1" == "add" shift
iff "%1" == "l" then
    iff not defined lastfile then
        echo  *** ERROR ***    No lastfile exists!!! & pause
    else & set dumbfile=%lastfile% & set lastfile=%editfile%
        set editfile=%dumbfile% & set dumbfile= & goto not14
    endiff
else
    iff %@len[%1] eq 1 then
      if %@convert[16,10,%1] lt 32 goto register
    endiff
    iff %@eval[%sdirflag% + %upldflag%] gt 0 .and. "%1" == "" then
        set scrpfile=%editfile%
    elseiff not exist %1 then
        for %linetext in (@%scrplist) do if "%scrpfile%" == "" .and. "%@index[%@lower[%@filename[%linetext]],%@lower[%1]]" != "-1" set scrpfile=%linetext
        for %linetext in (@%scrplist) do if "%scrpfile%" == "" .and. "%@index[%@lower[%linetext],%@lower[%1]]" != "-1" set scrpfile=%linetext
        if "%scrpfile" == "" echos > %1
    endiff
    if "%scrpfile" == "" set scrpfile=%1
    iff defined scrpfile .and. exist %scrpfile% then
        iff defined editfile .and. exist %editfile% then
            if "%@sfn[%scrpfile%]" != "%@sfn[%editfile%]" set lastfile=%editfile%
        endiff
        set editfile=%@sfn[%scrpfile]
    endiff
endiff
iff "%cdirflag%" == "1" .or. "%2" == "cd" then
    cd %@replace[%@filename[%scrpfile%],,%scrpfile%]
    goto realend
elseiff "%upldflag%" == "1" .or. "%2" == "u" then
    iff "%@lower[%@ext[%scrpfile%]]" == "mel" then
        copy %scrpfile% %scrpdire%
    endiff
    goto realend
elseiff "%upldflag%" == "2" .or. "%2" == "ul" then
    iff "%@lower[%@ext[%scrpfile%]]" == "pl" then
        copy %scrpfile% p:\MayaUtils\PerlScripts
    elseiff "%@lower[%@ext[%scrpfile%]]" == "mel" then
        copy %scrpfile% p:\MayaUtils\InternalMels
::        copy %scrpfile% %scrpdire%
    endiff
    goto realend
elseiff "%upldflag%" == "3" .or. "%2" == "ut" then
    iff "%@lower[%@ext[%scrpfile%]]" == "pl" then
        copy %scrpfile% p:\MayaUtils\PerlScripts\Test
    elseiff "%@lower[%@ext[%scrpfile%]]" == "mel" then
        copy %scrpfile% p:\MayaUtils\InternalMels\Test
::        copy %scrpfile% %scrpdire%
    endiff
    goto realend
elseiff "%sdirflag%" == "1" then
    dir %scrpdire%
    goto realend
endiff
goto not14
:register
iff %@convert[16,10,%1] le %@lines[%scrplist%] then
    set scrpfile=%@line[%scrplist, %@convert[16,10,%1]]
    iff "%cdirflag" == "1" .or. "%2" == "cd" then
        cd %@replace[%@filename[%scrpfile],,%scrpfile]
        goto realend
    endiff
else
    set scrpfile=%1
endiff
if not defined scrpfile .or. "%scrpfile%" == "" goto realend
if not exist %scrpfile% echos > %scrpfile
iff defined editfile .and. exist %editfile% then
    if "%@sfn[%scrpfile%]" != "%@sfn[%editfile%]" set lastfile=%@sfn[%editfile%]
endiff
set editfile=%@sfn[%scrpfile]
:not14
if "%1" == "a"   set editfile=C:\AutoExec.bat
if "%1" == "c"   set editfile=C:\Config.sys
if "%1" == "2"   set editfile=C:\home\pip\dox\jobz\Trilogy\TS-2do.txt
if "%1" == "2do" set editfile=C:\home\pip\dox\2do\Taki.txt
if "%editfile%" != "" set edit_lfn=%@lfn[%editfile]
vim %editfile%
REM C:\Vim\vim62d32\vim.exe %editfile%
REM q %editfile%
goto end4
:clear4
set editfile=
set lastfile=
:end4
if "%@ext[%editfile]" == "pl"  call d2u %editfile
if "%@ext[%editfile]" == "cgi" call d2u %editfile
iff "%_win" != "0" then
REM    if defined edit_lfn .and. exist %edit_lfn ren %edit_lfn %edit_lfn /q
    iff defined edit_lfn then
        iff exist %edit_lfn then
            ren "%edit_lfn" "%edit_lfn" /q /e
        endiff
    endiff
    iff exist %@path[%editfile]%@name[%editfile].bak then
        set temp_bak="%@path[%editfile]%@name[%@truename["%edit_lfn"]].bak"
        ren %temp_bak "%@path[%editfile]%@name["%edit_lfn"].bak" /q /e
        set temp_bak=
    endiff
endiff
if "%@filesize[%editfile%,b]" == "0" del /q %editfile%
goto realend
:helplist
echo  Pip's e.bat help text - Currently registered files:
for %linetext in (@%scrplist) do (echo %@convert[10,16,%linenumb]:%linetext & set linenumb=%@inc[%linenumb])
:realend
set upldflag=
set sdirflag=
set cdirflag=
set linenumb=
set linetext=
set scrpfile=
set scrplist=
