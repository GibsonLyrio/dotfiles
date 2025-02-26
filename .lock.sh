#!/bin/bash

# Take a screenshot
scrot -o /tmp/screen.png

# Blur the screenshot
magick /tmp/screen.png -blur 0x5 /tmp/screen.png

# Draw a semi-transparent dark blue box with rounded corners
magick /tmp/screen.png -fill "#00008b" -draw "roundrectangle 700,505 1220,575 15,15" /tmp/screen.png

i3lock -i /tmp/screen.png
