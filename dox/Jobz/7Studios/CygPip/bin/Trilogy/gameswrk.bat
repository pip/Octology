@echo off
echo.
echo Tigger's Game Menu Batch File
echo.

:ogjump
d:
cd \games
echo [D]oom II
echo D[E]scent
echo [H]eretic
echo [R]ise Of The Triad
echo Mortal Kombat [2]
echo [S]tunts
echo [I]ndy Car Racing
echo [T]ie Fighter
echo [A]ces Over Europe
echo Si[M] City 2000
echo Ra[P]tor
echo [L]emmings
echo S[U]per Tetris
echo Ar[C]hon Ultra
echo Pinball [F]antasy
echo Epic Pin[B]all
echo.
choice /c:dehr2sitamplucfbq /n /t:d,30 "Which game do you want to play? (Q=quit) "
if errorlevel == 255 goto end
if errorlevel == 17 goto end
if errorlevel == 16 goto epicpb
if errorlevel == 15 goto pbfantas
if errorlevel == 14 goto archon
if errorlevel == 13 goto tetris
if errorlevel == 12 goto lemmings
if errorlevel == 11 goto raptor
if errorlevel == 10 goto sc2000
if errorlevel == 9 goto aces
if errorlevel == 8 goto tie
if errorlevel == 7 goto indy
if errorlevel == 6 goto stunts
if errorlevel == 5 goto mortal
if errorlevel == 4 goto rott
if errorlevel == 3 goto heretic
if errorlevel == 2 goto descent
if errorlevel == 1 goto doom2


:epicpb
cd epicpb
pinball.exe
goto othergame

:pbfantas
cd pbfantas
pinball.exe
goto othergame

:archon
cd archon
archon.exe
goto othergame

:tetris
cd tetris
st.exe
goto othergame

:lemmings
cd lemmings
vgalemmi.exe
goto othergame

:raptor
cd raptor
rap.exe
goto othergame

:sc2000
cd sc2000
sc2000.exe
goto othergame

:aces
cd aces
aces.bat
goto othergame

:tie
cd tie
tie.exe
goto othergame

:indy
cd indy
indycar.exe
goto othergame

:stunts
cd stunts
st.com
goto othergame

:mortal
cd mk2
mk2gus.bat
goto othergame

:rott
cd rott
rott.exe
goto othergame

:heretic
cd heretic
heretic.exe
goto othergame

:descent
cd descent
descent.bat
goto othergame

:doom2
cd doom2
doom2.exe
goto othergame

:othergame
c:\batch\tektite.com
choice /t:n,10 "Do you want to play another game? "
if errorlevel == 2 goto end
if errorlevel == 1 goto ogjump

:end
