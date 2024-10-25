#!/usr/bin/env bash

theme_dir="/home/octavel/.config/polybar/forest"
XAUTHORITY=/run/user/1000/gdm/Xauthority
DISPLAY=:0

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 2; done

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -q main -c "$theme_dir/config.ini" &
  done
else
  polybar -q main -c "$theme_dir/config.ini" &
fi
