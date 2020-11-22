@echo off
if             "%1" == "e"   set  DirParmz= *.exe
if             "%1" == "E"   set  DirParmz= *.exe
if             "%1" == "b"   set  DirParmz= *.bat
if             "%1" == "B"   set  DirParmz= *.bat
if             "%1" == "c"   set  DirParmz= *.com
if             "%1" == "C"   set  DirParmz= *.com
if             "%1" == "t"   set  DirParmz= *.txt
if             "%1" == "T"   set  DirParmz= *.txt
if             "%1" == "d"   set  DirParmz= *.doc
if             "%1" == "D"   set  DirParmz= *.doc
if             "%1" == "z"   set  DirParmz= *.zip
if             "%1" == "Z"   set  DirParmz= *.zip
if             "%1" == "dog" set  DirParmz= /ogd
if not "%DirParmz%" == ""    dir %DirParmz% %2 %3 %4 %5 %6 %7 %8 %9
if     "%DirParmz%" == ""    dir         %1 %2 %3 %4 %5 %6 %7 %8 %9
                             set  DirParmz=
