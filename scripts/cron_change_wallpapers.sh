#!/bin/bash

### USAGE ###
#
# Define the directory where your images are stored. They must be named "morning", "afternoon",
# "evening" and "night", with the extensions ".jpg" or ".png"
#
# Define the hours during which morning, afternoon, evening and night take place.
#
# Then set up a cron job to periodically run this script, like at the start of every hour.
# Example : (0 * * * * PATH/TO/SCRIPT) in crontab


### IMAGE DIRECTORY
DIR="$HOME/Pictures/time_wallpapers"
EXTENSIONS=("jpg" "png")

### TIMES ###
MORNING_TIMES=(8 12)
AFTERNOON_TIMES=(12 17)
EVENING_TIMES=(17 21)
NIGHT_TIMES=(21 8)

HOUR=$(date +%-H)

### MORE PARAMETERS
TIMEOUT_AT=30 # Time before the script gives up on changing the wallpaper, in seconds

### SPECIAL PARAMETERS
I_FEEL_BLESSED=true
BLESSED_CHANCE=42

WEATHER_CHANGES='rain' # or none
CITY=$CITY

# If an hour is provided, then the script changes the wallpaper to what it would look like at said hour.
if [ ! $# -eq 0 ]
then
	HOUR=$1
fi


# KDE 4/5
change_wallpaper_kde() {
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "string: 
	var Desktops = desktops(); for (i=0 ; i < Desktops.length ; i++) {
        d = Desktops[i]; d.wallpaperPlugin = \"org.kde.image\"; d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
        d.writeConfig(\"Image\", \"file://$DIR/$1\");}" > /dev/null
}


# Main function.
change_wallpaper() {
	FILENAME=$1
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
			echo $CUR_DELAY/$TIMEOUT_AT tries...
		done
	else
		echo "Desktop environment not supported : $XDG_CURRENT_DESKTOP"
		exit 1
	fi

	if [ "$CUR_DELAY" -ge "$TIMEOUT_AT" ]
	then
		echo "Timed out." # TODO: append it to a log file
	else
		echo "Changing to image : $IMG"
	fi
}

### BLESSED AREA
if [ "$I_FEEL_BLESSED" = true ] && [ $((( RANDOM % $BLESSED_CHANCE ))) == 0 ]; then
	change_wallpaper "blessed"
	exit 0
fi

# TODO: needs to be way more flexible
### WEATHER SPECIFIC
if [[ $(curl -s wttr.in/$CITY 2>&1 | sed '3!d' | awk 'tolower($1) ~ /rain/') ]]; then
    echo "The weather is rainy."
    change_wallpaper "rain"
    exit 0
fi


if [[ "$HOUR" -ge ${MORNING_TIMES[0]} && "$HOUR" -lt ${MORNING_TIMES[1]} ]]; then
	change_wallpaper "morning"
elif [[ "$HOUR" -ge ${AFTERNOON_TIMES[0]} && "$HOUR" -lt ${AFTERNOON_TIMES[1]} ]]; then
	change_wallpaper "afternoon"
elif [[ "$HOUR" -ge ${EVENING_TIMES[0]} && "$HOUR" -lt ${EVENING_TIMES[1]} ]]; then
	change_wallpaper "evening"
elif [[ "$HOUR" -ge ${NIGHT_TIMES[0]} || "$HOUR" -lt ${NIGHT_TIMES[1]} ]]; then
	change_wallpaper "night"
fi
