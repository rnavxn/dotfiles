#!/usr/bin/env bash
set -e

notify() {
    notify-send -u low -a "System Update" -i system-software-update "$1"
}

# Detect AUR helper
if command -v paru >/dev/null 2>&1; then
    CMD=(paru -Syu)
elif command -v yay >/dev/null 2>&1; then
    CMD=(yay -Syu)
else
    # Fallback to pacman (system only, no AUR)
    CMD=(sudo pacman -Syu)
fi

notify "Updating system..."
kitty -e "${CMD[@]}"

if [ $? -eq 0 ]; then
    notify "Update complete!"
else
    notify "Update failed!"
fi