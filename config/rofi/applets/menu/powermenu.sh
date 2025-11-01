#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="$HOME/.config/rofi/applets/menu/configs/rounded"
rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')
cpu=$($HOME/.config/rofi/bin/usedcpu)
memory=$($HOME/.config/rofi/bin/usedram)

shutdown=""
reboot=""
lock=""
suspend=""
logout=""

options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "󰥔  $uptime  |    $cpu  | ﬙  $memory " -dmenu -selected-row 0)"
case $chosen in
  $shutdown)
    systemctl poweroff
    ;;
  $reboot)
    systemctl reboot
    ;;
  $lock)
    $HOME/bin/swaylock.sh
    ;;
  $suspend)
    mpc -q pause
    amixer set Master mute
    systemctl suspend
    ;;
  $logout)
    swaymsg exit
    ;;
esac
