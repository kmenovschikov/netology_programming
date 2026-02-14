#!/bin/bash

readarray -t lines < "/proc/bus/input/devices"

for line in "${lines[@]}";
do
	if [[ $line =~ 'Name=' ]]; then
		NAME=$(echo $line | sed -E 's/N: Name="//g' | sed -E 's/"//g' | sed -E 's/ /_/g')
			if [[ ! $(grep $NAME dev.txt 2>/dev/null) ]]; then
				echo -n "Devais ne naiden - zanosim "
				echo -n "$(date "+%d-%m-%Y-%H:%M:%S") " >>dev.txt
				echo -n "$NAME ">>dev.txt
			else echo -n "Devais naiden "
			fi;

	fi;

	SYSFS=$(echo $line | sed -E 's/S: Sysfs=/ /g')

	if [[ $line =~ 'Sysfs=' ]]; then
		if [[ ! $(grep $SYSFS dev.txt) ]]; then
			echo "Sysfs ne naiden - zanosim"
			echo $SYSFS >> dev.txt
		else echo "Sysfs naiden"
		fi;
	fi;
done
