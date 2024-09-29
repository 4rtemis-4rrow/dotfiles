#!/bin/zsh

grim -g "$(slurp -o -r -c '#ff0000ff')" - | satty --filename - --fullscreen --output-filename $HOME/Pictures/Screenshots/Screenshot-$(date +'%S-%M-%H-%d-%m-%y').png
