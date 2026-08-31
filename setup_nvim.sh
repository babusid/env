#!/bin/bash

# Remove the existing Neovim config directory and link this repo's config.
rm -rf ~/.config/nvim
ln -sf $(pwd)/nvim ~/.config/nvim

echo "Neovim config setup complete."
