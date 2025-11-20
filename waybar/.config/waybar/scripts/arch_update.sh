#!/usr/bin/env bash

# Detect AUR helper
if command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
elif command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
else
    echo "No AUR helper found"
    AUR_HELPER="sudo pacman"
    # exit 1
fi

# Run update
notifier="notify-send -u low -a System Update"

$notifier "Updating system..."

# You can also use --noconfirm if you want it fully auto.
kitty -e $AUR_HELPER -Syu

if [ $? -eq 0 ]; then
    $notifier "Update complete!"
else
    $notifier "Update failed!"
fi
