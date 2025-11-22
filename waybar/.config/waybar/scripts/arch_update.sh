#!/usr/bin/env bash

set -e

notify() {
    notify-send -u low -a "System Update" -i "$2" "$1"
}

# Detect AUR helper
if command -v paru >/dev/null 2>&1; then
    CMD=(paru -Syu)
elif command -v yay >/dev/null 2>&1; then
    CMD=(yay -Syu)
else
    CMD=(sudo pacman -Syu)
fi

# Temp file to store exit code
STATUS_FILE="/tmp/update_status_$USER"
rm -f "$STATUS_FILE"

notify "Updating system..." "system-software-update"

# Run inside kitty and capture exit status
kitty -e bash -c "
    ${CMD[@]}
    echo \$? > $STATUS_FILE
"

# Read exit code
if [[ -f "$STATUS_FILE" ]]; then
    EXIT_CODE=$(cat "$STATUS_FILE")
else
    # Kitty killed (Ctrl+C before_script runs) → treat as fail
    EXIT_CODE=1
fi

if [[ $EXIT_CODE -eq 0 ]]; then
    notify "Update complete!" "dialog-ok"
else
    notify "Update failed!" "dialog-error"
fi