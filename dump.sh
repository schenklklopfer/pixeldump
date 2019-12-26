#!/bin/bash

HOST="127.0.0.1"
PORT="1234"
PTH="/home/schenkl/px-dd/px.sh"

exec 3<>/dev/tcp/$HOST/$PORT
echo -e "SIZE" >&3

SIZE=$(read var <&3; echo $var)
X=$(echo $SIZE | awk '{print $2}')
Y=$(echo $SIZE | awk '{print $3}')

let Y=Y-1

if [ $(( $X % 8 )) -eq 0 ]; then
	DIVI=$(($X / 8))
else
	exit
fi

CO=0
NR=1
while [ $CO -lt $X ]; do
	Xe=$(($CO+$DIVI-1))
	echo von $CO bis $Xe
	time $PTH $HOST $PORT $NR $CO $Xe $Y &
	let CO=CO+$DIVI
	let NR=NR+1
done
