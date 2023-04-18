#!/bin/bash

serverip="192.168.102.6"

count=1
start=1000


if [ "$2" == "bg" ] ; then
    declare -a bgports=("80" "25" "443" "3306" "162" "3306" "161" "1645" "1646" "2483" "1521" "514" "4739" )
elif  [ -z "$2" ]; then
    streams="10"
else 
    streams="$2"

fi

if [ "$1" == "start" ]; then
    if [ "$2" == "bg" ] ; then
        for i in "${bgports[@]}"
            do
                iperf3 -s -D -p "$i"
                #iperf3 -s -D -B "$serverip" -p "$i"
                #echo "$i" "_ " "time"
            done 
    else 
        echo "default"
        while [ $count -le $streams ]
            do
                port=$(( $count + $start ))
                        echo "$port"
                iperf3 -s -D -p "$port"
                #iperf3 -s -D -B $serverip -p "$port"
                count=$(( $count + 1 ))
            done
    fi


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
	\"./server-iperf.sh start bg \" to start listening on the bgroup ports as defined in the header
	\"./server-iperf.sh stop \" "
fi


