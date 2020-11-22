@echo MoVeDirectory Batch Util by Tigger
@echo off
if "%1" == "" .OR. "%2" == "" goto BadQuit
iff isdir %2 then
    pushd
    cd %2
    md %1
    popd
    copy %1\*.* %2\%1\ /esq
else
    md %2
    copy %1\*.* %2\ /esq
endiff
deltree %1
goto End
:BadQuit
@echo ERROR: Invalid Directory!!!
:End
