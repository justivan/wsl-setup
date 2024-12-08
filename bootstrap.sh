#!/bin/bash

echo "Waiting for network to initialize..."
sleep 5  # Wait for 5 seconds

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install python development tools
sudo apt install -y python3-dev python3-venv python3-pip libpq-dev

# Install expect
sudo apt install -y expect

# Install GitHub CLI if not installed
if ! command -v gh &>/dev/null; then
    echo "Installing GitHub CLI..."
    sudo apt install -y gh
fi

# Configure Git
echo "Configuring Git..."
git config --global user.name "justivan"
git config --global user.email "justivan.dev@gmail.com"
git config --global core.editor "code --wait"
git config --global core.autocrlf input

# Install and configure ohmyzsh
echo "Installing and configuring Oh My Zsh..."
expect << EOF
spawn sh -c "curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh"
expect "Do you want to change your default shell to zsh? [Y/n]" { send "Y\r" }
expect eof
EOF

# Proceed with further setup
echo "Bootstrap process complete. Run 'gh auth login' to authenticate with GitHub."
