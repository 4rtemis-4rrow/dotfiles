#!/bin/zsh

grim -g "$(slurp -o -r -c '##ff0000ff')" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/Screenshot-$(date +'%y-%m-%d-%H-%M-%S').png
# grimblast --freeze save screen - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/Screenshot-$(date +'%S-%M-%H-%d-%m-%y').png
