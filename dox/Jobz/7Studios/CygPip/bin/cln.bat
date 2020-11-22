if "%_cmdproc" == "4NT" goto ntstuff
echo No 4NT so trying:`perl cln %1*`...
perl cln %1*
goto end
:ntstuff
echo %1*=%@comma[%@eval[%1*]]
:end
