#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [input_directory] [output_file]"
    exit 1
fi

INPUT_DIR=$1
OUTPUT_FILE=$2

# Ensure the input directory is an absolute path
ABS_INPUT_DIR=$(realpath "$INPUT_DIR")

# Change to the input directory
cd "$ABS_INPUT_DIR" || exit

# Ensure the output file is empty
: > "$OUTPUT_FILE"

# Initialize a temporary file to store the file content
TEMP_FILE_CONTENT=$(mktemp)

# Function to generate the project structure tree and collect file content
generate_tree_and_collect_content() {
    local dir="$1"
    local prefix="$2"

    echo "${prefix}|-- ${dir##*/}" >> "$OUTPUT_FILE"

    # List directories and exclude hidden directories
    find "$dir" -mindepth 1 -maxdepth 1 -type d ! -path '*/\.*' | sort | while IFS= read -r subdir; do
        generate_tree_and_collect_content "$subdir" "$prefix  "
    done

    # List files tracked by git in this directory and exclude hidden files
    git ls-files "$dir" | sort | while IFS= read -r file; do
        if [[ -f "$file" && "$file" != .* ]]; then
            echo "${prefix}    |-- ${file##*/}" >> "$OUTPUT_FILE"
            echo "========== $file ==========" >> "$TEMP_FILE_CONTENT"
            cat "$file" >> "$TEMP_FILE_CONTENT"
            echo -e "\n\n" >> "$TEMP_FILE_CONTENT"
        fi
    done
}

# Generate the tree structure at the beginning of the output file
echo "Project Structure:" >> "$OUTPUT_FILE"
generate_tree_and_collect_content "$ABS_INPUT_DIR" ""
echo >> "$OUTPUT_FILE"

# Append the collected file contents to the output file
cat "$TEMP_FILE_CONTENT" >> "$OUTPUT_FILE"

# Clean up the temporary file
rm "$TEMP_FILE_CONTENT"

echo "Compilation complete. Output file is $OUTPUT_FILE."
