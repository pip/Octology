cdd h:\UCIShwDn\
del *.bak /q /e /f /y
if not DIREXIST UCIShwDn md UCIShwDn
del UCIShwDn\* /q /e /f /y
copy * UCIShwDn\ /q /e /f /y
cd UCIShwDn\
del UCIShwDn.* /q /e /f /y
cd..
copy UCIShwDn.C UCIShwDn\
set kaka=%_day%
if %@len[%kaka] LT 10 set kaka=0%kaka
call zp.bat pip%@convert[10,16,%_month%]%kaka%%@right[2,%_year%].zip UCIShwDn
set kaka=
