#!/usr/bin/env bash

BROWSER='firefox'
SEARCHENGINE='google'
# SEARCHENGINE='duckduckgo'

if ! command -v wl-paste &> /dev/null; then
    echo "Missing wl-paste, script can't work."
    exit 1
fi

# Byte-safe URL-encoder (forces C locale so multi-byte UTF-8 chars are encoded byte-by-byte instead of getting mangled).
urlencode() {
    local LC_ALL=C
    local string="$1"
    local length="${#string}"
    local encoded="" c

    for (( i = 0; i < length; i++ )); do
        c="${string:i:1}"
        case "$c" in
            [a-zA-Z0-9.~_-]) encoded+="$c" ;;
            ' ')             encoded+="+" ;;
            *)               printf -v c '%%%02X' "'$c"
                              encoded+="$c" ;;
        esac
    done

    echo "$encoded"
}

clipboard_content=$(wl-paste --primary)

if [[ -z "$clipboard_content" ]]; then
    echo "Primary selection/clipboard is empty."
    exit 1
fi

encoded_content=$(urlencode "$clipboard_content")

case "$SEARCHENGINE" in
    google)
        url="https://www.google.com/search?q=${encoded_content}"
        ;;
    duckduckgo)
        url="https://duckduckgo.com/?q=${encoded_content}"
        ;;
    *)
        echo "Unknown search engine: $SEARCHENGINE"
        exit 1
        ;;
esac

"$BROWSER" "$url" &
disown
