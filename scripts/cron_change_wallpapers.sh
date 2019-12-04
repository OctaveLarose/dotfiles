#!/bin/bash

### USAGE ###
#
# Define the directory where your images are stored. They must be named "morning", "afternoon",
# "evening" and "night", with the extensions ".jpg" or ".png"
#
# Define the hours during which morning, afternoon, evening and night take place.
#
# Then set up a cron job to periodically run this script, like at the start of each hour.
# Example : (0 * * * * PATH/TO/SCRIPT) in crontab

### IMAGES DIRECTORY
DIR="$HOME/Pictures/time_wallpapers"
EXTENSIONS=("jpg" "png")

### TIMES ###
MORNING_TIMES=(8 12)
AFTERNOON_TIMES=(12 17)
EVENING_TIMES=(17 21)
NIGHT_TIMES=(21 8)

HOUR=$(date +%-H)


# If an hour is provided, then the script changes the wallpaper to what it will look like at said hour.
if [ ! $# -eq 0 ]
then
	HOUR=$1
fi


# KDE 4
change_wallpaper_kde() {
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "string: 
	var Desktops = desktops(); for (i=0 ; i < Desktops.length ; i++) {
        d = Desktops[i]; d.wallpaperPlugin = \"org.kde.image\"; d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
        d.writeConfig(\"Image\", \"file://$DIR/$1\");}"
}


change_wallpaper() {
	FILENAME=$1
	TIMEOUT_AT=30 # in seconds
	CUR_DELAY=0

	for ext in "${EXTENSIONS[@]}"
	do
		if [ -f "$DIR/$FILENAME.$ext" ]
		then
			IMG="$FILENAME.$ext"
			break
		fi
	done

	if pgrep -l kde > /dev/null;
	then
		until change_wallpaper_kde $IMG || [ "$CUR_DELAY" -ge "$TIMEOUT_AT" ]
		do
        		echo "dbus failed, retrying..."
        		sleep 1
			((CUR_DELAY++))
			echo $CUR_DELAY
		done
	else
		echo "Desktop environment not supported : $XDG_CURRENT_DESKTOP"
		exit 1
	fi

	if [ "$CUR_DELAY" -ge "$TIMEOUT_AT" ]
	then
		echo "Timed out."
	else
		echo "Changing to image : $IMG"
	fi
}

if [[ "$HOUR" -ge ${MORNING_TIMES[0]} && "$HOUR" -lt ${MORNING_TIMES[1]} ]]; then
	change_wallpaper "morning"
elif [[ "$HOUR" -ge ${AFTERNOON_TIMES[0]} && "$HOUR" -lt ${AFTERNOON_TIMES[1]} ]]; then
	change_wallpaper "afternoon"
elif [[ "$HOUR" -ge ${EVENING_TIMES[0]} && "$HOUR" -lt ${EVENING_TIMES[1]} ]]; then
	change_wallpaper "evening"
elif [[ "$HOUR" -ge ${NIGHT_TIMES[0]} || "$HOUR" -lt ${NIGHT_TIMES[1]} ]]; then
	change_wallpaper "night"
fi
