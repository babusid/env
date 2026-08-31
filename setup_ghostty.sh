#!/bin/bash

# Create the Ghostty config directory if it doesn't exist
mkdir -p ~/.config/ghostty/
mkdir -p ~/.config/ghostty/themes/

# Create a symbolic link from the repo's ghostty_config to the Ghostty config location
ln -sf $(pwd)/ghostty_config ~/.config/ghostty/config
ln -sf $(pwd)/ghostty_theme ~/.config/ghostty/themes/everforest_dark


echo "Ghostty config setup complete."
