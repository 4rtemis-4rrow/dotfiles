#!/bin/zsh

formatted_date=$(date +'%S-%M-%H-%d-%m-%y')
output_string="$HOME/Pictures/Screenshot-${formatted_date}.png"

grim -g "$(slurp)" - | swappy -f -

notify-send --urgency=low -t 3000 "Screenshot saved at Screenshot-$formatted_date"

