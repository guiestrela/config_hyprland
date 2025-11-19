#!/bin/bash

# Define the source of your backup (adjust as needed)
# This assumes you know the specific backup directory you want to restore from
SOURCE_BACKUP_DIR="$HOME/Documents/config_hyprland/hyprland_config_backup" # Replace with actual backup directory

# Check if the source backup directory exists
if [ ! -d "$SOURCE_BACKUP_DIR" ]; then
    echo "Error: Backup directory '$SOURCE_BACKUP_DIR' not found."
    exit 1
fi

# Restore Hyprland config:want
cp "$SOURCE_BACKUP_DIR/monitors.conf" "$HOME/.config/hypr/monitors.conf"
cp "$SOURCE_BACKUP_DIR/bindings.conf" "$HOME/.config/hypr/bindings.conf"
cp "$SOURCE_BACKUP_DIR/looknfeel.conf" "$HOME/.config/hypr/looknfeel.conf"
cp "$SOURCE_BACKUP_DIR/config.jsonc" "$HOME/.config/waybar/config.jsonc"
cp "$SOURCE_BACKUP_DIR/style.css" "$HOME/.config/waybar/style.css"
cp "$SOURCE_BACKUP_DIR/weather.sh" "$HOME/.config/waybar/scripts/weather.sh"

chmod +x "$HOME/.config/waybar/scripts/weather.sh"

# Optional: Restore other relevant configurations
# Example:
# cp -r "$SOURCE_BACKUP_DIR/waybar" "$HOME/.config/"
# cp -r "$SOURCE_BACKUP_DIR/rofi" "$HOME/.config/"
# cp -r "$SOURCE_BACKUP_DIR/kitty" "$HOME/.config/"
cp -r "SOURCE_BACKUP_DIR/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"


echo "Hyprland configuration restored from: $SOURCE_BACKUP_DIR"
echo "You may need to reload Hyprland (hyprctl reload) or restart your session for changes to take full effect."
