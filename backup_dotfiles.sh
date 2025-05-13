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

echo -e "${MSG_COLOR}\n### Backing up personal scripts...${NO_COLOR}"
find ./bin ! -name 'README.md' -type f -exec rm -f {} +
cp -rv ~/bin .

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
