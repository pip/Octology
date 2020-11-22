@echo off
iff "%1" == "-h" .or. "%1" == "/h" .or. "%1" == "/?" .or. "%1" == "help" then
  echo 435Dffj - trang.bat created by Pip Stuart "Pip@CPAN.Org" to
  echo   execute the Java Runtime environment on trang to convert
  echo   RELAX NG XML Schemas into DTDs or W3C XML Schemas.
  echo.
  echo syntax: trang.bat SchemaDef.rng SchemaDef.dtd
  echo.
  echo Only error messages will be printed.  Nothing is printed
  echo   if conversion succeeded.
else
  if "%1" != "" set trngcmdl=%$
  java -jar c:\Pip\dvl\jobz\DigitalEclipse\XML_apps\trang-20030619\trang.jar %trngcmdl%
endiff
