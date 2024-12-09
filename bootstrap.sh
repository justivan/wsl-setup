#!/bin/bash

# Install python development tools
sudo apt install -y python3-dev python3-venv python3-pip pipx libpq-dev

# Install GitHub CLI if not installed
if ! command -v gh &>/dev/null; then
    echo "Installing GitHub CLI..."
    sudo apt install -y gh
fi

# Authenticate with GitHub
echo "Authenticating with GitHub..."
gh auth login

# Configure Git
echo "Configuring Git..."
git config --global user.name "justivan"
git config --global user.email "justivan.dev@gmail.com"
git config --global core.editor "code --wait"
git config --global core.autocrlf input

# Install and configure ohmyzsh
echo "Installing and configuring Oh My Zsh..."
sudo apt install -y zsh

# Install Oh My Zsh using the official install script
echo "Downloading and installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Proceed with further setup
echo "Bootstrap process complete."
