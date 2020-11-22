if not "%1" == "" set cppfile=%1
if exist %cppfile% copy %cppfile% c:\bkupfile.txt
if exist %cppfile% gxx %cppfile%
