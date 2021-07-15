#!/bin/bash

count=1
start=1000

if  [ -z "$2" ]; then
    streams=10
else 
    streams="$2"

fi

if [ "$1" == "start" ]; then
   while [ $count -le $streams ]
        do
            port=$(( $count + $start ))
            iperf3 -s -D -p $port
            count=$(( $count + 1 ))
        done
elif [ "$1" == "stop" ]; then
   while [ $count -le $streams ]
        do
            kill -9 ` ps -ef |grep iperf| grep -v grep |awk '{print $2}' |head -1`
            count=$(( $count + 1 ))
        done
else 
	echo "options are start or stop and the number of ports from 1001"
	echo "example 
	\"./server-iperf.sh start 10\" to start with port 1001-1010 listening (default is 10)
	\"./server-iperf.sh stop \" "
fi

