#!/bin/bash
HOSTi=$1
PORTi=$2
HOSTo=$3
PORTo=$4
Xs=$5
Xe=$6
Y=$7

exec 4<>/dev/tcp/$HOSTi/$PORTi
exec 5>/dev/tcp/$HOSTo/$PORTo


function px {

	echo "PX $1 $2" >&4
	read var <&4
	echo $var >&5
}

for (( x=$Xs; x<=$Xe; x++ )); do
	for (( y=0; y<=$Y; y++ )); do
        	px $x $y
	done
done

#echo -e "SIZE" >&3
#cat <&3
