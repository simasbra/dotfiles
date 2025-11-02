#!/bin/bash

set -e

if pidof -o %PPID -x "keyboard_notifications.sh" >/dev/null; then
	exit
fi

swaymsg -mt subscribe '["input"]' | while read -r INPUT; do
	IS_LAYOUT_CHANGE=$(echo $INPUT | jq -r '.change == "xkb_layout"')
	if [[ "$IS_LAYOUT_CHANGE" == "true" ]]; then
		LAYOUT=$(echo $INPUT | jq -r '.input.xkb_active_layout_name')
		notify-send --expire-time 3000 "Keyboard layout changed" "$LAYOUT"
	fi
done
