#!/bin/bash

echo "Waiting for network to initialize..."
sleep 5  # Wait for 5 seconds

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Path to the .zshrc file (using $ZSH which is already defined)
ZSHRC="$HOME/.zshrc"

# The desired ZSH theme
THEME="terminalparty"

# Check if the .zshrc file exists
if [[ -f "$ZSHRC" ]]; then
    # Update the ZSH_THEME in .zshrc if it exists
    echo "Updating ZSH_THEME in $ZSHRC to '$THEME'..."
    
    # Use sed to replace any existing ZSH_THEME assignment, directly referencing $ZSH
    sed -i "s|^ZSH_THEME=.*$|ZSH_THEME=\"$THEME\"|" "$ZSHRC"
    
    # If no ZSH_THEME was found, append it to the file
    if ! grep -q "^ZSH_THEME=" "$ZSHRC"; then
        echo "ZSH_THEME=\"$THEME\"" >> "$ZSHRC"
    fi

    exec zsh

else
    echo "$ZSHRC not found. Please ensure you have a .zshrc file."
fi


# Proceed with further setup
echo "Bootstrap process complete."
