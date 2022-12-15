#!/usr/bin/env bash

theme_dir="$HOME/.config/polybar/forest"

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

pushd $theme_dir/modules_layout > /dev/null
if [ "$1" == "--no-time" ]
  then
    ln -sf no_time.config current.config
else
    ln -sf default.config current.config
fi
popd > /dev/null

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -q main -c "$theme_dir/config.ini" &
  done
else
  polybar -q main -c "$theme_dir/config.ini" &
fi
