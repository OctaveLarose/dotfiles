#!/bin/bash

STATUS_CMD="cat /sys/class/drm/card0/card0-HDMI-A-1/status"
prev_status=$($STATUS_CMD)

while true; do
  current_status=$($STATUS_CMD)

  if [[ "$current_status" != "$prev_status" ]]; then
    autorandr --change
    prev_status=$current_status
  fi

  sleep 1
done
