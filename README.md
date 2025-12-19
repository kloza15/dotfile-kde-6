<div align="center">
  
  # 🎨 Pixelform Dotfiles Auto-Installer
  
  **Transform your Linux aesthetic in seconds.**
  
  <!-- PREVIEW SECTION -->
  <img src="./screenshots/preview.png" alt="Terminal Preview" width="100%" style="border-radius: 10px; margin-bottom: 20px;">
  <img src="./screenshots/wallpaper.png" alt="Wallpaper Preview" width="100%" style="border-radius: 10px; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);">

  <br><br>

  [![Bash](https://img.shields.io/badge/language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
  [![Linux](https://img.shields.io/badge/OS-Linux-FCC624.svg)](https://www.linux.org/)

</div>

---

## 🧩 Compatibility & Details

*   **Supported OS:** Debian, Ubuntu, Fedora, Arch Linux, OpenSUSE, Alpine.
*   **Smart Dependency Handling:** Automatically compiles tools like `lsix` from source if they are missing from your distribution's repositories (e.g., on Ubuntu).
*   **Security:** Config files are deployed with secure permissions (`755`), ensuring your system remains safe.
*   **Directory Structure:** The scripts use **relative paths**. Do not move the `.sh` files outside the main folder, or they will lose access to the configuration files.

---

## 🚀 One-Line Installation (Full Setup)

Use this method to install **Fastfetch**, **Cava**, and the **Wallpaper** all at once. Just copy and paste this entire block into your terminal:

```bash
git clone https://github.com/kloza15/pixelform-dotfile.git && \
cd pixelform-dotfile && \
chmod +x *.sh && \
./1-install-fastfetch-v1-pixelform-dotfile.sh && \
./2-install-cava-v1-pixelform-dotfile.sh && \
./3-install-wallpaper-v1-pixelform-dotfile.sh
```

---

## 📦 Individual Module Installation (Single Code)

If you do not want the full package, you can install **just one specific component**.

First, clone the repository and enter the folder:
```bash
git clone https://github.com/kloza15/pixelform-dotfile.git
cd pixelform-dotfile
chmod +x *.sh
```

Then, run **only** the script you need:

### 1️⃣ Install System Info Only (Fastfetch)
Installs Fastfetch, Hack Nerd Font, and terminal configs.
```bash
./1-install-fastfetch-v1-pixelform-dotfile.sh
```

### 2️⃣ Install Visualizer Only (Cava)
Installs the Cava music visualizer and the custom gradient config.
```bash
./2-install-cava-v1-pixelform-dotfile.sh
```

### 3️⃣ Install Wallpaper Only
Detects your desktop environment and applies the Pixelform wallpaper.
```bash
./3-install-wallpaper-v1-pixelform-dotfile.sh
```

---

## ⚠️ Important: Final Step

**To make the icons appear correctly, you must manually change your terminal font.**

The installer adds **Hack Nerd Font** to your system, but it cannot change your terminal settings for you.

1.  Open your Terminal **Settings** or **Preferences**.
2.  Find the **Font** or **Appearance** section.
3.  Select **"Hack Nerd Font"** (or just "Hack").
4.  *Restart your terminal to see the changes.*

---

## 🎮 How to Use

Once installed, here is how to control your new tools:

### 🖥️ Fastfetch (System Info)
It launches automatically when you open a terminal. To run it again manually:
```bash
fastfetch
```

### 🎵 Cava (Music Visualizer)
Play some music, then run:
```bash
cava
```
**Controls:**
*   `Arrow Keys`: Adjust sensitivity and bar width.
*   `Q`: Quit.

---

## 🆘 Troubleshooting & Common Issues

If you encounter any issues during or after installation, check the solutions below:

### 1. Permission Denied
*   **Issue:** The terminal says permission is denied when running `./script.sh`.
*   **Solution:** You must make the scripts executable before running them.
    ```bash
    chmod +x *.sh
    ```

### 2. Broken Icons (Squares/Boxes □□□)
*   **Issue:** You see squares instead of icons in Fastfetch.
*   **Solution:** This is strictly a **Font Issue**.
    1.  Run `fc-cache -fv` to refresh the system font cache.
    2.  **Mandatory:** Go to your Terminal Settings and manually change the font to **Hack Nerd Font**. The script cannot do this step for you.

### 3. 'lsix' Installation Slow
*   **Issue:** The script pauses at "Installing lsix manually...".
*   **Reason:** On systems like Ubuntu, `lsix` is not in the official store. The script is downloading and compiling it from GitHub automatically. Please wait a few seconds for it to finish.

### 4. Cava (Visualizer) Not Moving
*   **Issue:** Cava opens but the bars don't react to music, or it crashes.
*   **Solution:** Cava needs to know your audio driver.
    1.  Open config: `nano ~/.config/cava/config`
    2.  Find `[input]`.
    3.  Change `method` to `pulse`, `pipewire`, or `alsa` depending on your system.

### 5. Wallpaper Not Changing
*   **Issue:** The background remains the same.
*   **Solution:**
    *   **GNOME/KDE:** Try setting it manually from the `screenshots/` folder.
    *   **Window Managers (i3/bspwm):** The script attempts to install `feh` automatically. If it fails, install it manually: `sudo apt install feh`.
