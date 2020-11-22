@echo off
iff "%1" == "-h" .or. "%1" == "/h" .or. "%1" == "/?" .or. "%1" == "help" then
  echo 42QH9Dq - jing.bat created by Pip Stuart "Pip@CPAN.Org" to
  echo   execute the Java Runtime environment on jing to validate
  echo   instance documents with a RELAX NG XML Schema.
  echo.
  echo syntax: jing.bat SchemaDef.rng InstanceDoc.xml
  echo.
  echo Only error messages will be printed.  Nothing is printed
  echo   if InstanceDoc is valid.
else
  if "%1" != "" set jingcmdl=%$
  java -jar c:\Pip\dvl\jobz\DigitalEclipse\XML_apps\jing-20030619\bin\jing.jar %jingcmdl%
endiff
