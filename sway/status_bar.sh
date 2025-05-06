#!/bin/bash

while true; do
	DATE=$(date +'%c')
	LAYOUT=$(swaymsg -t get_inputs |
		jq -r 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name')
	if [ $(playerctl status) = "Playing" ]; then
		ARTIST=$(playerctl metadata artist)
		SONG=$(playerctl metadata title)
		echo "$ARTIST - $SONG | $LAYOUT | $DATE"
	else
		echo "$LAYOUT | $DATE"
	fi
	sleep 1
done
