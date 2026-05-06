#!/usr/bin/env bash

# Enable Chrome touchpad swipe back/forward gestures on Wayland
# Chromium 147+ hides the flag UI but runtime feature still works.

DESKTOP_FILE="/usr/share/applications/google-chrome.desktop"
FEATURE="--enable-features=TouchpadOverscrollHistoryNavigation --ozone-platform=wayland"

if ! grep -q "TouchpadOverscrollHistoryNavigation" "$DESKTOP_FILE"; then
    sudo sed -i \
    "s|Exec=/usr/bin/google-chrome-stable|Exec=/usr/bin/google-chrome-stable $FEATURE|g" \
    "$DESKTOP_FILE"

    echo "✅ Chrome touchpad navigation enabled."
else
    echo "ℹ️ Feature already enabled."
fi

echo
echo "Restart Chrome completely."