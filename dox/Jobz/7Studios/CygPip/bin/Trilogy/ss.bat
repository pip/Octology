set sshb=plink -ssh
if "%1" == "t" set sshb=putty -ssh
if "%1" == "t" shift
REM 24.19.171.117
if "%1" == "d" %sshb% piptigger@lbox.org
if "%1" == "d" quit
REM 800telephone.com
if "%1" == "l" %sshb% pip@24.16.72.254
if "%1" == "l" quit
if "%1" == "h" echo 207.77.83.125 host3.dynamic.com telephon i4wSnh4Y2
if "%1" == "h" %sshb% telephon@host3.dynamic.com
if "%1" == "h" quit
::if "%1" == "t" %sshb% pip@monica.telcobid.com
::if "%1" == "t" quit
if "%1" == "o" %sshb% pip@192.169.2.44
if "%1" == "o" quit
if "%1" == "e" %sshb% nitemare@ea.oac.uci.edu
if "%1" == "e" quit
if "%1" == "u" %sshb% nitemare@ea.oac.uci.edu
if "%1" == "u" quit
REM 24.8.182.205
REM 24.1.23.227
if "%1" == "p" %sshb% pip@binq.org
if "%1" == "p" quit
if "%1" == "b" %sshb% pip@12.236.163.129
if "%1" == "b" quit
if "%1" == "a" %sshb% pip@12.236.174.76
if "%1" == "a" quit
if "%1" == "" %sshb% pip@ax9.org
if "%1" != "" %sshb% %&
set sshb=
