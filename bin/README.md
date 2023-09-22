# Scripts overview

## Useful to anyone

**change_wallpapers.sh**: changes the wallpaper depending on the time of the day. The time at which different wallpapers appear can be configured, there's the option to change the wallpaper depending on the weather, and a special rare wallpaper that can appear at anytime instead of the normal ones. Made to be ran as an hourly cron job (see my crontab), since I don't like the idea of leaving a wallpaper script running all the time and relying on `sleep`. Works on KDE 4/5 and i3; no dependencies except `feh` to set the wallpaper on i3 and `curl` to fetch the current weather.

**search_error.sh**: simple but tremendously useful when set to a keyboard shortcut. Googles anything selected (not even copied, just selected!), which has saved me literal hours over the past few years. Relies on `xclip`.

**window_killer**: a simple idea I don't see used often. Launching it then clicking any window will kill the process, which is great for hanging apps.

**i3_window_finder.py**: focuses on the workspace that has a window that matches the requested name.

## Others

**open_work_apps.sh**: opens most of the apps I use for work. My i3 config also opens them in the right workplaces. Set to a keyboard macro and often ran manually shortly after booting.

**i3_lock_screen.sh**: simple i3 lock screen script to show a blurred version of the desktop when locking it.

**video_dl**: small yt-dlp wrapper I use to download videos and rename them.

**auto_autorandr.sh**: updates my monitors/polybar with autorandr when I plug in/out an HDMI cable. A udev/systemd solution for that issue never quite worked, so I'm instead relying on a dumb bash script in userspace
