#!/usr/bin/env bash

AUR_HELPER=${AUR_HELPER:-yay}

echo "Installing Desktop Environment (Hyprland) and UI components..."

HYPR_ENV=(
  "cliphist" "dunst" "hyprcursor" "hypridle" "hyprland" "hyprlock"
  "hyprpaper" "hyprpicker" "hyprshot" "hyprshutdown" "hyprsunset"
  "kitty" "ly" "nwg-look" "polkit-kde-agent" "qt5-wayland" "qt6-wayland"
  "rofi-wayland" "waybar" "wl-clipboard" "wtype" "xdg-desktop-portal-gtk"
  "xdg-desktop-portal-hyprland" "xdg-user-dirs-gtk"
)

FONTS_THEMES=(
  "papirus-icon-theme" "ttf-jetbrains-mono" "ttf-jetbrains-mono-nerd"
  "ttf-opensans" "ttf-roboto" "woff2-font-awesome"
)

AUR_DE_PKGS=(
  "catppuccin-cursors-mocha" "catppuccin-gtk-theme-mocha" "hyprmod"
  "qt5ct-kde" "qt6ct-kde"
)

PACMAN_DE=("${HYPR_ENV[@]}" "${FONTS_THEMES[@]}")

echo "Installing Hyprland ecosystem via Pacman..."
sudo pacman -S --noconfirm --needed "${PACMAN_DE[@]}"

echo "Installing Desktop themes via AUR..."
$AUR_HELPER -S --noconfirm --needed "${AUR_DE_PKGS[@]}"

# Generate default user directories (Downloads, Documents, etc.)
echo "Generating user directories..."
xdg-user-dirs-update

echo "Desktop Environment installation completed!"
