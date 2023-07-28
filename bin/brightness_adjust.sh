#!/bin/bash

brightness_adjust=$1

if [ "$2" = "+" ]; then
    brightnessctl set "$brightness_adjust"%+
elif [ "$2" = "-" ]; then
    max_brightness=$(brightnessctl m)
    current_brightness=$(brightnessctl g)
    new_brightness=$((max_brightness * brightness_adjust * 100 / 10000))
    
    if [ "$((current_brightness - new_brightness))" -le 0 ]; then
        brightnessctl set 1
    else
        brightnessctl set "$brightness_adjust"%-
    fi
else
    echo "Invalid argument. Use '+' or '-' as the second argument."
fi

