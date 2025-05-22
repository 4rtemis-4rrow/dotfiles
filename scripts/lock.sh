#!/bin/bash

SOURCE_DIR="$HOME/.wallpapers/"
DEST_DIR="$HOME/.wallpapers/hyprlock/"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
  mkdir -p "$DEST_DIR"
fi

FILES=("$SOURCE_DIR"/*)

if [ ${#FILES[@]} -eq 0 ]; then
  echo "No files found in the source directory: $SOURCE_DIR"
  exit 1
fi

RANDOM_FILE="${FILES[RANDOM % ${#FILES[@]}]}"

cp "$RANDOM_FILE" "$DEST_DIR/wall.png"

echo "Copied $(basename "$RANDOM_FILE") to $DEST_DIR"
hyprlock
