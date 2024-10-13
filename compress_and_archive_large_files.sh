#!/bin/bash

# Script to compress and archive large files in a specified directory
# Version: 1.0
# Last updated: Sun Oct 13, 2024

# Define base directory, archive path, and other parameters
BASE="Your_Directory_Path"
DAYS=15         # Not currently used, but reserved for potential future use
DEPTH=1          # Limit search depth for files
RUN=0            # Flag to control whether compression and moving should occur

# Check if the base directory exists
if [[ ! -d $BASE ]]; then
    echo "Error: Directory does not exist: $BASE"
    exit 1
fi

# Check if the archive directory exists; create it if not
if [[ ! -d $BASE/archive ]]; then
    echo "Archive directory does not exist. Creating it now..."
    mkdir "$BASE/archive" || { echo "Failed to create archive directory."; exit 1; }
    echo "Archive directory created: $BASE/archive"
fi

# Find and process large files in the specified directory
echo "Searching for files larger than 70M in $BASE..."
for file in $(find "$BASE" -maxdepth $DEPTH -type f -size +7k); do
    # Check if the RUN flag is set to 0 (for first-time execution)
    if [[ $RUN -eq 0 ]]; then
        echo "Compressing file: $file"
        
        # Compress the file
        gzip "$file" || { echo "Failed to compress file: $file"; exit 1; }

        # Move the compressed file to the archive directory
        mv "$file.gz" "$BASE/archive" || { echo "Failed to move $file.gz to archive"; exit 1; }
        
        echo "File $file successfully compressed and moved to $BASE/archive"
    fi
done 

echo "Script execution completed."

