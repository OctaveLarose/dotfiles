import -window root /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x8 /tmp/screenshotblur.png
rm /tmp/screenshot.png
i3lock -i /tmp/screenshotblur.png
rm /tmp/screenshotblur.png
