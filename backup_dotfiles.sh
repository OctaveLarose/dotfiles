MSG_COLOR='\033[0;32m'
NO_COLOR='\033[0m'

echo -e "${MSG_COLOR}### Backing up rc files...${NO_COLOR}"
cp -v ~/.*rc .

echo -e "${MSG_COLOR}\n### Backing up personal scripts...${NO_COLOR}"
cp -rv ~/bin .

CONFIG_LIST=("neofetch" "rofi")

echo -e "${MSG_COLOR}\n### Backing up config settings...${NO_COLOR}"
for cfg in "${CONFIG_LIST[@]}"
do
    cp -rv ~/.config/$cfg ./config
done
