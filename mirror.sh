#!/bin/bash

HOSTo="127.0.0.1"
PORTo="1234"
HOSTi="116.202.17.20"
PORTi="1234"
PTH="/home/schenkl/px-dd/pr.sh"

exec 3<>/dev/tcp/$HOSTi/$PORTi
echo -e "SIZE" >&3

SIZE=$(read var <&3; echo $var)
X=$(echo $SIZE | awk '{print $2}')
Y=$(echo $SIZE | awk '{print $3}')

let Y=Y-1

if [ $(( $X % 320 )) -eq 0 ]; then
	DIVI=$(($X / 320))
else
	exit
fi

CO=0
while [ $CO -lt $X ]; do
	Xe=$(($CO+$DIVI-1))
	echo von $CO bis $Xe
	time $PTH $HOSTi $PORTi $HOSTo $PORTo $CO $Xe $Y &
	let CO=CO+$DIVI
done
