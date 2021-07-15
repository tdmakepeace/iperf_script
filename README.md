# iperf_script

Script to test the performance with different packet sizes.

## server script 
	options are start or stop and the number of ports from 1001
	example 
	"./server-iperf.sh start 10" to start with port 1001-1010 listening (default is 10)
	"./server-iperf.sh stop "  Kills all iperf deamons running
  
##  client script
	options are:
	Time in seconds
	Number of ports to be used
	Mss to control packet size
	
	example 
	"./client-iperf.sh 60 10 128" to run for 60 seconds with 10 ports (1001-1010) and Packet size set to 128 bytes.
	"./client-iperf.sh 6 10 512" to run for 6 seconds with 10 ports (1001-1010) and Packet size set to 512 bytes. 
  
	Time must be defined but the default for port range is 10 and packet size is 1024 
