#!/bin/bash

MSG_COLOR='\033[0;32m'
WARN_COLOR='\033[0;33m'
NO_COLOR='\033[0m'

confirm_and_copy() {
    local src=$1
    local dest=$2
    if [ -e "$dest" ]; then
        read -p "Overwrite $dest? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return
        fi
    fi

    # not sure if there isn't a better solution than this, but whatever works
    if [ -d "$src" ]; then
        cp -rv "$src"/* "$dest"/ 
    else
        cp -rv "$src" "$dest"
    fi
}

echo -e "${MSG_COLOR}### Restoring rc files...${NO_COLOR}"
for file in .*rc; do
    confirm_and_copy "$file" "$HOME/$file"
done

echo -e "${MSG_COLOR}\n### Restoring gitconfig...${NO_COLOR}"
confirm_and_copy .gitconfig ~/.gitconfig

echo -e "${MSG_COLOR}\n### No crontab backup at the moment (TODO!)...${NO_COLOR}"

echo -e "${MSG_COLOR}\n### Restoring personal scripts...${NO_COLOR}"
mkdir -p ~/bin
for bin_name in bin/*; do 
    confirm_and_copy $bin_name ~/bin/$(basename "$bin_name") 
done

echo -e "${MSG_COLOR}\n### Restoring config settings...${NO_COLOR}"
for cfg in config/*/; do
    dir_name=$(basename "$cfg")
    confirm_and_copy "$cfg" "$HOME/.config/$dir_name/"
done

echo -e "${MSG_COLOR}\n### Restore complete!${NO_COLOR}"
