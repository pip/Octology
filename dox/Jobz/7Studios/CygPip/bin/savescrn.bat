set tm=%_time
set dt=%_date
set fl=%@instr[0,2,%dt]%%@instr[3,2,%dt]%%@instr[0,2,%tm]%%@instr[3,2,%tm]%.scr
iff "%@readscr[0,0,80]" != "                                                                                " then ^
  @echo %@readscr[0,0,80] > c:\temp\%fl ^
else ^
  @echo. > c:\temp\%fl ^
endiff
@for /l %x in (1,1,22) do (
    iff not "%@readscr[%x,0,80]" == "                                                                                " then ^
        @echo %@readscr[%x,0,80] >> c:\temp\%fl ^
    else ^ @echo. >> c:\temp\%fl ^
    endiff )
set tm=
set dt=
set fl=
