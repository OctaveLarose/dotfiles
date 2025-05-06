#!/bin/bash

BROWSER='firefox'
#SEARCHENGINE='google'
SEARCHENGINE='duckduckgo'

if ! command -v wl-paste &> /dev/null; then
    echo "Missing wl-paste, script can't work."
    exit 1
fi

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

clipboard_content=$(wl-paste | tr ' ' '+')
hexified_content=$(hexify_for_google "$clipboard_content")

$BROWSER "http://www.$SEARCHENGINE.com/?q=$hexified_content"
