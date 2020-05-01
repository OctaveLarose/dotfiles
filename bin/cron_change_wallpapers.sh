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

### TIMES ###
MORNING_TIMES=(8 12)
AFTERNOON_TIMES=(12 19)
EVENING_TIMES=(19 22)
NIGHT_TIMES=(22 8)

HOUR=$(date +%-H)

### MORE PARAMETERS
TIMEOUT_AT=30 # Time before the script gives up on changing the wallpaper, in seconds
LOG_FILE=$HOME/log/change_wallpapers.log

### SPECIAL PARAMETERS
I_FEEL_BLESSED=true
BLESSED_CHANCE=42

# TODO : check if works correctly
#WEATHER_CHANGES=("rain") # or none

# If an hour is provided, then the script changes the wallpaper to what it would look like at said hour.
if [ ! $# -eq 0 ]
then
    HOUR=$1
    unset WEATHER_CHANGES
fi


write_to_log() {
    echo $1
    echo "`date`: $1" >> $LOG_FILE
}


# KDE 4/5
change_wallpaper_kde() {
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "string: 
    var Desktops = desktops(); for (i=0 ; i < Desktops.length ; i++) {
    d = Desktops[i]; d.wallpaperPlugin = \"org.kde.image\"; d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
    d.writeConfig(\"Image\", \"file://$1\");}" > /dev/null
}

get_image() {
    POSSIBLE_IMAGES=($(ls $DIR/$FILENAME*))
    IMAGE_INDEX=$(expr $RANDOM % ${#POSSIBLE_IMAGES[*]}) 

    echo "${POSSIBLE_IMAGES[$IMAGE_INDEX]}"
}

# Main function.
change_wallpaper() {
    FILENAME=$1
    CUR_DELAY=0

    IMG=$(get_image)
    if [ -z "$IMG" ]
    then
        write_to_log "No suitable image found for $1".
        exit 1
    fi

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
        write_to_log "Desktop environment not supported : $XDG_CURRENT_DESKTOP"
        exit 1
    fi

    if [ "$CUR_DELAY" -ge "$TIMEOUT_AT" ]
    then
        echo "Timed out."
        write_to_log "Time out" 
    else
        echo "Changing to image : $IMG"
    fi
}

### BLESSED AREA
if [ "$I_FEEL_BLESSED" = true ] && [ $((( RANDOM % $BLESSED_CHANCE ))) == 0 ]; then
    change_wallpaper "blessed"
    write_to_log "Absolutely blessed"
    exit 0
fi

### WEATHER SPECIFIC
if [ -n "${WEATHER_CHANGES+set}" ]; then
    echo "Querying wttr.in for city $CITY"
    CUR_WEATHER=$(curl -s wttr.in/$CITY 2>&1 | sed '3!d')

    for weather in "${WEATHER_CHANGES[@]}"
    do
        if [[ $(echo $CUR_WEATHER | grep -i $weather) ]]; then
            write_to_log "Weather: $weather"
            change_wallpaper $weather
            exit 0
        fi
    done
    echo "No suitable weather, treating the wallpapers normally."
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
