#! /bin/bash

function load_cpu() {

	stress -c 40 -m 1 --vm-bytes 750M -t 5 -q &

}

function check_cpu() {

	printf "CPU\t\tMemeory\n"
	MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
	CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
	echo "$CPU$MEMORY"
}

printf "\nBefore Stressing\n"
check_cpu
load_cpu
sleep 3
printf "\nAfter Stressing\n"
check_cpu
printf "\nExiting ..\n"
wait
sleep 1
