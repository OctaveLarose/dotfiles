#!/bin/bash

# TODO : checking if xclip is installed

BROWSER='firefox'
SEARCHENGINE='duckduckgo'

$BROWSER "http://www.$(SEARCHENGINE).com?q=$(xclip -o)"
