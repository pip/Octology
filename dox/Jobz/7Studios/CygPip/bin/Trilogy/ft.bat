echo user > C:\home\Pip\bin\ftp_user.cfg
:: 24.19.171.117
::if "%1" == "d" echo user piptigger > C:\home\Pip\bin\ftp_user.cfg
if "%1" == "d" ftp -n -i -s:C:\home\Pip\bin\ftp_user.cfg lbox.org
if "%1" == "d" quit
:: 800telephone.com
if "%1" == "l" echo user pip              >  C:\home\Pip\bin\ftp_user.cfg
if "%1" == "l" echo maka                  >> C:\home\Pip\bin\ftp_user.cfg
if "%1" == "l" echo cd ../httpd/html/demo >> C:\home\Pip\bin\ftp_user.cfg
if "%1" == "l" ftp -n -i                  -s:C:\home\Pip\bin\ftp_user.cfg 24.16.72.254
if "%1" == "l" quit
:: 207.77.83.125 host3.dynamic.com telephon i4wSnh4Y2 -> 184352al
if "%1" == "h" echo user telephon         >  C:\home\Pip\bin\ftp_user.cfg
if "%1" == "h" echo 184352al              >> C:\home\Pip\bin\ftp_user.cfg
if "%1" == "h" ftp -n -i                  -s:C:\home\Pip\bin\ftp_user.cfg host3.dynamic.com
if "%1" == "h" quit
:: monica.telcobid.com
if "%1" == "t" echo user pip              > C:\home\Pip\bin\ftp_user.cfg
if "%1" == "t" ftp -n -i                 -s:C:\home\Pip\bin\ftp_user.cfg monica.telcobid.com
if "%1" == "t" quit
:: opus.dns.bigape.com
if "%1" == "o" echo user pip              > C:\home\Pip\bin\ftp_user.cfg
if "%1" == "o" ftp -n -i                 -s:C:\home\Pip\bin\ftp_user.cfg 192.169.2.44
if "%1" == "o" quit
:: Pat's server
:: if "%1" == "p" ftp 64.35.9.77
:: if "%1" == "p" quit
if "%1" == "e" .or. "%1" == "u" echo user nitemare >  C:\home\Pip\bin\ftp_user.cfg
if "%1" == "e" .or. "%1" == "u" echo yisr4el6      >> C:\home\Pip\bin\ftp_user.cfg
if "%1" == "e" .or. "%1" == "u" ftp -n -i          -s:C:\home\Pip\bin\ftp_user.cfg ea.oac.uci.edu
if "%1" == "e" .or. "%1" == "u" quit
:: 24.8.182.205
::if "%1" == "" .or. "%1" == "b" .or. "%1" == "p" echo user pip > C:\home\Pip\bin\ftp_user.cfg
if "%1" == "" .or. "%1" == "b" .or. "%1" == "p" ftp -n -i -s:C:\home\Pip\bin\ftp_user.cfg binq.org
if "%1" == "" .or. "%1" == "b" .or. "%1" == "p" quit
if "%1" == "?" echo b = BinQ.org/RazorStorm.net        - e = ea.oac.UCI.edu
if "%1" == "?" echo           d = DimensionSoftware.com/LBox.org
if "%1" == "?" echo   h = Dynamic.net's hosting server   - l = Len's crap
if "%1" == "?" quit
if "%1" != "" ftp %&
