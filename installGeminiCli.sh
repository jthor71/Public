#!/bin/bash

# Function to install NVM
install_nvm() {
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.bashrc"
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.bashrc"
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> "$HOME/.bashrc"
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Function to install Node.js using nvm
install_node() {
    echo "Installing Node.js..."
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm alias default lts/*
    nvm use default
}

# Check for Node.js and npm
if ! command -v node &> /dev/null
then
    echo "Node.js is not installed."
    # Check for nvm
    if [ -s "$HOME/.nvm/nvm.sh" ]; then
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    else
        install_nvm
    fi
    install_node
else
    echo "Node.js is already installed."
fi



echo "Node.js and npm are installed. Proceeding with gemini-cli installation."

# Install gemini-cli globally
npm install -g @google/gemini-cli

if [ $? -eq 0 ]; then
    echo "gemini-cli installed successfully!"
    echo "You can now run 'gemini' from your terminal."
    echo "The first time you run 'gemini', you will be prompted to authenticate."
    echo "IMPORTANT: Please restart your terminal or run 'source ~/.bashrc' to use the 'gemini' command."
else
    echo "Error: gemini-cli installation failed."
fi