g:\
md school
cd school
md ics80
cd ics80
set PATH=G:\BIN;%PATH%
set TMPDIR=g:/tmp
xcopy c:\school\ics80\*.* g:\school\ics80 /e
call c:\batch\uz.bat f:\djgpp\cppstuff.zip g:\
