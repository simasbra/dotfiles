#!/bin/bash

CHASSIS=$(hostnamectl chassis)

while true; do
	DATE=$(date +'%b %d, %H:%M')
	OUTPUT="$DATE"

	if [ $CHASSIS = "laptop" ]; then
		CAPACITY=$(cat /sys/class/power_supply/macsmc-battery/capacity)
		if [ $(($CAPACITY)) -le 20 ]; then
			TIME_TO_EMPTY=$(cat /sys/class/power_supply/macsmc-battery/time_to_empty_now)
			REMAINING_MINUTES="$(($TIME_TO_EMPTY / 60))"
			OUTPUT="$CAPACITY%, ${REMAINING_MINUTES}min left | $OUTPUT"
		else
			OUTPUT="$CAPACITY% | $OUTPUT"
		fi
	fi

	if [ $(playerctl status) = "Playing" ]; then
		ARTIST=$(playerctl metadata artist)
		SONG=$(playerctl metadata title)
		OUTPUT="$ARTIST - $SONG | $OUTPUT"
	fi
	echo $OUTPUT

	sleep 5
done
