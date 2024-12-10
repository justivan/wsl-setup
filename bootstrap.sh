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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Node.js using nvm (Node Version Manager)
echo "Installing Node.js..."

# Install nvm if it's not installed
if ! command -v nvm &>/dev/null; then
    echo "nvm not found, installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    # Source nvm for the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

nvm install --lts
nvm use --lts
nvm alias default node

# Finish the script by switching to zsh (after everything is done)
echo "Switching to zsh..."
chsh -s $(which zsh)

# Proceed with further setup
echo "Bootstrap process complete."
