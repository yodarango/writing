#!/bin/bash

# Function to create a .txt file by stripping HTML tags from a .html file
create_txt_from_html() {
    local dir="$1"

    # Get the name of the parent directory
    local parent_dir=$(basename "$dir")

    # Check if the .html file exists
    if [ -f "$dir/$parent_dir.html" ]; then
        # Create the .txt file by stripping HTML tags from the .html file
        echo "Creating $parent_dir.txt by stripping HTML content from $parent_dir.html in $dir"
        sed 's/<[^>]*>//g' "$dir/$parent_dir.html" > "$dir/$parent_dir.txt"
        echo "$parent_dir.txt has been created in $dir."
    else
        echo "Cannot create $parent_dir.txt in $dir because $parent_dir.html does not exist."
    fi
}

# Loop through all passed directories and create .txt files where needed
for dir in "$@"; do
    if [ -d "$dir" ]; then
        create_txt_from_html "$dir"
    else
        echo "The path $dir is not a valid directory."
    fi
done
