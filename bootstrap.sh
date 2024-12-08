#!/bin/bash

# Install python development tools
sudo apt install -y python3-dev python3-venv python3-pip libpq-dev

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
curl -fsSL --max-time 30 https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Sleep for 5 seconds to allow the installation process to complete
sleep 5

# Path to the .zshrc file (using $ZSH which is already defined)
ZSHRC="$HOME/.zshrc"

# The desired ZSH theme
THEME="terminalparty"

# Check if the .zshrc file exists and ensure Oh My Zsh installation is complete
if [[ -f "$ZSHRC" ]]; then
    echo "Oh My Zsh installed successfully. Now updating theme..."

    # Use sed to replace any existing ZSH_THEME assignment with the new theme
    sed -i "s|^ZSH_THEME=.*$|ZSH_THEME=\"$THEME\"|" "$ZSHRC"

    # If no ZSH_THEME was found, append it to the file
    if ! grep -q "^ZSH_THEME=" "$ZSHRC"; then
        echo "ZSH_THEME=\"$THEME\"" >> "$ZSHRC"
    fi

    # Start a new zsh session for the user
    echo "Launching a new zsh session..."
    zsh

else
    echo "$ZSHRC not found. Please ensure you have a .zshrc file."
fi

# Proceed with further setup
echo "Bootstrap process complete."
