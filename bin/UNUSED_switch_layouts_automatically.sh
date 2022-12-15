#!/bin/bash

while true
do
    if xrandr | grep HDMI | grep ' connected'; then
        autorandr --change > /dev/null
    fi
done
