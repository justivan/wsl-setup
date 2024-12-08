#!/bin/bash

echo "Waiting for network to initialize..."
sleep 5  # Wait for 5 seconds

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install GitHub CLI if not installed
if ! command -v gh &>/dev/null; then
    echo "Installing GitHub CLI..."
    sudo apt install -y gh
fi

# Authenticate with GitHub
echo "Authenticating with GitHub..."
sudo -u $USER -i gh auth login --web

# Configure Git
echo "Configuring Git..."
git config --global user.name "justivan"
git config --global user.email "justivan.dev@gmail.com"
git config --global core.editor "code --wait"
git config --global core.autocrlf input

# Install Python development tools
sudo apt install -y python3-dev python3-venv python3-pip libpq-dev

# Proceed with further setup
echo "Bootstrap process complete."
