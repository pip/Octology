pushd
cdd /a > c:\tmptmp07.tmp
set size=b
if "%1" != "" set size=%1
set line=0
set linz=%@lines[c:\tmptmp07.tmp]
set ttot= ^ set tuse= ^ set tfre=
echo Drive VolumeLabel   Disk:  Total           Used           Free       CurrentDir
:poopLoop
set driv=%@lower[%@left[1,%@line[c:\tmptmp07.tmp,%line]]]
set ttot=%@eval[%ttot+%@disktotal[%driv:,%size]]
set tuse=%@eval[%tuse+%@diskused[%driv:,%size]]
set tfre=%@eval[%tfre+%@diskfree[%driv:,%size]]
if %@cdrom[%driv:] != 1 echos hd %driv: %@format[-11,%@label[%driv:]] %@format[14,%@disktotal[%driv:,%size%c]] %@format[14,%@diskused[%driv:,%size%c]] %@format[14,%@diskfree[%driv:,%size%c]]
if %@cdrom[%driv:] == 1 echos cd %driv: %@format[-11,%@label[%driv:]] %@format[14,%@disktotal[%driv:,%size%c]] %@format[14,%@diskused[%driv:,%size%c]] %@format[14,%@diskfree[%driv:,%size%c]]
%driv: ^ echo  %@format[16.16,%_cwp]
set line=%@inc[%line]
if %line LE %linz goto poopLoop
echos TOTALS:
echos           %@format[15,%@comma[%ttot]]
echos %@format[15,%@comma[%tuse]]
echo %@format[15,%@comma[%tfre]]
del /e /q c:\tmptmp07.tmp
set ttot= ^ set tuse= ^ set tfre= ^ set size=
set temp_val= ^ set line= ^ set linz= ^ set driv=
popd
