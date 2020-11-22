::set path=c:\4dos;c:\tsejr;c:\4dos\command;c:\batch;c:\windows;c:\windows\command;c:\4dos\qemm;f:\djgpp\bin;c:\ultrasnd;c:\sb16;c:\windows\mouse
:: 7974T53 - Above is hella old but preserved just for fond memories. =)
::   Taki's WinXPPro %path settings with which, I'm concerned about
::   Perl installs && environments since I'm trying to get a werking
::   PAR::Packer to be able to build standalone Win32 .exe distributions of
::   my Perl/Tk (&& hopefully also someday SDLPerl) applications.
:: Notz: (in inst ordr) (built*==more by me locally than bin from company (AS))
::   installed ActiveState's Perlv5.8.8 for MSWin32-x86-multi-thread
::     (w/ 25reg'd patches),binary build 817 [257965]             built 63KHsP0
::   installed CygWin     's Perlv5.8.8 for cygwin-thread-multi-64int
::     (w/  8reg'd patches),OSversion:1.5.24(0.15642)71VAv00 i686 built*778JC80
::   installed Strawberry a2 Perlv5.8.8 for MSWin32-x86-multi-thread blt68RHHo0
::   also dl'd CamelPack     Perlv5.8.7 (late 2006?) but didn't install it yet
::     After doing so,%path looked like:
if "%1" == "old" set     PATH=C:\Python24\.;C:\Perl\bin\;C:\home\Pip\bin;C:\home\Pip\bin\vim70;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\Program Files\Intel\Wireless\Bin;C:\Program Files\Common Files\Adobe\AGL;C:\Program Files\Common Files\GTK\2.0\bin;C:\strawberry-perl\perl\bin;C:\strawberry-perl\dmake\bin;C:\strawberry-perl\mingw\bin;C:\home\Pip\bin\CygWin\bin
:: I'm switching things around to see if strawberry can be nicer for PAR.
if "%1" == "sbp" set     PATH=C:\home\Pip\bin;C:\strawberry-perl\perl\bin;C:\strawberry-perl\dmake\bin;C:\strawberry-perl\mingw\bin;C:\home\Pip\bin\CygWin\bin;C:\Perl\bin;C:\Windows;C:\Windows\System32;C:\Program Files\Common Files\GTK\2.0\bin;
:: 79764MP - I can't figure out why StrawberryPerl can't ever copy at the
::   pm_to_blib stage, like it can't get permission to `mkdir blib` even though
::   I'm an admin or something.  Maybe Vanilla is more stable && a better
::   choice.  Straw doesn't seem to have seen updates in over a year.  Oh well.
::   Using PAR::Packer on Win32 (WinXPPro SP2) shouldn't be this fscking hard!
::   I'm falling back to ActivePerl for now. =(
if "%1" == "cyg" set     PATH=C:\home\Pip\bin;C:\home\Pip\bin\CygWin\bin;C:\Perl\bin;C:\strawberry-perl\perl\bin;C:\strawberry-perl\dmake\bin;C:\strawberry-perl\mingw\bin;C:\Windows;C:\Windows\System32;C:\Program Files\Common Files\GTK\2.0\bin;
if "%1" == "og0" set     PATH=C:\home\Pip\bin;C:\Perl\bin;C:\home\Pip\bin\CygWin\bin;C:\strawberry-perl\perl\bin;C:\strawberry-perl\dmake\bin;C:\strawberry-perl\mingw\bin;C:\Windows;C:\Windows\System32;C:\Program Files\Common Files\GTK\2.0\bin;
:: 7978CRr - rm SbP frm %path,%lib,%include,etc. to hopefully clean way for
::   standard MinGW to werk w/ newer ASP (5.8.8.820 or 822)
:: old     LIB=;C:\strawberry-perl\mingw\lib;C:\strawberry-perl\perl\bin
:: old INCLUDE=;C:\strawberry-perl\mingw\include;C:\strawberry-perl\perl\lib\CORE;C:\strawberry-perl\perl\lib\encode
:: new of each are empty
:: 79E5RKP - installed AP5.8.8.822 && SHAY's CPAN dmake
if "%1" == "mgw" set OGPROMPT=%PROMPT%
if "%1" == "mgw" set   PROMPT=$P$G
if "%1" == "mgw" set PERL5LIB=
if "%1" == "mgw" set ACTIVEPERL_CONFIG_SILENT=1
:: 79E6cOm - above&&`cpan -i PAR::Packer` successfully installed,below restorez
::   but might also need set HOME=
if "%1" == ""    set     PATH=C:\home\Pip\bin;C:\AP588822\site\bin;C:\AP588822\bin;C:\MinGW\dmake;C:\MinGW\bin;C:\Windows;C:\Windows\System32;C:\Program Files\Common Files\GTK\2.0\bin
if "%1" == ""    set      LIB=C:\MinGW\lib;C:\AP588822\bin
if "%1" == ""    set  INCLUDE=C:\MinGW\include;C:\AP588822\lib\CORE;C:\AP588822\lib\Encode;C:\home\Pip\inc
if "%1" == ""    set PERL5LIB=C:\home\Pip\lib
if "%1" == ""    set ACTIVEPERL_CONFIG_SILENT=1
if "%1" == ""    echo If you just ran MinGW and have basic prompt, try set PROMPT=%%OGPROMPT
:: 79HELke - tst no Perl in path for pp'd .exe
if "%1" == "tst" set     PATH=C:\home\Pip\bin;C:\Windows;C:\Windows\System32;C:\Program Files\Common Files\GTK\2.0\bin
if "%1" == "tst" set      LIB=
if "%1" == "tst" set  INCLUDE=
if "%1" == "tst" set PERL5LIB=
if "%1" == "tst" set OGPROMPT=%PROMPT%
if "%1" == "tst" set   PROMPT=$P$G
