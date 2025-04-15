
#!/bin/bash

# Function to cache configuration and data directories
cache_configs() {
    local dirs=("$@")
    local total_files=0
    local total_memory=0

    echo "Building file list..."
    # Find all files in all directories, excluding .git and .github, and save to a single list
    file_list=$(find "${dirs[@]}" -type f ! -path "*/.git/*" ! -path "*/.github/*")
    
    if [[ -n $file_list ]]; then
        echo "Running vmtouch on all files..."
        # Pass all files to a single vmtouch invocation
        vmtouch_output=$(echo "$file_list" | xargs vmtouch -vl 2>/dev/null)
        echo "$vmtouch_output" # Display vmtouch output

        # Parse vmtouch output for total files and memory usage
        if [[ $vmtouch_output =~ ([0-9]+)\s+files ]]; then
            total_files=${BASH_REMATCH[1]}
        fi
        if [[ $vmtouch_output =~ ([0-9]+)\s+pages ]]; then
            pages_cached=${BASH_REMATCH[1]}
            total_memory=$((pages_cached * 4 / 1024)) # Convert pages to MB (4 KB per page)
        fi

        echo "Total files cached: $total_files"
        echo "Total memory used: $total_memory MB"
    else
        echo "No files found to cache."
    fi
}

echo "Caching configuration and data directories..."

# List of directories to cache
directories=(
    "$HOME/.config/nvim"
    "$HOME/.local/share/nvim"
    "$HOME/.config/wezterm"
    "$HOME/.zen"
    "$HOME/.config/rofi"
)

# Cache all directories at once
cache_configs "${directories[@]}"

echo "Caching completed."
