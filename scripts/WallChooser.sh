#!/bin/bash

# Define the directory containing your wallpapers
WALLPAPER_DIR="$HOME/.wallpapers/"

# Get list of wallpaper files
wallpaper_files=$(find "$WALLPAPER_DIR" -type f)

# Prepare the list of images with their filenames for wofi
image_list=""
for wallpaper_file in $wallpaper_files; do
    image_list+="img:$wallpaper_file:text:\n"
done

# Use wofi to select a wallpaper
selected_image=$(echo -e "$image_list" | wofi --dmenu --prompt "Select Wallpaper" --allow-images true)
file_path=$(echo "$selected_image" | awk -F':' '{print $2}')

echo "$file_path"
# Check if a wallpaper was selected
if [ -n "$file_path" ]; then
    # Set the wallpaper using swaybg
    killall swaybg
    swaybg -i "$file_path" -m fill &
    disown
else
    echo "No wallpaper selected."
fi

