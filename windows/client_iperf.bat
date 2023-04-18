ECHO ON



set count=%2
set action=%1
set serverip=192.168.102.6
set pstart=1000
set length=8860
set parallel=1
set /a maxtime=10
set /a loop=4
set /a looptime=10
set /a mss=1024
echo %action%



if %action%==bg  goto :background 
if %action%==start  goto :startserver
if %action%==stop  goto :stopserver



exit /b 0



:background 

set /A "count = 1"
echo %count%
echo %loop%


:while

if %count% leq %loop% (
   echo The value of index is %count%
   echo Starting %loop% Loops
    set bgports="80" "25" "443" "3306" "162" "3306" "161" "1645" "1646" "2483" "1521" "514" "4739"
   
   for %%a in (%bgports% %maxtime%  ) do ( 
    set /a port=%%a
    set /a rand="(%RANDOM%*%maxtime%/32768)"
    set /A "rand = rand + 1"
     echo Random number %rand%
     echo %port%
     timeout %rand%  > NUL
     echo "Finished Loop $count"
     SET /A "count = count + 1"
      
     )

::     START /B iperf3 -c %serverip% -M %mss% -p %port% -t %rand% -P %parallel% -f m --length %length% & 

       
   goto :while
 )

exit /b 0 

::       START /B iperf3 -c %serverip% -M %mss% -p 1000 -t 1 -P %parallel% -f m --length %length%   > /dev/null 2>&1 & 
exit /b 0 


:startserver 

SET /A "top = pstart + count"
echo %top%
:while2
if %pstart% leq %top% (
   echo The value of index is %pstart%
   START /B iperf3 -s -d -p %pstart%
   
   SET /A "pstart = pstart + 1"
   goto :while2
)

exit /b 0 

:stopserver
taskkill /f /im iperf3.exe

exit /b 0
