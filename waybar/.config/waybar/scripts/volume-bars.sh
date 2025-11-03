#!/usr/bin/env bash

# Get current volume (0-100)
vol=$(pamixer --get-volume)

# Convert 0-100 to 0-7
level=$((vol * 7 / 100))

bars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)
echo "${bars[$level]}"
