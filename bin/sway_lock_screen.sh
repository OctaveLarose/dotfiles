#!/bin/bash

grim /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x15 /tmp/screenshotblur.png
rm /tmp/screenshot.png
swaylock -i /tmp/screenshotblur.png
rm /tmp/screenshotblur.png
