#!/bin/bash

import -window root /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x15 /tmp/screenshotblur.png
rm /tmp/screenshot.png
i3lock -i /tmp/screenshotblur.png
rm /tmp/screenshotblur.png
