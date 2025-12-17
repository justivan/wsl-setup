#!/bin/bash

set -euo pipefail

# Install python development tools
sudo apt install -y python3-dev python3-venv python3-pip pipx libpq-dev

# Install uv (Astral's Python package manager)
echo "Installing uv..."
pipx install uv

# Install GitHub CLI if not installed
if ! command -v gh &>/dev/null; then
    echo "Installing GitHub CLI..."
    sudo apt install -y gh
fi

# Authenticate with GitHub (only if not already authenticated)
echo "Authenticating with GitHub..."
if ! gh auth status &>/dev/null; then
    gh auth login
else
    echo "Already authenticated with GitHub."
fi

# Configure Git
echo "Configuring Git..."
git config --global user.name "Ivan Ian Orara"
git config --global user.email "25910156+justivan@users.noreply.github.com"
git config --global core.editor "code --wait"
git config --global core.autocrlf input

# Configure Bash to show Git branch in prompt (idempotent)
echo "Configuring Bash to show Git branch..."
if ! grep -q "parse_git_branch" ~/.bashrc; then
    cat >> ~/.bashrc << 'EOF'

# Show Git branch in Bash prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(parse_git_branch)\[\033[00m\] \$ '
EOF
fi

# Reload .bashrc to apply changes
source ~/.bashrc

# Install Node.js using nvm (Node Version Manager)
echo "Installing Node.js..."

# Install nvm if it's not installed
if ! command -v nvm &>/dev/null; then
    echo "nvm not found, installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# Source nvm for the current session
export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"

nvm install --lts
nvm use --lts
nvm alias default node

# Finish the script
echo "Bootstrap process complete."
