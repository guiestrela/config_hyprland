#!/bin/bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define backup directory
BACKUP_DIR="$HOME/Documents/hyprland_config_backup_$(date +%Y%m%d_%H%M%S)"
HYPRLAND_CONFIG="$HOME/.config/hypr"
ALACRITTY_CONFIG="$HOME/.config/alacritty"

# Error handling
trap 'echo -e "${RED}Error: Backup failed!${NC}"; exit 1' ERR

# Create backup directory
echo -e "${YELLOW}Creating backup directory...${NC}"
mkdir -p "$BACKUP_DIR"

# Function to safely copy files
copy_file() {
    local source="$1"
    local dest="$2"
    if [ -f "$source" ]; then
        cp "$source" "$dest" && echo -e "${GREEN}✓${NC} Backed up: $(basename "$source")"
    else
        echo -e "${YELLOW}⚠${NC} Skipped (not found): $source"
    fi
}

# Copy Hyprland config files
echo -e "${YELLOW}Backing up Hyprland configuration...${NC}"
copy_file "$HYPRLAND_CONFIG/hyprland.conf" "$BACKUP_DIR/"
copy_file "$HYPRLAND_CONFIG/monitors.conf" "$BACKUP_DIR/"
copy_file "$HYPRLAND_CONFIG/bindings.conf" "$BACKUP_DIR/"
copy_file "$HYPRLAND_CONFIG/looknfeel.conf" "$BACKUP_DIR/"

# Copy Alacritty config
echo -e "${YELLOW}Backing up Alacritty configuration...${NC}"
copy_file "$ALACRITTY_CONFIG/alacritty.toml" "$BACKUP_DIR/"

# Optional: Copy other relevant configurations
# Uncomment to enable:
# mkdir -p "$BACKUP_DIR/waybar" && cp -r "$HOME/.config/waybar/"* "$BACKUP_DIR/waybar/" 2>/dev/null && echo -e "${GREEN}✓${NC} Backed up: waybar" || true
# mkdir -p "$BACKUP_DIR/rofi" && cp -r "$HOME/.config/rofi/"* "$BACKUP_DIR/rofi/" 2>/dev/null && echo -e "${GREEN}✓${NC} Backed up: rofi" || true

echo ""
echo -e "${GREEN}✓ Hyprland configuration backed up to:${NC}"
echo -e "  ${GREEN}$BACKUP_DIR${NC}"
