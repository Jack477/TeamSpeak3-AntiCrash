#!/bin/bash
clear
echo ""
echo "#######################"
echo "#TS3 anti-crash       #"
echo "#ver 1.01 by Legos    #"
echo "#######################"
echo ""
	log="ts3-ac_crash.log"
	if [ ! -f $log ] ; then
	echo "Creating log file..."
	touch ts3-ac_crash.log
	fi
while [ true ]; do
	sleep 3
	ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head > ts3_proc.txt
	
	########read first line of file, useless########
	#line=$(head -1 "ts3_proc.txt")	
	
	input="ts3_proc.txt"
	while IFS= read -r line
	do
		#flag=`echo $line|awk '{print match($0,"ts3s")}'`;
		
		#echo $line
		if [[ $line == *"ts3s"* ]]
		then
			sleep 4
			
			########Check process substring name#########
			#ts3=${line:35:6}
			#echo $ts3
			#if [[ $ts3 = "ts3s" ]] ; then
			
			
				proc_id=${line:0:6}
				cpu_usage=${line:45:2}
				echo "Teamspeak3 works and CPU usage is: "$cpu_usage"% PID is: "$proc_id
				if [ $cpu_usage -gt 90 ]; then			
				echo $proc_id
				kill -9 $proc_id
				crash_date=$(date)
				echo $crash_date " Server crash down! CPU usage: " $cpu_usage "%" >> ts3-ac_crash.log
				sleep 1
				echo "teamspeak3 down"
				screen -d -m ./ts3server
				sleep 10
				fi
		#else
		#	echo "Can't find process"
		fi
		
	done < $input
done
#TODO
# !DONE -make crash report with crash date
#-use it to controll more/other process?
