#!/usr/bin/env bash

AUR_HELPER=${AUR_HELPER:-yay}

echo "Installing System Tools and Personal Applications..."

# ---------------------------------------------------------
# 1. BASE SYSTEM & CORE UTILITIES
# ---------------------------------------------------------
SYS_BASE=(
  "acpi" "acpid" "chrony" "devtools" "flatpak" "fzf" "gvfs"
  "gvfs-gphoto2" "gvfs-mtp" "gvfs-smb" "man-db"
  "pacman-contrib" "plymouth" "timeshift" "tree-sitter-cli" "udisks2"
  "unzip" "zip" "zram-generator"
)

# ---------------------------------------------------------
# 2. MULTIMEDIA BACKEND & CODECS
# ---------------------------------------------------------
MEDIA_BACKEND=(
  "brightnessctl" "ffmpeg" "ffmpegthumbnailer" "ffnvcodec-headers"
  "gst-libav" "gst-plugin-pipewire" "gst-plugins-bad" "gst-plugins-base"
  "gst-plugins-good" "gst-plugins-ugly" "pamixer" "pavucontrol" "sof-firmware"
)

# ---------------------------------------------------------
# 3. PERSONAL APPS & USER PREFERENCES
# ---------------------------------------------------------
PERSONAL_APPS=(
  "thunar" "thunar-archive-plugin" "thunar-volman" "tumbler" "file-roller"
  "firefox"
  "nano" "neovim" "nvtop" "handlr-regex"
  "vlc" "mpv" "mpv-mpris" "zathura" "zathura-pdf-mupdf"
  "btop" "fastfetch"
  "kalk"
)

# ---------------------------------------------------------
# 4. SOFTWARE AUR PACKAGES (Hardware & Utilities)
# ---------------------------------------------------------
AUR_APP_PKGS=(
  "arch-update-full" "asusctl" "qview" "supergfxctl" "hyprmod"
)

PACMAN_APPS=("${SYS_BASE[@]}" "${MEDIA_BACKEND[@]}" "${PERSONAL_APPS[@]}")

echo "Installing Software & Utilities via Pacman..."
sudo pacman -S --noconfirm --needed "${PACMAN_APPS[@]}"

echo "Installing Software via AUR..."
$AUR_HELPER -S --noconfirm --needed "${AUR_APP_PKGS[@]}"

echo "Software installation completed!"
