#!/bin/bash
#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file_path> <output_prefix>"
    exit 1
fi

# Configuration from arguments
FILE_PATH="$1"      # Path to the file you want to split
CHUNK_SIZE="120K"    # Size of each chunk (e.g., 10M for 10 megabytes)
OUTPUT_PREFIX="$2" # Prefix for the output files

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' does not exist."
    exit 1
fi

# Split the file into chunks
split -b "$CHUNK_SIZE" "$FILE_PATH" "$OUTPUT_PREFIX"

# Check if split was successful
if [ $? -eq 0 ]; then
    echo "File split successfully."
else
    echo "Error: File split failed."
    exit 1
fi

chunk_files=(${OUTPUT_PREFIX}*)

NUM_CHUNKS=${#chunk_files[@]}
# Configuration
START=1         # Starting number for the folders
END=$NUM_CHUNKS       # Ending number for the folders
PREFIX="disk" # Prefix for folder names
# Create folders
cp "template.lua" "read.lua"
for (( i=$START; i<=$END; i++ ))
do
    folder_name="${PREFIX}${i}"
    mkdir -p "$folder_name"
    echo "Created folder: $folder_name"
    mv "${chunk_files[i-1]}" "$folder_name/"
    echo "print(\"Playing disk ${i}\")" >> "read.lua"
    echo "play_sound(\"$folder_name/${chunk_files[i-1]}\")" >> "read.lua"
done

mv "disk1/" "disk/"

echo
