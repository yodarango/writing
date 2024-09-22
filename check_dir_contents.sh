#!/bin/bash

# Set the base path
base_path="/Users/yodarango/Desktop/repos/writing/app"

# ANSI color code for green
green='\033[0;32m'
# ANSI color code to reset color
reset='\033[0m'

# Traverse each directory under the base path, excluding .git, from_iNote, and the base path itself
find "$base_path" -type d \( ! -path "$base_path" ! -path "*/.git*" ! -path "*/from_iNote*" \) | while read -r dir; do
    # Check if the directory contains any files (excluding directories) in its direct children
    file_count=$(find "$dir" -maxdepth 1 -mindepth 1 -type f | wc -l)

    # Only check for the .txt file if the directory contains actual files (not just subdirectories)
    if [ "$file_count" -gt 0 ]; then
        # Get the relative path by stripping the base path
        relative_path="${dir#$base_path/}"

        # Get the name of the parent directory
        parent_dir=$(basename "$dir")

        # Check if the .txt file is missing and if the .html file with the same name exists
        if [ ! -f "$dir/$parent_dir.txt" ] && [ -f "$dir/$parent_dir.html" ]; then
            # Print the missing directory in green and its contents
            echo -e "${green}Directory '$relative_path' is missing $parent_dir.txt but has $parent_dir.html${reset}"
            echo "Contents of '$relative_path':"
            ls -1 "$dir" # List the contents of the directory
            echo
            echo "--------------------------------------"
            echo
        fi
    fi
done
