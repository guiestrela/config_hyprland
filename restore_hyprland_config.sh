#!/bin/bash

# Install apps

sudo pacman -S gimp thunderbird bluez-utils bitwarden bitwarden-cli

yay -S visual-studio-code-bin spotify discord anydesk-bin


# Define the source of your backup (adjust as needed)
# This assumes you know the specific backup directory you want to restore from
SOURCE_BACKUP_DIR="$HOME/Documents/hyprland_config_backup_YYYYMMDD_HHMMSS" # Replace with actual backup directory

# Check if the source backup directory exists
if [ ! -d "$SOURCE_BACKUP_DIR" ]; then
    echo "Error: Backup directory '$SOURCE_BACKUP_DIR' not found."
    exit 1
fi

# Restore Hyprland config
cp "$SOURCE_BACKUP_DIR/hyprland.conf" "$HOME/.config/hypr/"
cp "$SOURCE_BACKUP_DIR/monitors.conf" "$HOME/.config/hypr/monitors.conf"
cp "$SOURCE_BACKUP_DIR/bindings.conf" "$HOME/.config/hypr/bindings.conf"
cp "$SOURCE_BACKUP_DIR/looknfeel.conf" "$HOME/.config/hypr/looknfeel.conf"

# Optional: Restore other relevant configurations
# Example:

cp -r "SOURCE_BACKUP_DIR/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"


echo "Hyprland configuration restored from: $SOURCE_BACKUP_DIR"
echo "You may need to reload Hyprland (hyprctl reload) or restart your session for changes to take full effect."
