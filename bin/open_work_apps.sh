#!/bin/bash

commands=(
    "firefox"
    "teams-for-linux"
    "superproductivity"
    "notion-app-enhanced"
    "chromium-browser --app="https://www.overleaf.com/project/67acab16bf3521e3e802bc1a" --class=WebApp-overleaf7413 --name=WebApp-overleaf7413 --user-data-dir=/home/octavel/.local/share/ice/profiles/overleaf7413"
#    "texstudio"
    "obsidian"
#    "$HOME/Programs/PhD/git_repos/Zotero_linux-x86_64/zotero"
    # "rustrover"
#    "code"
    "chromium-browser --app="https://teams.microsoft.com/v2/" --class=WebApp-Teams1298 --name=WebApp-Teams1298 --user-data-dir=/home/octavel/.local/share/ice/profiles/Teams1298"
    "spotify"
    "youtube-music"
)

for cmd in "${commands[@]}"; do
    pidof "${cmd%% *}" || $cmd &
    #pidof "$cmd" || "$cmd" &
done

# nvim
i3-msg 'workspace 4:IDE; exec --no-startup-id kitty nvim'
