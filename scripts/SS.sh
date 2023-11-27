#!/bin/zsh

formatted_date=$(date +'%S-%M-%H-%d-%m-%y')
output_string="$HOME/Pictures/Screenshot-${formatted_date}.png"

grim -g "$(slurp -o -r -c '#ff0000ff')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$HOME/Pictures/Screenshot-$(date +'%S-%M-%H-%d-%m-%y').png

notify-send --urgency=low -t 3000 "Screenshot saved at Screenshot-$formatted_date"

