#!/bin/bash

function usage() {
    echo "Usage: extract [-h] [-r] [-v] file [file...]"
    echo "Options:"
    echo "  -h          Display this help message"
    echo "  -r          Recursively unpack files in directories"
    echo "  -v          Verbose output (echo decompressed and skipped files)"
    exit 0
}

function decompress_file() {
    local file=$1

    # Determine the file type
    type=$(file -b "$file")
    case "$type" in
        *gzip*)
            gunzip -f "$file" && return 0
            ;;
        *bzip2*)
            bunzip2 -f "$file" && return 0
            ;;
        *Zip*)
            unzip -o "$file" -d "$(dirname "$file")" && return 0
            ;;
        *compress*)
            uncompress -f "$file" && return 0
            ;;
        *)
            return 1
            ;;
    esac
    return 1
}

function process_file_or_directory() {
    local target=$1

    if [ -f "$target" ]; then
        decompress_file "$target"
        if [ $? -eq 0 ]; then
            ((DECOMPRESSED++))
            [ "$VERBOSE" = true ] && echo "Decompressed: $target"
        else
            ((NOT_DECOMPRESSED++))
            [ "$VERBOSE" = true ] && echo "Skipped (not compressed): $target"
        fi
    elif [ -d "$target" ] && [ "$RECURSIVE" = true ]; then
        for item in "$target"/*; do
            process_file_or_directory "$item"
        done
    else
        ((NOT_DECOMPRESSED++))
        [ "$VERBOSE" = true ] && echo "Skipped (not a valid file or directory): $target"
    fi
}

# Default values
RECURSIVE=false
VERBOSE=false
DECOMPRESSED=0
NOT_DECOMPRESSED=0

# Parse options
while getopts "hrv" opt; do
    case $opt in
        h)
            usage
            ;;
        r)
            RECURSIVE=true
            ;;
        v)
            VERBOSE=true
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

# Check if at least one file is provided
if [ $# -eq 0 ]; then
    echo "Error: No files provided."
    usage
fi

# Process each file or directory
for target in "$@"; do
    process_file_or_directory "$target"
done

# Summary
echo "Archives decompressed: $DECOMPRESSED"
echo "Files not decompressed: $NOT_DECOMPRESSED"
exit $NOT_DECOMPRESSED
