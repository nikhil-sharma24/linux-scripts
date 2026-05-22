#!/usr/bin/env bash

set -e

BACKUP_DIR="/home/nikhil/Desktop/linux_scripts/key-bindings"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Backing up GNOME keybindings..."

dconf dump /org/gnome/desktop/wm/keybindings/ \
  > "$BACKUP_DIR/wm-keybindings.dconf"

dconf dump /org/gnome/settings-daemon/plugins/media-keys/ \
  > "$BACKUP_DIR/media-keys.dconf"

dconf dump /org/gnome/shell/keybindings/ \
  > "$BACKUP_DIR/shell-keybindings.dconf"

dconf dump /org/gnome/mutter/keybindings/ \
  > "$BACKUP_DIR/mutter-keybindings.dconf"

dconf dump /org/gnome/shell/extensions/tiling-assistant/ \
  > "$BACKUP_DIR/tiling-assistant.dconf"

echo ""
echo "Backup completed successfully."
echo "Location: $BACKUP_DIR"