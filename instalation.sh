#!/bin/bash

# ---------------------------------------------------------------------------- #
# This script installs yay as AUR package manager, sets my zsh config, and more
# ---------------------------------------------------------------------------- #

# Exit on error
set -e

# ---------------------------------------------------------------------------- #
# Functions
# ---------------------------------------------------------------------------- #

# Function to create directories and stow configs
stow_configs() {
    local dirs=("alacritty" "awesome" "backgrounds" "micro" "nvim" "picom" "polybar" "rofi")

    # Loop through directories
    for dir in "${dirs[@]}"; do
        mkdir -p "$HOME/.config/$dir" || { echo "Failed to create $dir directory"; exit 1; }
        stow "$dir" -t "$HOME/.config/$dir" || { echo "Stow failed for $dir"; exit 1; }
    done
}

# ---------------------------------------------------------------------------- #
# Main Script
# ---------------------------------------------------------------------------- #

# Update system and install stow
sudo pacman -Syu --noconfirm stow

# Clone dotfiles (if not already cloned)
if [ ! -d "$HOME/dotfiles" ]; then
    git clone https://github.com/GibsonLyrio/dotfiles.git "$HOME/dotfiles" || { echo "Failed to clone dotfiles"; exit 1; }
fi

# Change to dotfiles directory
cd "$HOME/dotfiles" || { echo "Failed to change to dotfiles directory"; exit 1; }

# Stow configuration files
stow_configs

# ---------------------------------------------------------------------------- #
# Installing yay (AUR helper)
# ---------------------------------------------------------------------------- #
echo "Installing yay..."
sudo pacman -S --needed --noconfirm base-devel git neovim rust
if [ ! -d "/tmp/yay" ]; then
    cd /tmp
    git clone https://aur.archlinux.org/yay.git || { echo "Failed to clone yay"; exit 1; }
    cd yay
    makepkg -si --noconfirm || { echo "Failed to install yay"; exit 1; }
fi

# ---------------------------------------------------------------------------- #
# Using yay to install additional applications
# ---------------------------------------------------------------------------- #
echo "Installing applications with yay..."
yay -S --noconfirm neovim neofetch firefox zsh zinit ttf-meslo-nerd asdf-vm fzf obsidian libreoffice pavucontrol rofi micro picom polybar rofi

# setting vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Set zsh as the default shell
chsh -s /usr/bin/zsh

# ---------------------------------------------------------------------------- #
# Using cargo to install `exa` and `bat`
# ---------------------------------------------------------------------------- #
if ! command -v cargo &> /dev/null; then
    echo "Cargo not found, installing rust..."
    sudo pacman -S --noconfirm rust
fi

cargo install exa bat

# ---------------------------------------------------------------------------- #
# Final Steps
# ---------------------------------------------------------------------------- #
echo "Install script finished!"
echo "Remember to set up new SSH keys and other important things."

# ---------------------------------------------------------------------------- #
# End of script
# ---------------------------------------------------------------------------- #

