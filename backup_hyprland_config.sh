#!/bin/bash

# Define backup directory
BACKUP_DIR="$HOME/Documents/config_hyprland/hyprland_config_backup"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Copy Hyprland config
cp "$HOME/.config/hypr/monitors.conf" "$BACKUP_DIR/"
cp "$HOME/.config/hypr/bindings.conf" "$BACKUP_DIR/"
cp "$HOME/.config/hypr/looknfeel.conf" "$BACKUP_DIR/"
cp "$HOME/.config/waybar/config.jsonc" "$BACKUP_DIR/"
cp "$HOME/.config/waybar/style.css" "$BACKUP_DIR/"
cp "$HOME/.config/waybar/scripts/weather.sh" "$BACKUP_DIR/"

# Optional: Copy other relevant configurations (e.g., Waybar, Rofi, Kitty)
# Example:
# cp -r "$HOME/.config/waybar" "$BACKUP_DIR/"
# cp -r "$HOME/.config/rofi" "$BACKUP_DIR/"
# cp -r "$HOME/.config/kitty" "$BACKUP_DIR/"
cp -r "$HOME/.config/alacritty/alacritty.toml" "$BACKUP_DIR/"

echo "Hyprland configuration backed up to: $BACKUP_DIR"
