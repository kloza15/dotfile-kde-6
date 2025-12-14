#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Starting Universal Setup Script ---"

# Function to detect package manager and install packages
install_packages() {
    echo "Detecting package manager..."
    
    if command -v apt &> /dev/null; then
        # Debian, Ubuntu, Linux Mint, Kali, etc.
        echo "Package manager 'apt' detected."
        sudo apt update
        echo "1. Installing fastfetch..."
        sudo apt install -y fastfetch
        echo "2. Installing lsix..."
        sudo apt install -y lsix

    elif command -v pacman &> /dev/null; then
        # Arch Linux, Manjaro, EndeavourOS
        echo "Package manager 'pacman' detected."
        echo "1 & 2. Installing fastfetch and lsix..."
        # Note: lsix might need AUR helper (like yay) on some Arch systems, 
        # but we attempt standard repo or community first.
        sudo pacman -Syu --noconfirm fastfetch lsix

    elif command -v dnf &> /dev/null; then
        # Fedora, RHEL, CentOS, AlmaLinux
        echo "Package manager 'dnf' detected."
        echo "1 & 2. Installing fastfetch and lsix..."
        sudo dnf install -y fastfetch lsix

    elif command -v zypper &> /dev/null; then
        # openSUSE
        echo "Package manager 'zypper' detected."
        echo "1 & 2. Installing fastfetch and lsix..."
        sudo zypper install -y fastfetch lsix

    elif command -v apk &> /dev/null; then
        # Alpine Linux
        echo "Package manager 'apk' detected."
        echo "1 & 2. Installing fastfetch and lsix..."
        sudo apk add fastfetch lsix

    else
        echo "Error: No supported package manager found (apt, pacman, dnf, zypper, apk)."
        echo "Please install 'fastfetch' and 'lsix' manually."
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