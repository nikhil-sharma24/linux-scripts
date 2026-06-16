#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

GRUB_DIR=${1:-/boot/grub}
BACKUP_FILE="$GRUB_DIR/grub_bak.cfg"
TARGET_FILE="$GRUB_DIR/grub.cfg"

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

if [[ ! -f "$BACKUP_FILE" ]]; then
  echo "Backup file not found: $BACKUP_FILE"
  exit 1
fi

if [[ -f "$TARGET_FILE" ]]; then
  TIMESTAMP=$(date +%Y%m%d%H%M%S)
  mv -v "$TARGET_FILE" "$GRUB_DIR/grub.cfg.old.$TIMESTAMP"
fi

mv -v "$BACKUP_FILE" "$TARGET_FILE"
chmod 644 "$TARGET_FILE"

echo "Restored grub configuration from $BACKUP_FILE to $TARGET_FILE."
echo "Preserved previous grub.cfg as $GRUB_DIR/grub.cfg.old.$TIMESTAMP."
