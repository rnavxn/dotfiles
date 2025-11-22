#!/bin/bash

hyprctl clients -j | jq '.[] | select(.workspace.name | startswith("special") | not) | .title' | tr '\n' ' '