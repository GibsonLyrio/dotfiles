#!/bin/bash

# Take a screenshot
scrot -o /tmp/screen.png

# Blur the screenshot
magick /tmp/screen.png -blur 0x5 /tmp/screen.png

i3lock -i /tmp/screen.png
