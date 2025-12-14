#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Starting Advanced Setup Script ---"

# 1. Detect System / Distribution
if [ -f /etc/os-release ]; then
    # Load OS details
    . /etc/os-release
    echo "Detected System: $NAME ($ID)"
else
    echo "Warning: Unable to detect specific distribution via /etc/os-release"
fi

# 2. Cleanup: Remove old fastfetch configuration
CONFIG_PATH="$HOME/.config/fastfetch"
echo "Cleaning up old configuration at: $CONFIG_PATH"
if [ -d "$CONFIG_PATH" ]; then
    rm -rf "$CONFIG_PATH"
    echo "Old configuration removed."
else
    echo "No old configuration found. Proceeding..."
fi

# 3. Universal Installation Function
# Installs: fastfetch, lsix, shells (zsh, fish), and chafa (for universal image support)
install_packages() {
    echo "--- Installing Packages ---"
    
    # Define package list
    # fastfetch: System information tool
    # lsix: Sixel-based image viewer (Works best in Konsole)
    # zsh: Z Shell
    # fish: Friendly Interactive Shell
    # chafa: Terminal graphics (Works in ALL shells/terminals)
    PACKAGES="fastfetch lsix zsh fish chafa"
    
    if command -v apt &> /dev/null; then
        # Debian / Ubuntu / Mint / Kali
        echo "Using 'apt' package manager..."
        sudo apt update
        sudo apt install -y $PACKAGES

    elif command -v pacman &> /dev/null; then
        # Arch Linux / Manjaro
        echo "Using 'pacman' package manager..."
        # Sync and install available packages
        sudo pacman -Syu --noconfirm fastfetch zsh fish chafa
        # lsix might be in AUR for Arch, trying generic repo just in case, 
        # or skipping if not found to prevent script failure.
        if sudo pacman -S --noconfirm lsix 2>/dev/null; then
             echo "lsix installed."
        else
             echo "Notice: 'lsix' not found in standard Arch repos. Please install via AUR (yay -S lsix)."
        fi

    elif command -v dnf &> /dev/null; then
        # Fedora / RHEL
        echo "Using 'dnf' package manager..."
        sudo dnf install -y fastfetch lsix zsh fish chafa

    elif command -v zypper &> /dev/null; then
        # openSUSE
        echo "Using 'zypper' package manager..."
        sudo zypper install -y fastfetch lsix zsh fish chafa

    elif command -v apk &> /dev/null; then
        # Alpine Linux
        echo "Using 'apk' package manager..."
        sudo apk add fastfetch lsix zsh fish chafa

    else
        echo "Error: No supported package manager found."
        exit 1
    fi
}

# Run the installation
install_packages

# 4. Move new configuration files
# Source directory (Relative path: assumes script is run from project root)
SOURCE_DIR="./fastfetch"
TARGET_DIR="$HOME/.config/fastfetch"

echo "--- Copying Configuration ---"

# Check if the source directory exists
if [ -d "$SOURCE_DIR" ]; then
    # Create the destination directory
    mkdir -p "$TARGET_DIR"

    # Copy all contents recursively
    cp -r "$SOURCE_DIR/"* "$TARGET_DIR/"
    
    echo "Configuration successfully copied to: $TARGET_DIR"
else
    echo "Error: Source directory '$SOURCE_DIR' not found!"
    echo "Please ensure you are running the script from the same directory as the fastfetch folder."
    exit 1
fi

echo "--- Setup Completed Successfully ---"
echo ""
echo "Installed Shells:"
echo "- Bash: $(command -v bash)"
echo "- Zsh:  $(command -v zsh)"
echo "- Fish: $(command -v fish)"
echo ""
echo "Image Support Info:"
echo "- Use 'lsix filename.png' for High-Res Sixel support (Requires Konsole/mlterm)."
echo "- Use 'chafa filename.png' for Universal support on ANY shell/terminal."