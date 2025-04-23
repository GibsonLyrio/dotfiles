#!/usr/bin/bash

CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"

if [[ $(pidof wofi) ]]; then
    killall wofi
fi

wofi --conf "${CONFIG}" --style "${STYLE}"
