#!/bin/bash

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
gh auth login --web

# Proceed with further setup
echo "Bootstrap process complete."
