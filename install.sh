#!/bin/bash

set -e
echo "🔁 Arch Linux Setup Restore Script"

BACKUP_DIR="$(pwd)"

# Install pacman packages
if [ -f "$BACKUP_DIR/pkglist.txt" ]; then
  echo "📦 Installing official packages"
  sudo pacman -Syu --needed - < "$BACKUP_DIR/pkglist.txt"
fi

# Install AUR packages
if [ -f "$BACKUP_DIR/aurlist.txt" ]; then
  if command -v yay >/dev/null 2>&1; then
    echo "🎯 Installing AUR packages with yay"
    yay -S --needed - < "$BACKUP_DIR/aurlist.txt"
  else
    echo "⚠️  AUR helper not found. Please install yay manually."
  fi
fi

# Restore dotfiles
[ -d "$BACKUP_DIR/dotfiles" ] && cp -v "$BACKUP_DIR/dotfiles/"* ~/

# Restore config folders
[ -d "$BACKUP_DIR/.config" ] && cp -r "$BACKUP_DIR/.config/"* ~/.config/

echo "✅ Restore complete! You may want to restart your session."
