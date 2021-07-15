#!/bin/bash
# The server is set up and run to listen on the range of ports starting at 1000 and the number of streams.
# MSS can be set to the small packet sizes 128 is the minimun 
# Stream are unique port, parallel is using the same port default is 1
# set fpr TCP, but can uncomment UDP option



server=192.168.101.151
length=8860
parallel=1


if  [ -z "$1" ]; then
    	echo "options are:
	Time in seconds
	Number of ports to be used
	Mss to control packet size"
	echo "example 
	\"./client-iperf.sh 60 10 128\" to run for 60 seconds with 10 ports (1001-1010) and Packet size set to 128 bytes.
	\"./client-iperf.sh 6 10 512\" to run for 6 seconds with 10 ports (1001-1010) and Packet size set to 512 bytes. 

	Time must be defined but the default for port range is 10 and packet size is 1024 "
	exit 1
else 
    time="$1"

fi

if  [ -z "$2" ]; then
    streams=10
else 
    streams="$2"

fi

if  [ -z "$3" ]; then
    mss=1024
else 
    mss="$3"

fi



echo "Started"
date
rm -r /tmp/iperf*

#declare -i count
#declare -i start

count=1
start=1000
while [ $count -le $streams ]
        do
            port=$(( $count + $start ))
            #TCP
	    iperf3 -c $server -M $mss -p $port -t $time -P $parallel -f m --length $length --logfile /tmp/iperf_server_log_$port &
            #UDP
#	    iperf3 -c $server -M $mss -p $port -u -t $time -P $parallel -f m --length $length --logfile /tmp/iperf_server_log_$port &
            count=$(( $count + 1 ))
        done
sleep $time
echo "Finished"
date
sleep 2
#TCP
more /tmp/iperf* |grep sender |cut -c 37-50
#UDP
#more /tmp/iperf* | grep "0.00-$time.00" |grep "SUM"
