pushd
h:\UCIShwDn\
del *.bak /q /e /f /y
deltree /Y UCIShwDn
md UCIShwDn
copy *.* UCIShwDn /q /e
copy Release\UCIShwDn.exe UCIShwDn
xcopy fighters\*.* UCIShwDn\fighters\ /e /q
xcopy scene\*.* UCIShwDn\scene\ /e /q
xcopy allmoves\*.* UCIShwDn\allmoves\ /e /q
set kaka=%_day%
if %@len[%kaka] EQ 1 set kaka=0%kaka
set poop=%_hour%
if %@len[%poop] EQ 1 set poop=0%poop
call zp.bat pip%@convert[10,16,%_month%]%kaka%%poop%.zip UCIShwDn
set kaka= ^ set poop=
popd
