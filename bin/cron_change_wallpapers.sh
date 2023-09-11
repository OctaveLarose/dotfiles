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
MORNING_START=7
AFTERNOON_START=13
EVENING_START=19
NIGHT_START=22

HOUR=$(date +%-H)

### MORE PARAMETERS
TIMEOUT_AT=30 # Time before the script gives up on changing the wallpaper, in seconds
LOG_FILE=$HOME/log/change_wallpapers.log
CURR_IMG_FILE=/tmp/current_wallpaper # Used to not reset the wallpaper when unnecessary
CURR_IMG=$(cat $CURR_IMG_FILE 2>/dev/null)

### SPECIAL PARAMETERS
I_FEEL_BLESSED=true
BLESSED_CHANCE=100

#WEATHER_CHANGES=("rain")

# If an hour is provided, then the script changes the wallpaper to what it would look like at said hour.
if [ ! $# -eq 0 ] && [ "$1" != "-f" ]
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
    # cron can't access dbus otherwise.
    export $(dbus-launch)
    DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
    var Desktops = desktops(); for (i=0 ; i < Desktops.length ; i++) {
    d = Desktops[i]; d.wallpaperPlugin = \"org.kde.image\"; d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
    d.writeConfig(\"Image\", \"file://$1\");}" > /dev/null
}

# i3
change_wallpaper_i3() {
    feh --bg-fill $1
}

get_image() {
    local POSSIBLE_IMAGES=($(ls $DIR/$FILENAME*))
    local IMAGE_INDEX=$(expr $RANDOM % ${#POSSIBLE_IMAGES[*]})

    echo "${POSSIBLE_IMAGES[$IMAGE_INDEX]}"
}

# Main function.
change_wallpaper() {
    local CUR_DELAY=0
    FILENAME=$1

    IMG=$(get_image)
    if [ -z "$IMG" ]
    then
        write_to_log "No suitable image found for $1".
        exit 1
    fi

    if pgrep -l i3 > /dev/null;
    then
        change_wallpaper_func=change_wallpaper_i3
    elif pgrep -l kded > /dev/null
    then
        change_wallpaper_func=change_wallpaper_kde
    else
        write_to_log "Desktop environment not supported : exiting."
    fi

    until $change_wallpaper_func $IMG || [ "$CUR_DELAY" -ge "$TIMEOUT_AT" ]
        do
            echo "Couldn't change the wallpaper, retrying..."
            sleep 1
            ((CUR_DELAY++))
            echo $CUR_DELAY/$TIMEOUT_AT tries...
        done

    if [ "$CUR_DELAY" -ge "$TIMEOUT_AT" ]
    then
        echo "Timed out."
        write_to_log "Time out"
    else
        echo "Changing to image : $IMG"
        echo $IMG > $CURR_IMG_FILE
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

if [[ "$HOUR" -ge $NIGHT_START ]]; then
    current_time_period="night"
elif [[ "$HOUR" -ge $EVENING_START ]]; then
    current_time_period="evening"
elif [[ "$HOUR" -ge $AFTERNOON_START ]]; then
    current_time_period="afternoon"
elif [[ "$HOUR" -ge $MORNING_START ]]; then
    current_time_period="morning"
else
    current_time_period="night"
fi

if [ "$1" != "-f" ] && [ -n "$CURR_IMG" ] && [[ $(basename $CURR_IMG) =~ "$current_time_period" ]]
then
    write_to_log "The wallpaper doesn't need to change."
    exit 0
fi

change_wallpaper $current_time_period
