#!/bin/bash

commands=(
    "firefox"
    "flatpak run com.super_productivity.SuperProductivity"
    "notion-app-enhanced"
    # "chromium-browser --app="https://www.overleaf.com/project/67acab16bf3521e3e802bc1a" --class=WebApp-overleaf7413 --name=WebApp-overleaf7413 --user-data-dir=/home/octavel/.local/share/ice/profiles/overleaf7413"
#    "texstudio"
    "flatpak run md.obsidian.Obsidian"
#    "$HOME/Programs/PhD/git_repos/Zotero_linux-x86_64/zotero"
    # "rustrover"
#    "code"
    "chromium-browser --app=https://teams.microsoft.com/v2/ --class=WebApp-Teams2161 --user-data-dir=/home/octavel/.local/share/ice/profiles/Teams2161"
    "flatpak run com.spotify.Client"
    "flatpak run com.github.th_ch.youtube_music"
)

for cmd in "${commands[@]}"; do
    pidof "${cmd%% *}" || $cmd &
    #pidof "$cmd" || "$cmd" &
done

# nvim
swaymsg 'workspace 4:IDE; exec --no-startup-id kitty nvim'
