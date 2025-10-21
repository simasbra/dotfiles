#!/bin/bash

CHASSIS=$(hostnamectl chassis)

while true; do
	DATE=$(date +'%c')
	LAYOUT=$(swaymsg -t get_inputs |
		jq -r 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name')
	PERCENTAGE=$(cat /sys/class/power_supply/macsmc-battery/capacity)

	if [ $(playerctl status) = "Playing" ]; then
		ARTIST=$(playerctl metadata artist)
		SONG=$(playerctl metadata title)

		if [ $CHASSIS = "laptop" ]; then
			echo "$ARTIST - $SONG | $PERCENTAGE% | $LAYOUT | $DATE"
		else
			echo "$ARTIST - $SONG | $LAYOUT | $DATE"
		fi
	else
		if [ $CHASSIS = "laptop" ]; then
			echo "$LAYOUT | $PERCENTAGE% | $DATE"
		else
			echo "$LAYOUT | $DATE"
		fi
	fi
	sleep 1
done
