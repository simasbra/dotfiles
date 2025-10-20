#!/bin/bash

while true; do
	DATE=$(date +'%c')
	LAYOUT=$(swaymsg -t get_inputs |
		jq -r 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name')
	PERCENTAGE=$(upower upower -i /org/freedesktop/UPower/devices/battery_macsmc_battery | grep percentage | awk '{print $2}')
	if [ $(playerctl status) = "Playing" ]; then
		ARTIST=$(playerctl metadata artist)
		SONG=$(playerctl metadata title)
		echo "$ARTIST - $SONG | $LAYOUT | $DATE"
	else
		echo "$LAYOUT | $PERCENTAGE | $DATE"
	fi
	sleep 1
done
