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
    mkdir -p "$HOME/.config/$dir" || {
      echo "Failed to create $dir directory"
      exit 1
    }
    stow "$dir" -t "$HOME/.config/$dir" || {
      echo "Stow failed for $dir"
      exit 1
    }
  done
}

# ---------------------------------------------------------------------------- #
# Main Script
# ---------------------------------------------------------------------------- #

# Update pacman and install stow
sudo pacman -Syu --noconfirm stow

# Clone dotfiles (if not already cloned)
if [ ! -d "$HOME/dotfiles" ]; then
  git clone https://github.com/GibsonLyrio/dotfiles.git "$HOME/dotfiles" || {
    echo "Failed to clone dotfiles"
    exit 1
  }
fi

# Change to dotfiles directory
cd "$HOME/dotfiles" || {
  echo "Failed to change to dotfiles directory"
  exit 1
}

# Add symbolic link to the /.zshrc
if [ -a "$HOME/.zshrc" ]; then
  rm -rf "$HOME/.zshrc"
fi
ln -s "$HOME/dotfiles/.zshrc" "$HOME/"

# Add symbolic link to the /.lock.sh
if [ -a "$HOME/.lock.sh" ]; then
  rm -rf "$HOME/.lock.sh"
fi
ln -s "$HOME/dotfiles/.lock.sh" "$HOME/"

# Add symbolic link to the /.xinitrc
if [ -a "$HOME/.xinitrc" ]; then
  rm -rf "$HOME/.xinitrc"
fi
ln -s "$HOME/dotfiles/.xinitrc" "$HOME/"

# Add symbolic link to the /.bash_profile
if [ -a "$HOME/.bash_profile" ]; then
  rm -rf "$HOME/.bash_profile"
fi
ln -s "$HOME/dotfiles/.bash_profile" "$HOME/"

# Stow configuration files
stow_configs

# ---------------------------------------------------------------------------- #
# Installing yay (AUR helper)
# ---------------------------------------------------------------------------- #
echo "Installing yay..."
sudo pacman -S --needed --noconfirm base-devel git neovim rust
if [ ! -d "/tmp/yay" ]; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git || {
    echo "Failed to clone yay"
    exit 1
  }
  cd yay
  makepkg -si --noconfirm || {
    echo "Failed to install yay"
    exit 1
  }
fi

# ---------------------------------------------------------------------------- #
# Using yay to install additional applications
# ---------------------------------------------------------------------------- #
echo "Installing applications with yay..."
yay -S --noconfirm amd-ucode man-db man-pages texinfo neovim neofetch docker openssh discord firefox zsh zinit ttf-meslo-nerd asdf-vm fzf obsidian libreoffice anki pavucontrol xclip rofi micro picom polybar rofi feh scrot i3lock imagemagick flameshot

# setting vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# ---------------------------------------------------------------------------- #
# Using cargo to install `exa` and `bat`
# ---------------------------------------------------------------------------- #
if ! command -v cargo &>/dev/null; then
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
