@echo off
  set ver=1.1
  set strt=345
rem 1.1 now writes both Win9x and NT codes in each pal file
  set linx=&set bgin=&set junk=&set cpbt=&set loop=&set dsk=&set pakp=&set ky=
  set rval=&set gval=&set bval=&set tc=&set svit=&set savf=&set t=
  set pat=%@path[%@search[%0]]
  if "%1" == "p" goto pickWhichPal
  iff "%1" == "?" then
    echo Beppu's and Tigger's interactive PALette configurator help screen:
    echo.
    echo Purpose:   To create and modify personalized palettes for 4DOS
    echo.
    echo Format:    BaTpal.bat [l or p or ?] [autoSaveFile]
    echo    autoSaveFile:   a palette file which is automatically saved to when you
    echo                    exit BaTpal
    echo.
    echo Command Line Parameters:  p    puts BaTpal into pick mode
    echo                           l    loop values when they reach limits
    echo                           ?    displays this help screen
    echo Program Controls:
    echo  up&down arrows       change which color is to be changed
    echo  r, g, & b            make red, green, or blue the current changable component
    echo  left&right arrows    change the current r,g, or b value
    echo  l & s                reload initial values & save current palette
    echo  Esc, q, x, or Alt-x  exit BaTpal
    echo Please read BaTpal.txt for more detailed help and information.  Shalom.
    goto notWhich
  endiff
  if "%1" == "l" .or. "%2" == "l" set loop=1
  iff "%1" == "" .or. "%1" == "l" then & set savf= &
  else & set savf=%1 & set svit=1 &
  endiff
  iff "%2" != "" .and. "%1" == "l" then & set savf=%2 & set svit=1 & endiff
  iff %_env lt 192 then &
    echo Free up some environment memory or allocate about 192 bytes more please &
    echo I'll give it back...I promise...trust me... =) & Pause &
  else & set dsk=0 &
  endiff
  getpal > %pat\tmptmp10.tmp
  gosub LoadOrig:
  set rgb=r
  set cndx=00
  cls
  echo.
  echo [1;37m             Beppu's And Tigger's interactive PALette configurator
  echo.
  echo  [1;37m0[0;30m ∞±≤€€€€€€€€€≤±∞  [1;37m1[0;34m ∞±≤€€€€€€€€€≤±∞  [1;37m2[0;32m ∞±≤€€€€€€€€€≤±∞  [1;37m3[0;36m ∞±≤€€€€€€€€€≤±∞
  echo [0;30m   ∞±≤€€€€€€€€€≤±∞ [0;34m   ∞±≤€€€€€€€€€≤±∞ [0;32m   ∞±≤€€€€€€€€€≤±∞ [0;36m   ∞±≤€€€€€€€€€≤±∞
  echo [0;30m   ∞±≤€€€€€€€€€≤±∞ [0;34m   ∞±≤€€€€€€€€€≤±∞ [0;32m   ∞±≤€€€€€€€€€≤±∞ [0;36m   ∞±≤€€€€€€€€€≤±∞
  echo [0;30m   ∞±≤€€€€€€€€€≤±∞ [0;34m   ∞±≤€€€€€€€€€≤±∞ [0;32m   ∞±≤€€€€€€€€€≤±∞ [0;36m   ∞±≤€€€€€€€€€≤±∞
  echo  [1;37m4[0;31m ∞±≤€€€€€€€€€≤±∞  [1;37m5[0;35m ∞±≤€€€€€€€€€≤±∞  [1;37m6[0;33m ∞±≤€€€€€€€€€≤±∞  [1;37m7[0;37m ∞±≤€€€€€€€€€≤±∞
  echo [0;31m   ∞±≤€€€€€€€€€≤±∞ [0;35m   ∞±≤€€€€€€€€€≤±∞ [0;33m   ∞±≤€€€€€€€€€≤±∞ [0;37m   ∞±≤€€€€€€€€€≤±∞
  echo [0;31m   ∞±≤€€€€€€€€€≤±∞ [0;35m   ∞±≤€€€€€€€€€≤±∞ [0;33m   ∞±≤€€€€€€€€€≤±∞ [0;37m   ∞±≤€€€€€€€€€≤±∞
  echo [0;31m   ∞±≤€€€€€€€€€≤±∞ [0;35m   ∞±≤€€€€€€€€€≤±∞ [0;33m   ∞±≤€€€€€€€€€≤±∞ [0;37m   ∞±≤€€€€€€€€€≤±∞
  echo  [1;37m8[1;30m ∞±≤€€€€€€€€€≤±∞  [1;37m9[1;34m ∞±≤€€€€€€€€€≤±∞  [1;37mA[1;32m ∞±≤€€€€€€€€€≤±∞  [1;37mB[1;36m ∞±≤€€€€€€€€€≤±∞
  echo [1;30m   ∞±≤€€€€€€€€€≤±∞ [1;34m   ∞±≤€€€€€€€€€≤±∞ [1;32m   ∞±≤€€€€€€€€€≤±∞ [1;36m   ∞±≤€€€€€€€€€≤±∞
  echo [1;30m   ∞±≤€€€€€€€€€≤±∞ [1;34m   ∞±≤€€€€€€€€€≤±∞ [1;32m   ∞±≤€€€€€€€€€≤±∞ [1;36m   ∞±≤€€€€€€€€€≤±∞
  echo [1;30m   ∞±≤€€€€€€€€€≤±∞ [1;34m   ∞±≤€€€€€€€€€≤±∞ [1;32m   ∞±≤€€€€€€€€€≤±∞ [1;36m   ∞±≤€€€€€€€€€≤±∞
  echo  [1;37mC[1;31m ∞±≤€€€€€€€€€≤±∞  [1;37mD[1;35m ∞±≤€€€€€€€€€≤±∞  [1;37mE[1;33m ∞±≤€€€€€€€€€≤±∞  [1;37mF[1;37m ∞±≤€€€€€€€€€≤±∞
  echo [1;31m   ∞±≤€€€€€€€€€≤±∞ [1;35m   ∞±≤€€€€€€€€€≤±∞ [1;33m   ∞±≤€€€€€€€€€≤±∞ [1;37m   ∞±≤€€€€€€€€€≤±∞
  echo [1;31m   ∞±≤€€€€€€€€€≤±∞ [1;35m   ∞±≤€€€€€€€€€≤±∞ [1;33m   ∞±≤€€€€€€€€€≤±∞ [1;37m   ∞±≤€€€€€€€€€≤±∞
  echo [1;31m   ∞±≤€€€€€€€€€≤±∞ [1;35m   ∞±≤€€€€€€€€€≤±∞ [1;33m   ∞±≤€€€€€€€€€≤±∞ [1;37m   ∞±≤€€€€€€€€€≤±∞
  echo    Color Index:       Up/Down Arrows                 S = save this color scheme
  echo    R,G, or B:         r,g, or b                      L = reload original colors
  echo    Red Value:         \                              Esc     \
  echo"   Green Value:        > Left/Right Arrows           q or x   >   = Exit
  echo    Blue Value:        /                              Alt-x   /
:loopie
  if not defined dsk getpal > %pat\tmptmp11.tmp
  set tc=%cndx
  set t=%@convert[16,10,%tc]
  if "%t" == "20" set t=6
  if %t gt 20 set t=%@eval[%t-48]
  set tc=%@convert[10,16,%t]
  iff not defined dsk then & set ky=%@line[%pat\tmptmp11.tmp,%t] &
  else & set ky=JC%@substr[%pakp,%@eval[%t*6],6] &
  endiff
  set rval=%@substr[%ky,2,2]
  set gval=%@substr[%ky,4,2]
  set bval=%@substr[%ky,6,2]
  scrput 19 16 bri whi on bla ˇ%tc
  scrput 20 16 bri whi on bla ˇ%@upper[%rgb]
  scrput 21 16 bri whi on bla %rval
  scrput 22 16 bri whi on bla %gval
  scrput 23 16 bri whi on bla %bval
  inkey /X /P %%ky
  switch %ky
  case x .or. q .or. @45 .or. %@char[27]
    goto customdone:
  case @75 .or. @77
    gosub rgbMove:
  case @72 .or. @80
    gosub cndxMove:
  case s
    gosub Save:
  case l
    gosub LoadOrig:
  case r .or. g .or. b
    set rgb=%ky
  endswitch
goto loopie:

:rgbMove
  set t=%[%rgb%val]
  iff %ky == @75 then & set t=%@dec[%@convert[16,10,%t]] &
    iff "%t" == "-1" then &
      iff defined loop then & set t=63 &
      else & set t=00 &
      endiff &
    endiff &
    set t=%@lower[%@convert[10,16,%t]] &
  else & set t=%@lower[%@convert[10,16,%@inc[%@convert[16,10,%t]]]] &
    iff "%t" == "40" then &
      iff defined loop then & set t=00 &
      else & set t=3f &
      endiff &
    endiff &
  endiff
  if %@len[%t] == 1 set t=0%t
  set %rgb%val=%t
  setpal %cndx%%rval%%gval%%bval%
  set tc=%cndx
  set t=%@convert[16,10,%tc]
  if "%t" == "20" set t=6
  if %t gt 20 set t=%@eval[%t-48]
  if defined dsk set pakp=%@substr[%pakp,0,%@eval[%t*6]]%rval%%gval%%bval%%@substr[%pakp,%@eval[(%t+1)*6],%@eval[90-(%t*6)]]
return

:cndxMove
  set t=%cndx
  iff %ky == @80 then & set t=%@dec[%@convert[16,10,%t]] &
    iff "%t" == "-1" then &
      iff defined loop then & set t=63 &
      else & set t=00 ^
      endiff &
    endiff &
    set t=%@lower[%@convert[10,16,%t]] &
  else & set t=%@lower[%@convert[10,16,%@inc[%@convert[16,10,%t]]]] &
    iff "%t" == "40" then &
      iff defined loop then & set t=00 &
      else & set t=3f &
      endiff &
    endiff &
  endiff
  if %@len[%t] == 1 set t=0%t
  if "%t" == "06" set t=14
  if "%t" == "13" set t=05
  if "%t" == "15" set t=07
  if "%t" == "08" set t=38
  if "%t" == "37" set t=07
  set cndx=%t
return

:Save
 :silly
  if defined savf .and. exist %pat\%savf set savf=%@name[%savf]
  input /E /X /L12 Please enter a name for your palette file: %%savf
  if "%@ext[%savf]" != "bat" set savf=%@name[%savf]
  if "%@name[%savf]" == "%savf" set savf=%savf%.bat
  iff "%@name[%0]" == "%@name[%savf]" then &
    screen 24 0 ˇ                                                                          ˇ &
    screen 24 0 *** ERROR *** Tried to replace BaTpal with palette.  Press a key to reinput  &
    inkey /X %%t &
    screen 24 0 ˇ                                                                          ˇ &
    screen 24 0 &
    goto silly: &
  endiff
  if exist %savf del /q %savf
  if not defined dsk echo rem BaTpal batch palette generator v%ver >> %savf
  iff not defined dsk then & for /f %ky in (%pat\tmptmp11.tmp) do echo setpal %ky >> %savf &
  else
    echo rem BaTpal batch palette generator v%ver >> %savf
    echo setpal 00%@substr[%pakp,0,6] >> %savf
    echo setpal 01%@substr[%pakp,6,6] >> %savf
    echo setpal 02%@substr[%pakp,12,6] >> %savf
    echo setpal 03%@substr[%pakp,18,6] >> %savf
    echo setpal 04%@substr[%pakp,24,6] >> %savf
    echo setpal 05%@substr[%pakp,30,6] >> %savf
    echo setpal 06%@substr[%pakp,36,6] >> %savf
    echo setpal 14%@substr[%pakp,36,6] >> %savf
    echo setpal 07%@substr[%pakp,42,6] >> %savf
    echo setpal 08%@substr[%pakp,48,6] >> %savf
    echo setpal 38%@substr[%pakp,48,6] >> %savf
    echo setpal 09%@substr[%pakp,54,6] >> %savf
    echo setpal 39%@substr[%pakp,54,6] >> %savf
    echo setpal 0a%@substr[%pakp,60,6] >> %savf
    echo setpal 3a%@substr[%pakp,60,6] >> %savf
    echo setpal 0b%@substr[%pakp,66,6] >> %savf
    echo setpal 3b%@substr[%pakp,66,6] >> %savf
    echo setpal 0c%@substr[%pakp,72,6] >> %savf
    echo setpal 3c%@substr[%pakp,72,6] >> %savf
    echo setpal 0d%@substr[%pakp,78,6] >> %savf
    echo setpal 3d%@substr[%pakp,78,6] >> %savf
    echo setpal 0e%@substr[%pakp,84,6] >> %savf
    echo setpal 3e%@substr[%pakp,84,6] >> %savf
    echo setpal 0f%@substr[%pakp,90,6] >> %savf
    echo setpal 3f%@substr[%pakp,90,6] >> %savf
  endiff
  screen 24 0 ˇ                                                                         ˇ
REM above is different from below because it has Alt-255s to force a blank line
  screen 24 0
  gosub storPal
return

:loadOrig
  set pakp=
  for /f %ky in (%pat\tmptmp10.tmp) do (set pakp=%pakp%%@substr[%ky,2,6] & setpal %ky)
return

:storPal
    setdos /x-4
    set linx=%strt
    copy %_batchname batcopy.pal /q
    set cpbt=%@fileopen[batcopy.pal,read,t]
    set junk=%@fileseekl[%cpbt,%linx]
:storlineloopie
    if "%@fileread[%cpbt]" == "*******FindMe*******" goto storfoundit
    set linx=%@inc[%linx]
    goto storlineloopie
:storfoundit
    set bgin=%linx
    set linx=0
:storpalsloopie
    if %@eval[%bgin+%linx] == %@lines[batcopy.pal] goto okayToStor
    if "%savf" == "%@fileread[%cpbt]" goto alreadyStord
    set linx=%@inc[%linx]
    goto storpalsloopie
:okayToStor
    echo %savf >> batcopy.pal
    copy batcopy.pal %_batchname /q
:alreadyStord
    set junk=%@fileclose[%cpbt]
    setdos /x0
    del batcopy.pal /q
return

:customdone
REM automatically save on exit to savf
  iff defined svit then &
    if "%@name[%savf]" == "%savf" set savf=%savf%.bat &
    iff "%@name[%0]" == "%@name[%savf]" then &
      screen 24 0 ˇ                                                                          ˇ &
      screen 24 0 *** ERROR *** Tried to replace BaTpal with palette.  Press a key to reinput  &
      inkey /X %%t &
      screen 24 0 ˇ                                                                          ˇ &
      screen 24 0 &
      gosub Save &
    else
      if exist %savf del /q %savf &
      iff not defined dsk then & for /f %ky in (%pat\tmptmp11.tmp) do echo setpal %ky >> %savf &
      else &
        echo rem BaTpal batch palette generator v%ver >> %savf
        echo setpal 00%@substr[%pakp,0,6] >> %savf &
        echo setpal 01%@substr[%pakp,6,6] >> %savf &
        echo setpal 02%@substr[%pakp,12,6] >> %savf &
        echo setpal 03%@substr[%pakp,18,6] >> %savf &
        echo setpal 04%@substr[%pakp,24,6] >> %savf &
        echo setpal 05%@substr[%pakp,30,6] >> %savf &
        echo setpal 06%@substr[%pakp,36,6] >> %savf &
        echo setpal 14%@substr[%pakp,36,6] >> %savf &
        echo setpal 07%@substr[%pakp,42,6] >> %savf &
        echo setpal 08%@substr[%pakp,48,6] >> %savf &
        echo setpal 38%@substr[%pakp,48,6] >> %savf &
        echo setpal 09%@substr[%pakp,54,6] >> %savf &
        echo setpal 39%@substr[%pakp,54,6] >> %savf &
        echo setpal 0a%@substr[%pakp,60,6] >> %savf &
        echo setpal 3a%@substr[%pakp,60,6] >> %savf &
        echo setpal 0b%@substr[%pakp,66,6] >> %savf &
        echo setpal 3b%@substr[%pakp,66,6] >> %savf &
        echo setpal 0c%@substr[%pakp,72,6] >> %savf &
        echo setpal 3c%@substr[%pakp,72,6] >> %savf &
        echo setpal 0d%@substr[%pakp,78,6] >> %savf &
        echo setpal 3d%@substr[%pakp,78,6] >> %savf &
        echo setpal 0e%@substr[%pakp,84,6] >> %savf &
        echo setpal 3e%@substr[%pakp,84,6] >> %savf &
        echo setpal 0f%@substr[%pakp,90,6] >> %savf &
        echo setpal 3f%@substr[%pakp,90,6] >> %savf &
      endiff &
    endiff &
    gosub storPal
  endiff
  del /q %pat\tmptmp10.tmp
  if not defined dsk del /q %pat\tmptmp11.tmp
:pickWhichPal
  if defined rgb goto notWhich
    pushd %@path[%_batchname]
    setdos /x-4
    copy %_batchname batcopy.pal /q
    set tc=%@fileopen[batcopy.pal,read,t]
    cls
    set cndx=%strt
    set rgb=%@fileseekl[%tc,%cndx]
:lineloopie
    if "%@fileread[%tc]" == "*******FindMe*******" goto foundit
    set cndx=%@inc[%cndx]
    goto lineloopie
:foundit
    set rgb=%cndx
:again
    set cndx=%rgb
    set cndx=%@inc[%cndx]
    set cndx=%@fileseekl[%tc,%cndx]
    screen 0 0
    set cndx=0
:palsloopie
    if %@eval[%cndx+%rgb] == %@lines[batcopy.pal] .or. "%junk" == "**EOF**" goto doneWithPals
    if %@len[%@eval[%cndx/4]] == 1 echo.
    set junk=%@fileread[%tc]
    set cndx=%@inc[%cndx]
    if not exist %junk echos %@format[-18,%cndx) **ERROR**]ˇ
    if not exist %junk goto noFile
    if "%@left[10,%@line[%junk,0]]" == "rem BaTpal" echos %@format[-18,%cndx) %junk]ˇ
    if "%@left[10,%@line[%junk,0]]" != "rem BaTpal" echos %@format[-18,%cndx) **ERROR**]ˇ
:noFile
    goto palsloopie
:doneWithPals
    set svit=%cndx
    screen 6 0
    echos                                                                               ˇ
    screen 6 0
    if %cndx LT 10 inkey /d /x Press the number of the palette you wish to invoke (0=Quit): %%cndx
    if %cndx GE 10 input /d /l2 /x Enter the number of the palette you would like to display (0=Quit): %%cndx
    if %cndx GT %svit set cndx=%svit
    screen 7 0
    echo  [1;37m0[0;30m ∞±≤€€€€€€€€€≤±∞  [1;37m1[0;34m ∞±≤€€€€€€€€€≤±∞  [1;37m2[0;32m ∞±≤€€€€€€€€€≤±∞  [1;37m3[0;36m ∞±≤€€€€€€€€€≤±∞
    echo [0;30m   ∞±≤€€€€€€€€€≤±∞ [0;34m   ∞±≤€€€€€€€€€≤±∞ [0;32m   ∞±≤€€€€€€€€€≤±∞ [0;36m   ∞±≤€€€€€€€€€≤±∞
    echo [0;30m   ∞±≤€€€€€€€€€≤±∞ [0;34m   ∞±≤€€€€€€€€€≤±∞ [0;32m   ∞±≤€€€€€€€€€≤±∞ [0;36m   ∞±≤€€€€€€€€€≤±∞
    echo [0;30m   ∞±≤€€€€€€€€€≤±∞ [0;34m   ∞±≤€€€€€€€€€≤±∞ [0;32m   ∞±≤€€€€€€€€€≤±∞ [0;36m   ∞±≤€€€€€€€€€≤±∞
    echo  [1;37m4[0;31m ∞±≤€€€€€€€€€≤±∞  [1;37m5[0;35m ∞±≤€€€€€€€€€≤±∞  [1;37m6[0;33m ∞±≤€€€€€€€€€≤±∞  [1;37m7[0;37m ∞±≤€€€€€€€€€≤±∞
    echo [0;31m   ∞±≤€€€€€€€€€≤±∞ [0;35m   ∞±≤€€€€€€€€€≤±∞ [0;33m   ∞±≤€€€€€€€€€≤±∞ [0;37m   ∞±≤€€€€€€€€€≤±∞
    echo [0;31m   ∞±≤€€€€€€€€€≤±∞ [0;35m   ∞±≤€€€€€€€€€≤±∞ [0;33m   ∞±≤€€€€€€€€€≤±∞ [0;37m   ∞±≤€€€€€€€€€≤±∞
    echo [0;31m   ∞±≤€€€€€€€€€≤±∞ [0;35m   ∞±≤€€€€€€€€€≤±∞ [0;33m   ∞±≤€€€€€€€€€≤±∞ [0;37m   ∞±≤€€€€€€€€€≤±∞
    echo  [1;37m8[1;30m ∞±≤€€€€€€€€€≤±∞  [1;37m9[1;34m ∞±≤€€€€€€€€€≤±∞  [1;37mA[1;32m ∞±≤€€€€€€€€€≤±∞  [1;37mB[1;36m ∞±≤€€€€€€€€€≤±∞
    echo [1;30m   ∞±≤€€€€€€€€€≤±∞ [1;34m   ∞±≤€€€€€€€€€≤±∞ [1;32m   ∞±≤€€€€€€€€€≤±∞ [1;36m   ∞±≤€€€€€€€€€≤±∞
    echo [1;30m   ∞±≤€€€€€€€€€≤±∞ [1;34m   ∞±≤€€€€€€€€€≤±∞ [1;32m   ∞±≤€€€€€€€€€≤±∞ [1;36m   ∞±≤€€€€€€€€€≤±∞
    echo [1;30m   ∞±≤€€€€€€€€€≤±∞ [1;34m   ∞±≤€€€€€€€€€≤±∞ [1;32m   ∞±≤€€€€€€€€€≤±∞ [1;36m   ∞±≤€€€€€€€€€≤±∞
    echo  [1;37mC[1;31m ∞±≤€€€€€€€€€≤±∞  [1;37mD[1;35m ∞±≤€€€€€€€€€≤±∞  [1;37mE[1;33m ∞±≤€€€€€€€€€≤±∞  [1;37mF[1;37m ∞±≤€€€€€€€€€≤±∞
    echo [1;31m   ∞±≤€€€€€€€€€≤±∞ [1;35m   ∞±≤€€€€€€€€€≤±∞ [1;33m   ∞±≤€€€€€€€€€≤±∞ [1;37m   ∞±≤€€€€€€€€€≤±∞
    echo [1;31m   ∞±≤€€€€€€€€€≤±∞ [1;35m   ∞±≤€€€€€€€€€≤±∞ [1;33m   ∞±≤€€€€€€€€€≤±∞ [1;37m   ∞±≤€€€€€€€€€≤±∞
    echo [1;31m   ∞±≤€€€€€€€€€≤±∞ [1;35m   ∞±≤€€€€€€€€€≤±∞ [1;33m   ∞±≤€€€€€€€€€≤±∞ [1;37m   ∞±≤€€€€€€€€€≤±∞
    if "%cndx" == "" .or. "%cndx" == "0" goto finishPick
    set t=%@fileseekl[%tc,%@eval[%rgb+%cndx]]
    set t=%@fileread[%tc]
    screen 23 0
    echos                                                                               ˇ
    screen 23 0
    if not exist %t echos [0;37m**ERROR** %t![1;37m **ERROR** %t not found!
    if not exist %t goto again
    if "%@left[10,%@line[%t,0]]" == "rem BaTpal" call %t
    if "%@left[10,%@line[%t,0]]" == "rem BaTpal" echos [1;37m%@format[-85,Beppu's And Tigger's PALette %t[0;37m-I hope you can still see this text =)]ˇ
    if "%@left[10,%@line[%t,0]]" != "rem BaTpal" echos [0;37m**ERROR** %t![1;37m **ERROR** %t not found!
    goto again
:finishPick
    set t=%@fileclose[%tc]
    setdos /x0
    del batcopy.pal /q
    popd
:notWhich
  set ver=&set strt=&set linx=&set bgin=&set junk=&set cpbt=&set loop=&set dsk=
  set pat=&set pakp=&set ky=&set cndx=&set rgb=&set rval=&set gval=&set bval=
  set tc=&set savf=&set svit=&set t=
:end
quit
*******FindMe*******
TigsFavs.bat
BepsPurp.bat
Yel.bat
Silly.bat
Goofy.bat
Nice.bat
Blues.bat
Flipped.bat
Darkz.bat
