#!/bin/bash

STATUS_CMD="cat /sys/class/drm/card1-HDMI-A-1/status /sys/class/drm/card1-DP-2/status"
prev_status=$($STATUS_CMD)

while true; do
  current_status=$($STATUS_CMD)

  if [[ "$current_status" != "$prev_status" ]]; then
    prev_status=$current_status
    WAYLAND_DISPLAY= autorandr --change
  fi

  sleep 1
done
