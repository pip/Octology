if "%1" == "" .and. "%lastcmmd" != "" cm.bat %lastcmmd
if "%1" == "" quit
set lastcmmd=%1&
if "%1" == "l" dir \docume~1\pip~1.big\mydocu~1\maya\3.0\scripts
if "%1" == "l" quit
if "%1" == "r" del \docume~1\pip~1.big\mydocu~1\maya\3.0\scripts\%2
if "%1" == "r" quit
if "%1" == "u" copy %2 p:\mayapl~1\
if "%1" == "u" quit
if "%2" == "u" copy %1 p:\mayapl~1\

copy %1 \docume~1\pip~1.big\mydocu~1\maya\3.0\scripts
