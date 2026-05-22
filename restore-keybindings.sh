#!/usr/bin/env bash

set -e

BACKUP_DIR="/home/nikhil/Desktop/linux_scripts/key-bindings"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Backup directory not found:"
  echo "$BACKUP_DIR"
  exit 1
fi

echo "Restoring GNOME keybindings..."

[ -f "$BACKUP_DIR/wm-keybindings.dconf" ] && \
dconf load /org/gnome/desktop/wm/keybindings/ \
  < "$BACKUP_DIR/wm-keybindings.dconf"

[ -f "$BACKUP_DIR/media-keys.dconf" ] && \
dconf load /org/gnome/settings-daemon/plugins/media-keys/ \
  < "$BACKUP_DIR/media-keys.dconf"

[ -f "$BACKUP_DIR/shell-keybindings.dconf" ] && \
dconf load /org/gnome/shell/keybindings/ \
  < "$BACKUP_DIR/shell-keybindings.dconf"

[ -f "$BACKUP_DIR/mutter-keybindings.dconf" ] && \
dconf load /org/gnome/mutter/keybindings/ \
  < "$BACKUP_DIR/mutter-keybindings.dconf"

[ -f "$BACKUP_DIR/tiling-assistant.dconf" ] && \
dconf load /org/gnome/shell/extensions/tiling-assistant/ \
  < "$BACKUP_DIR/tiling-assistant.dconf"

echo ""
echo "Restore completed."
echo "Logout/login recommended on Wayland."