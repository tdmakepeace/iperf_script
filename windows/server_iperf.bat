ECHO off



set count=%2
set action=%1
set serverip="192.168.102.6"
set pstart=1000
echo %action%
echo %count%


:: if %action%=="bg" (for %%a in (%bgports%) do (                START /B iperf3 -s -d -p %%a )) 



if %action%==bg  goto :background 
if %action%==start  goto :startserver
if %action%==stop  goto :stopserver



exit /b 0



:background 
set bgports="80" "25" "443" "3306" "162" "3306" "161" "1645" "1646" "2483" "1521" "514" "4739"
(for %%a in (%bgports%) do ( 
       START /B iperf3 -s -d -p %%a 
       ))


exit /b 0

:startserver 

SET /A "top = pstart + count"
echo %top%
:while
if %pstart% leq %top% (
   echo The value of index is %pstart%
   START /B iperf3 -s -d -p %pstart%
   
   SET /A "pstart = pstart + 1"
   goto :while
)

exit /b 0 

:stopserver
taskkill /f /im iperf3.exe

exit /b 0
