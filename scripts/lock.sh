#!/bin/bash

# Define the source and destination directories
SOURCE_DIR="$HOME/.wallpapers/"
DEST_DIR="$HOME/.wallpapers/hyprlock/"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

# Check if destination directory exists, create it if not
if [ ! -d "$DEST_DIR" ]; then
  mkdir -p "$DEST_DIR"
fi

# Get a list of files in the source directory
FILES=("$SOURCE_DIR"/*)

# Check if there are files in the source directory
if [ ${#FILES[@]} -eq 0 ]; then
  echo "No files found in the source directory: $SOURCE_DIR"
  exit 1
fi

# Choose a random file
RANDOM_FILE="${FILES[RANDOM % ${#FILES[@]}]}"

# Copy the random file to the destination directory
cp "$RANDOM_FILE" "$DEST_DIR/wall.png"

echo "Copied $(basename "$RANDOM_FILE") to $DEST_DIR"
hyprlock
