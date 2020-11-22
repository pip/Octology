@ECHO OFF
cd %2
if errorlevel 0 goto overorquit
goto continue

:overorquit
choice /c:O,Q /t:O,10 /n (O)verwrite or (Q)uit?
if errorlevel 255 goto overorquit
if errorlevel 2   goto end
cd..
deltree %2    
goto continue

end:
echo Copy Directory Aborted!

:continue
md %2 
cd %1 
xcopy /e *.* %2
cd..


