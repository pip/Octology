g:\
md school
cd school
md ics141
cd ics141
set PATH=G:\BIN;%PATH%
set TMPDIR=g:/tmp
set ADA_INCLUDE_PATH=g:/adainc
set ADA_OBJECTS_PATH=g:/adalib
xcopy c:\school\ics141\*.* g:\school\ics141 /e
call c:\batch\uz.bat f:\djgpp\adastuff.zip g:\
