#!/bin/bash

while true; do
	DATE=$(date +'%c')
	LAYOUT=$(swaymsg -t get_inputs |
		jq -r 'map(select(has("xkb_active_layout_name")))[0].xkb_active_layout_name')
	echo "$LAYOUT | $DATE"
	sleep 1
done
