#!/bin/bash
HOST=$1
PORT=$2
NR=$3
Xs=$4
Xe=$5
Y=$6

LOG="/tmp/log.$NR"
rm $LOG

exec 4<>/dev/tcp/$HOST/$PORT

function px {

	echo "PX $1 $2" >&4
	read var <&4
	echo $var >> $LOG
}

for (( x=$Xs; x<=$Xe; x++ )); do
	for (( y=0; y<=$Y; y++ )); do
        	px $x $y
	done
done

#echo -e "SIZE" >&3
#cat <&3
