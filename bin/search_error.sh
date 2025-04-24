#!/bin/bash

BROWSER='firefox'
#SEARCHENGINE='google'
SEARCHENGINE='duckduckgo'

# if ! command -v xclip &> /dev/null; then
#     echo "Missing xclip, script can't work."
#     exit 1
# fi

hexify_for_google() {
    local hex_string=""

    for ((i = 0; i < ${#1}; i++)); do
        char="${1:$i:1}"
        hex_value=$(printf "%02x" "'$char")
        hex_string+="%$hex_value"
    done

    # Replace spaces with '+'
    echo "${hex_string//%2b/+}"
#    echo "$hex_string"
}

# clipboard_content=$(xclip -o | tr ' ' '+')
clipboard_content=$(wl-copy -o | tr ' ' '+')
hexified_content=$(hexify_for_google "$clipboard_content")

$BROWSER "http://www.$SEARCHENGINE.com/?q=$hexified_content"
