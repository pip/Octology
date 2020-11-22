@echo off
goto nokaka
history > c:\tmptmp00.tmp
iff "%@lines[c:\tmptmp00.tmp]" LE "2" .or. "%@line[c:\tmptmp00.tmp,%@dec[%@lines[c:\tmptmp00.tmp]]]" == "x" then
   if exist c:\TigsSets.bat call c:\TigsSets.bat
   if exist c:\TigsHist.dat history /r c:\TigsHist.dat
endiff
:nokaka
::getpal > c:\tmptmp00.tmp
::if %@line[c:\tmptmp00.tmp,0] == 0 call TigsFavs
::del c:\tmptmp00.tmp /q
::getpal > c:\tmptmp01.tmp
if "%1" == "n" goto nocls
if "%2" == "n" goto nocls
mode co80
mode con cols=80 lines=25
:nocls
set f1=%1
if "%1" == "n" .and. "%2" != "" set f1=%2
med.com
::TgHebrew.com
call TigsFavs.bat
if "%f1" == "m" med.com
if "%f1" == "m" call decent.bat
if "%f1" == "t" tektite.com
if "%f1" == "t" call goofy.bat
if "%f1" == "tl" tallgood.com
if "%f1" == "tl" call yel.bat
if "%f1" == "r" roman3.com
if "%f1" == "h" call BepsPurp.bat
if "%f1" == "b" blood.com
if "%f1" == "s" scrawl.com
if "%f1" == "c" cal.com
if "%f1" == "c" call silly.bat
if "%f1" == "h" TgHebrew.com
if "%f1" == "hp" hp48font.com
if "%f1" == "g" .or. "%f1" == "f" mode con lines=50
if "%f1" == "g" good50.com
if "%f1" == "f" fats50.com
if "%f1" == "6" tigs66.com
if "%f1" == "j" bg.com
if "%f1" == "l" long.com
if "%f1" == "l" call nice.bat
if "%f1" == "?" goto helpstuffs
if "%f1" == "/?" goto helpstuffs
if "%f1" == "-?" goto helpstuffs
set f1=
goto end
:helpstuffs
echo.
echo "x" = 'newfont.com'
echo m = med.com
echo t = tektite.com
echo tl= tallgood.com
echo r = roman3.com
echo b = blood.com
echo s = scrawl.com
echo c = calligra.com
echo h = TgHebrew.com
echo hp= hp48font.com
echo g = good50.com
echo f = fats50.com
echo 6 = Tigs66.com
echo j = bg.com - courtesy equ Beppu's small font...thanx John!
echo l = long.com
echo+n = do not clear the screen before changing the font
:end
::for /f %x in (c:\tmptmp01.tmp) do (setpal %x)
::del c:\tmptmp01.tmp /q
