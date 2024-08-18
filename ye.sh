#!/bin/bash

# Configuration
START=1         # Starting number for the folders
END=18           # Ending number for the folders
PREFIX="disk" # Prefix for folder names

# Create folders
for (( i=$START; i<=$END; i++ ))
do
    folder_name="${PREFIX}${i}"
    mkdir -p "$folder_name"
    echo "Created folder: $folder_name"
done

echo 
