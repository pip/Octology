if "%_cmdproc" == "4NT" goto ntstuff
if "%1" == "n" echo %2&=%@comma[%@eval[%2&]]
if "%1" == "b" f -f c:\4dos\figlet\fonts\big.flf %2&=%@comma[%@eval[%2&]]
if "%1" == "g" f -f c:\4dos\figlet\fonts\gothic.flf %2&=%@comma[%@eval[%2&]]
if "%1" == "r" f -f c:\4dos\figlet\fonts\roman.flf %2&=%@comma[%@eval[%2&]]
if "%1" != "b" .and. "%1" != "g" .and. "%1" != "r" echo %1&=%@comma[%@eval[%1&]]
goto end
:ntstuff
if "%1" == "n" echo %2$=%@comma[%@eval[%2$]]
if "%1" == "b" f -f c:\4dos\figlet\fonts\big.flf %2$=%@comma[%@eval[%2$]]
if "%1" == "g" f -f c:\4dos\figlet\fonts\gothic.flf %2$=%@comma[%@eval[%2$]]
if "%1" == "r" f -f c:\4dos\figlet\fonts\roman.flf %2$=%@comma[%@eval[%2$]]
if "%1" != "b" .and. "%1" != "g" .and. "%1" != "r" echo %1$=%@comma[%@eval[%1$]]
:end
