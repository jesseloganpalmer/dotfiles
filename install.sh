#!/bin/bash
set -e

echo "=== Dotfiles Bootstrap ==="

# Install starship prompt
if ! command -v starship &>/dev/null; then
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "Starship already installed."
fi

# Install stow
if ! command -v stow &>/dev/null; then
    echo "Installing stow..."
    sudo apt install -y stow
else
    echo "Stow already installed."
fi

# Install uv (Python package manager)
if ! command -v uv &>/dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv already installed."
fi

# Stow dotfiles
echo "Stowing dotfiles..."
cd "$(dirname "$0")"
stow . -t ~

# Remind about secrets
echo ""
echo "=== MANUAL STEPS ==="
echo "1. Create ~/.bashrc_secrets with your API keys:"
echo "   export UV_INDEX_GITLAB_USERNAME=..."
echo "   export UV_INDEX_GITLAB_PASSWORD=..."
echo ""
echo "2. Source your bashrc:"
echo "   source ~/.bashrc"
echo ""
echo "Done!"
