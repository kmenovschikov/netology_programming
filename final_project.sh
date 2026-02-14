#!/bin/bash

echo "Программа может быть запущена в двух режимах - 1) Обычный 2) С параметрами"
echo "cmdline, environ, limits, mounts, status, cwd, fd, fdinfo, root"

CMDLINE='CMDLINE_EMPTY';ENVIRON='ENVIRON_EMPTY';LIMITS='LIMITS_EMPTY';MOUNTS='MOUNTS_EMPTY';STATUS='STATUS_EMPTY';FD='FD_EMPTY';FDINFO='FDINFO_EMPTY'

# cwd,root - links; fd, fdinfo - dir, ostalnye - faily

echo "------------------------------------------------------------------------------------------------------------"
echo "TIMESTAMP | PID | NAME | $1 | $2 | $3 | $4 | $5 | $6 | $7 | $8 | $9"
echo "------------------------------------------------------------------------------------------------------------"


proverka() {

if [[ $1 = 'root' ]]; then
	echo $(readlink "$i/root")
fi;


if [[ $1 = 'cwd' ]]; then
	echo $(readlink "$i/cwd")
fi;


if [[ $1 = 'cmdline' ]]; then
	if [[ $(stat -c "%s" "$i/cmdline") != 0 ]] ; then
		CMDLINE=$(head -n 1 "$i/cmdline" 2>dev/null)
	fi;
echo $CMDLINE
fi;

if [[ $1 = 'environ' ]]; then
	if [[ $(stat -c "%s" "$i/environ") != 0 ]] ; then
		ENVIRON=$(head -n 1 "$i/environ" 2>dev/null)
	fi;
echo $ENVIRON
fi;


if [[ $1 = 'limits' ]]; then
	if [[ $(stat -c "%s" "$i/limits") != 0 ]] ; then
		LIMITS=$(head -n 1 "$i/limits" 2>dev/null)
	fi;
echo $LIMITS
fi;


if [[ $1 = 'mounts' ]]; then
	if [[ $(stat -c "%s" "$i/mounts") != 0 ]] ; then
		MOUNTS=$(head -n 1 "$i/mounts" 2>dev/null)
	fi;
echo $MOUNTS
fi;


if [[ $1 = 'status' ]]; then
	if [[ $(stat -c "%s" "$i/status") != 0 ]] ; then
		STATUS=$(head -n 1 "$i/status" 2>dev/null)
	fi;
echo $STATUS
fi;


if [[ $1 = 'fdinfo' ]]; then
FDINFO=$(ls "$i/fdinfo/" | wc -l)
echo "FDINFO="$FDINFO
fi;

if [[ $1 = 'fd' ]]; then
FD=$(ls -la $i/fd/ | awk '{print $11}')
	if [[ ! -z $FD ]]; then
	echo $FD | sed 's/ /+/g'
	else
	echo "FD_EMPTY"
	fi;
fi;


}

LEN=$(find /proc -maxdepth 1 -type d -name [0-9]* | wc -l | bc)
c=1

for i in $(find /proc -maxdepth 1 -type d -name [0-9]*); do

	if [[ c -eq $LEN-3 ]]; then
		break;
	fi;

	poisk=$(echo $i | cut -c1-6 --complement)

	if [[ ! $(grep $poisk /tmp/log.txt) ]]; then
		echo $poisk "Ne naideno, dopisyvaem"
		echo "$(date "+%d-%m-%Y-%H:%M:%S")" "$(echo $i | cut -c1-6 --complement)" "$(readlink $i/exe)" "$(proverka $1) $(proverka $2) $(proverka $3) $(proverka $4) $(proverka $5) $(proverka $6) $(proverka $7) $(proverka $8) $(proverka $9)" >>/tmp/log.txt
	fi;

	((c++))
done