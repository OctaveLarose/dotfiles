#!/bin/bash

commands=(
    "firefox"
    "teams-for-linux"
    "superproductivity"
    "notion-app-enhanced"
#    "texstudio"
#    "obsidian"
#    "$HOME/Programs/PhD/git_repos/Zotero_linux-x86_64/zotero"
    "rustrover"
#    "code"
    "spotify"
    "youtube-music"
)

for cmd in "${commands[@]}"; do
    pidof "$cmd" || "$cmd" &
done

