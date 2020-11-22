pushd c:\
attrib -rs boot.ini
attrib -h tempboot.ini
copy boot.ini tempboot.ini
call e.bat c:\tempboot.ini
copy tempboot.ini boot.ini
attrib +rs boot.ini
attrib +h tempboot.ini
del tempboot.bak
popd
