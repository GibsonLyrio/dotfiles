#!/bin/bash

# ---------------------------------------------------------------------------- #
# This script installs yay as AUR package manager, sets my zsh config, and more
# ---------------------------------------------------------------------------- #

# Exit on error
set -e

# ---------------------------------------------------------------------------- #
# Main script
# ---------------------------------------------------------------------------- #
echo "------------------------------------------------------------------------"
echo "[script] >>> Starting install script..."
echo "------------------------------------------------------------------------"

# Update pacman and install stow
sudo pacman -Syu --noconfirm --needed stow

# Clone dotfiles (if not already cloned)
if [ ! -d "$HOME/dotfiles" ]; then
  git clone https://github.com/GibsonLyrio/dotfiles.git "$HOME/dotfiles" || {
    echo "[script] >>> Failed to clone dotfiles."
    exit 1
  }
fi

# Create ~/.config directory (if not already exists)
if [ ! -d "$HOME/.config" ]; then
  cd $HOME
  mkdir .config || {
    echo "[script] >>> Failed to create .config directory."
    exit 1
  }
fi

# Change to dotfiles directory
cd "$HOME/dotfiles" || {
  echo "[script] >>> Failed to change to dotfiles directory."
  echo "[script] >>> HINT: Verify if dotfiles was cloned correctly."
  exit 1
}

# Stow configuration files
stow . || {
  echo "[script] >>> Failed to stow config."
  echo "[script] >>> HINT: If some target already exist,"
  echo "[script] >>>   move to a backup, and run again this script."
  exit 1
}

# ---------------------------------------------------------------------------- #
# Installing yay (AUR helper)
# ---------------------------------------------------------------------------- #
echo "------------------------------------------------------------------------"
echo "[script] >>> Installing yay..."
sudo pacman -S --noconfirm --needed base-devel git

if ! command -v yay &>/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git || {
    echo "[script] >>> Failed to clone yay."
    exit 1
  }
  cd yay
  makepkg -si --noconfirm || {
    echo "[script] >>> Failed to install yay."
    exit 1
  }
fi

# ---------------------------------------------------------------------------- #
# Using yay to install additional applications
# ---------------------------------------------------------------------------- #
echo "------------------------------------------------------------------------"
echo "[script] >>> Installing applications with yay..."

echo "[script] >>> AMD micro code, manual pages..."
yay -S --noconfirm --needed amd-ucode man-db man-pages texinfo

echo "------------------------------------------------------------------------"
echo "[script] >>> System utils..."
yay -S --noconfirm --needed pavucontrol waybar wofi swaync libnotify

echo "------------------------------------------------------------------------"
echo "[script] >>> Terminal utils..."
yay -S --noconfirm --needed alacritty btop neofetch zsh zinit ttf-meslo-nerd fzf

echo "------------------------------------------------------------------------"
echo "[script] >>> User apps..."
yay -S --noconfirm --needed discord firefox obsidian libreoffice

echo "------------------------------------------------------------------------"
echo "[script] >>> Dev tools..."
yay -S --noconfirm --needed neovim micro docker openssh asdf-vm

echo "------------------------------------------------------------------------"
echo "[script] >>> Hyprland utils..."
yay -S --noconfirm --needed hypridle hyprpaper hyprlock

# setting vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# ---------------------------------------------------------------------------- #
# Using cargo to install `exa` and `bat`
# ---------------------------------------------------------------------------- #
echo "------------------------------------------------------------------------"
echo "[script] >>> Installing 'exa' and 'bat'."
if ! command -v cargo &>/dev/null; then
  echo "[script] >>> Cargo not found, installing rust..."
  sudo pacman -S --noconfirm rust
fi

cargo install exa bat

# ---------------------------------------------------------------------------- #
# Final Steps
# ---------------------------------------------------------------------------- #
echo "------------------------------------------------------------------------"
echo "[script] >>> Install script finished!"
echo "[script] >>> Remember to set up new SSH keys and other important things."
echo "------------------------------------------------------------------------"

# ---------------------------------------------------------------------------- #
# End of script
# ---------------------------------------------------------------------------- #
