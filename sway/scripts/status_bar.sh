#!/bin/bash

CHASSIS=$(hostnamectl chassis)

while true; do
	DATE=$(date +'%b %d, %H:%M')
	LAYOUT=$(swaymsg -t get_inputs | jq -r 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name')

	OUTPUT="$LAYOUT | $DATE"

	if [ $CHASSIS = "laptop" ]; then
		BATTERY=$(cat /sys/class/power_supply/macsmc-battery/capacity)
		OUTPUT="$BATTERY% | $OUTPUT"
	fi

	if [ $(playerctl status) = "Playing" ]; then
		ARTIST=$(playerctl metadata artist)
		SONG=$(playerctl metadata title)
		OUTPUT="$ARTIST - $SONG | $OUTPUT"
	fi
	echo $OUTPUT

	sleep 1
done
