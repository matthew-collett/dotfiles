#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

if ipconfig getsummary en0 2>/dev/null | grep -q "LinkStatusActive : TRUE"; then
  sketchybar --set "$NAME" icon="$WIFI_CONNECTED" icon.color=$GREEN
else
  sketchybar --set "$NAME" icon="$WIFI_DISCONNECTED" icon.color=$RED
fi
