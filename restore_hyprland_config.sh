#!/bin/bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration directories
HYPRLAND_CONFIG="$HOME/.config/hypr"
ALACRITTY_CONFIG="$HOME/.config/alacritty"

# Error handling
trap 'echo -e "${RED}Error: Restore failed!${NC}"; exit 1' ERR

# Function to find latest backup
find_latest_backup() {
    local latest_backup
    latest_backup=$(find "$HOME/Documents" -maxdepth 1 -type d -name "hyprland_config_backup_*" | sort -V | tail -n 1)
    echo "$latest_backup"
}

# Function to select backup directory
select_backup() {
    local backup_dir=""
    
    if [ $# -eq 1 ]; then
        backup_dir="$1"
    else
        # Try to find latest backup
        backup_dir=$(find_latest_backup)
        if [ -z "$backup_dir" ]; then
            echo -e "${RED}Error: No backup directory found!${NC}"
            echo "Usage: $0 [backup_directory_path]"
            exit 1
        fi
        echo -e "${YELLOW}Using latest backup: $backup_dir${NC}"
    fi
    
    if [ ! -d "$backup_dir" ]; then
        echo -e "${RED}Error: Backup directory not found: $backup_dir${NC}"
        exit 1
    fi
    
    echo "$backup_dir"
}

# Function to safely copy files
restore_file() {
    local source="$1"
    local dest="$2"
    local dest_dir=$(dirname "$dest")
    
    if [ -f "$source" ]; then
        mkdir -p "$dest_dir"
        cp "$source" "$dest" && echo -e "${GREEN}✓${NC} Restored: $(basename "$source")"
    else
        echo -e "${YELLOW}⚠${NC} Skipped (not found in backup): $(basename "$source")"
    fi
}

# Main execution
echo -e "${BLUE}Hyprland Configuration Restore${NC}"
echo "==============================="
echo ""

SOURCE_BACKUP_DIR=$(select_backup "$@")

# Restore Hyprland config
echo -e "${YELLOW}Restoring Hyprland configuration...${NC}"
restore_file "$SOURCE_BACKUP_DIR/hyprland.conf" "$HYPRLAND_CONFIG/hyprland.conf"
restore_file "$SOURCE_BACKUP_DIR/monitors.conf" "$HYPRLAND_CONFIG/monitors.conf"
restore_file "$SOURCE_BACKUP_DIR/bindings.conf" "$HYPRLAND_CONFIG/bindings.conf"
restore_file "$SOURCE_BACKUP_DIR/looknfeel.conf" "$HYPRLAND_CONFIG/looknfeel.conf"

# Restore Alacritty config
echo -e "${YELLOW}Restoring Alacritty configuration...${NC}"
restore_file "$SOURCE_BACKUP_DIR/alacritty.toml" "$ALACRITTY_CONFIG/alacritty.toml"

echo ""
echo -e "${GREEN}✓ Configuration restored from:${NC}"
echo -e "  ${GREEN}$SOURCE_BACKUP_DIR${NC}"
echo ""
echo -e "${YELLOW}Note:${NC} You may need to reload Hyprland with ${BLUE}hyprctl reload${NC} for changes to take full effect."
