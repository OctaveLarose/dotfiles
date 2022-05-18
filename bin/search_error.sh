#!/bin/bash

# TODO : checking if xclip is installed

BROWSER='firefox'
SEARCHENGINE='google'

# $BROWSER "http://www.$(SEARCHENGINE).com?q=$(xclip -o)"
$BROWSER "http://www.$SEARCHENGINE.com/search?q=$(xclip -o | tr ' ' '+')"
