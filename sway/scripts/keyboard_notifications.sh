#!/bin/bash

set -e

if pidof -o %PPID -x "keyboard_notifications.sh" >/dev/null; then
	echo "yes"
	exit
fi

swaymsg -mt subscribe '["input"]' | while read -r INPUT; do
	IS_LAYOUT_CHANGE=$(echo $INPUT | jq -r '.change == "xkb_layout"')
	IS_KEYBOARD=$(echo $INPUT | jq -r '.input.type == "keyboard"')
	if [[ "$IS_LAYOUT_CHANGE" == "true" ]] && [[ "$IS_KEYBOARD" == "true" ]]; then
		LAYOUT=$(echo $INPUT | jq -r '.input.xkb_active_layout_name')
		notify-send --expire-time 3000 "Keyboard layout changed" "$LAYOUT"
	fi
done
