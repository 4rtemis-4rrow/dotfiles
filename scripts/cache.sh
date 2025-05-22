#!/bin/bash

cache_configs() {
    local dirs=("$@")
    local total_files=0
    local total_memory=0

    echo "Building file list..."
    file_list=$(find "${dirs[@]}" -type f ! -path "*/.git/*" ! -path "*/.github/*")
    
    if [[ -n $file_list ]]; then
        echo "Running vmtouch on all files..."
        vmtouch_output=$(echo "$file_list" | xargs vmtouch -vl 2>/dev/null)
        echo "$vmtouch_output"

        if [[ $vmtouch_output =~ ([0-9]+)\s+files ]]; then
            total_files=${BASH_REMATCH[1]}
        fi
        if [[ $vmtouch_output =~ ([0-9]+)\s+pages ]]; then
            pages_cached=${BASH_REMATCH[1]}
            total_memory=$((pages_cached * 4 / 1024))
        fi

        echo "Total files cached: $total_files"
        echo "Total memory used: $total_memory MB"
    else
        echo "No files found to cache."
    fi
}

echo "Caching configuration and data directories..."

directories=(
    "$HOME/.config/nvim"
    "$HOME/.local/share/nvim"
    "$HOME/.config/wezterm"
    "$HOME/.zen"
    "$HOME/.config/rofi"
)

cache_configs "${directories[@]}"

echo "Caching completed."
