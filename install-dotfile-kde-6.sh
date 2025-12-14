#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Starting Universal Setup Script ---"

# Function to detect package manager and install packages
install_packages() {
    echo "Detecting package manager..."
    
    # List of packages to install:
    # 1. fastfetch (System info)
    # 2. lsix (Sixel image viewer - requires supported terminal like Konsole)
    # 3. zsh (Z Shell)
    # 4. fish (Friendly Interactive Shell)
    # 5. chafa (Universal terminal image viewer - works in ALL shells/terminals)
    
    if command -v apt &> /dev/null; then
        # Debian, Ubuntu, Linux Mint, Kali
        echo "Package manager 'apt' detected."
        sudo apt update
        echo "Installing fastfetch, shells, and image support..."
        sudo apt install -y fastfetch lsix zsh fish chafa

    elif command -v pacman &> /dev/null; then
        # Arch Linux, Manjaro
        echo "Package manager 'pacman' detected."
        echo "Installing fastfetch, shells, and image support..."
        # Note: lsix is in the AUR for Arch, trying standard repo first. 
        # If lsix fails via pacman, it must be installed manually or via yay/paru.
        sudo pacman -Syu --noconfirm fastfetch zsh fish chafa
        
        # Try to install lsix if available in repo, otherwise warn user
        if sudo pacman -S --noconfirm lsix 2>/dev/null; then
            echo "lsix installed successfully."
        else
            echo "Warning: lsix not found in standard Arch repos (use AUR). Proceeding..."
        fi

    elif command -v dnf &> /dev/null; then
        # Fedora, RHEL
        echo "Package manager 'dnf' detected."
        echo "Installing fastfetch, shells, and image support..."
        sudo dnf install -y fastfetch lsix zsh fish chafa

    elif command -v zypper &> /dev/null; then
        # openSUSE
        echo "Package manager 'zypper' detected."
        echo "Installing fastfetch, shells, and image support..."
        sudo zypper install -y fastfetch lsix zsh fish chafa

    elif command -v apk &> /dev/null; then
        # Alpine Linux
        echo "Package manager 'apk' detected."
        echo "Installing fastfetch, shells, and image support..."
        sudo apk add fastfetch lsix zsh fish chafa

    else
        echo "Error: No supported package manager found."
        exit 1
    fi
}

# Execute the installation function
install_packages

# 3. Move fastfetch contents
# Source directory (Relative path: assumes script is run from project root)
SOURCE_DIR="./fastfetch"
# Destination directory (Using $HOME to target the current user's home folder)
TARGET_DIR="$HOME/.config/fastfetch"

echo "3. Copying configuration files..."

# Check if the source directory exists before copying
if [ -d "$SOURCE_DIR" ]; then
    # Create the destination directory if it does not exist
    mkdir -p "$TARGET_DIR"

    # Copy all contents recursively from source to destination
    cp -r "$SOURCE_DIR/"* "$TARGET_DIR/"
    
    echo "Files copied successfully to: $TARGET_DIR"
else
    echo "Error: Source directory '$SOURCE_DIR' not found!"
    echo "Please ensure you are running the script from the same directory as the fastfetch folder."
    exit 1
fi

echo "--- Setup Completed Successfully ---"
echo "Installed Shells:"
echo "1. Bash (Default): $(which bash)"
echo "2. Zsh: $(which zsh)"
echo "3. Fish: $(which fish)"
echo ""
echo "Current active shell: $SHELL"
echo "To view images in any shell/terminal, you can now use 'chafa filename.png' or 'lsix filename.png'."