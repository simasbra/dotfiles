#!/bin/bash

CHASSIS=$(hostnamectl chassis)

while true; do
	DATE=$(date +'%b %d, %H:%M')
	LAYOUT=$(swaymsg -t get_inputs | jq -r '.[0].xkb_active_layout_name')

	OUTPUT="$LAYOUT | $DATE"

	if [ $CHASSIS = "laptop" ]; then
		BATTERY=$(cat /sys/class/power_supply/macsmc-battery/capacity)
		OUTPUT="$BATTERY | $OUTPUT"
	fi

	if [ $(playerctl status) = "Playing" ]; then
		ARTIST=$(playerctl metadata artist)
		SONG=$(playerctl metadata title)
		echo "$ARTIST - $SONG | $OUTPUT"
	fi

	sleep 1
done
