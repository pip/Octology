@ECHO OFF
IF "%1" == "love" GOTO puterlove
IF "%1" == "LOVE" GOTO puterlove
IF "%1" == "Love" GOTO puterlove
IF "%1" == "s3m" GOTO s3m
IF "%1" == "mod" GOTO mod
IF "%1" == "mtm" GOTO mtm
IF "%1" == "stm" GOTO stm
IF "%1" == "669" GOTO 669
IF "%1" == "all" GOTO all
c:\pip\muz\trackers\it.exe s7 %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO done
:s3m
c:\pip\muz\trackers\it.exe s7 c:\music\s3m\*.s3m
GOTO done
:mod
c:\pip\muz\trackers\it.exe s7 c:\music\mod\*.mod
GOTO done
:mtm
c:\pip\muz\trackers\it.exe s7 c:\music\mtm\*.mtm
GOTO done
:stm
c:\pip\muz\trackers\it.exe s7 c:\music\stm\*.stm
GOTO done
:669
c:\pip\muz\trackers\it.exe s7 c:\music\669\*.669
GOTO done
:all
c:\pip\muz\trackers\it.exe s7 c:\music\s3m\*.s3m
c:\pip\muz\trackers\it.exe s7 c:\music\mod\*.mod
c:\pip\muz\trackers\it.exe s7 c:\music\mtm\*.mtm
c:\pip\muz\trackers\it.exe s7 c:\music\stm\*.stm
c:\pip\muz\trackers\it.exe s7 c:\music\669\*.669
GOTO done
:puterlove
IF "%2" == "you" GOTO iloveyou
IF "%2" == "YOU" GOTO iloveyou
IF "%2" == "You" GOTO iloveyou
GOTO done
:iloveyou
cls
echo\
echo I LOVE YOU TOO!!!
:done
