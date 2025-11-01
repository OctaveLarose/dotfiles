#!/bin/bash

MSG_COLOR='\033[0;32m'
NO_COLOR='\033[0m'

echo -e "${MSG_COLOR}### Backing up rc files...${NO_COLOR}"
for file in ~/.*rc; do
  if [ "$file" != "$HOME/.dmrc" ]; then
    cp -v "$file" .
  fi
done

echo -e "${MSG_COLOR}\n### Backing up gitconfig...${NO_COLOR}"
cp -v ~/.gitconfig .
echo "Done."

echo -e "${MSG_COLOR}\n### Backing up crontab...${NO_COLOR}"
crontab -l > crontab
echo "Done."

BIN_LIST=("auto_autorandr.sh" "brightness_adjust.sh" "change_wallpapers.sh" "i3_window_finder.py" "i3_lock_screen.sh" "open_work_apps.sh" "search_error_wayland.sh" "search_error_xorg.sh" "swaylock" "sway_wrapper.sh" "video_dl" "window_killer")

echo -e "${MSG_COLOR}\n### Backing up personal scripts...${NO_COLOR}"
find ./bin ! -name 'README.md' -type f -exec rm -f {} +
for bin_name in "${BIN_LIST[@]}"
do
    cp -rv ~/bin/$bin_name ./bin/$bin_name > /dev/null
done

echo -e "${MSG_COLOR}\n### Backing up wallpapers...${NO_COLOR}"
rm -rf ./wallpapers && mkdir ./wallpapers && cp -rf ~/Pictures/time_wallpapers/* ./wallpapers/ && echo "Done."

CONFIG_LIST=("neofetch" "rofi" "dunst" "i3" "polybar" "sway" "waybar" "galendae" "autorandr" "nushell" "libinput-gestures.conf" "onedrive/config" "redshift" "nvim" "neovide" "kitty" "kanshi" "nwg-bar")

echo -e "${MSG_COLOR}\n### Backing up config settings...${NO_COLOR}"
for cfg in "${CONFIG_LIST[@]}"
do
    echo -n "$cfg: ..."
    rm -rf config/$cfg
    mkdir -p config/`dirname $cfg`
    cp -rv ~/.config/$cfg ./config/$cfg > /dev/null
    echo "Done."
done
