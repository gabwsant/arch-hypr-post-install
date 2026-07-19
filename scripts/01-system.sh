#!/usr/bin/env bash

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm --needed pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber bluez bluez-utils networkmanager firewalld ipset iptables

sudo systemctl enable NetworkManager
sudo systemctl enable firewalld
sudo systemctl enable bluetooth

CPU_INTEL=("intel-ucode")
CPU_AMD=("amd-ucode")

GPU_INTEL=(
  "mesa"
  "mesa-utils"
  "lib32-mesa"
  "vulkan-intel"
  "lib32-vulkan-intel"
  "intel-media-driver"
  "lib32-intel-media-driver"
)

GPU_AMD=(
  "mesa"
  "mesa-utils"
  "lib32-mesa"
  "vulkan-radeon"
  "lib32-vulkan-radeon"
  "libva-mesa-driver"
  "lib32-libva-mesa-driver"
)

GPU_NVIDIA=(
  "nvidia-open-dkms"
  "nvidia-prime"
  "nvidia-settings"
  "nvidia-utils"
  "lib32-nvidia-utils"
)

# Enable Multilib in pacman.conf if it's not enabled (needed for lib32-* packages)
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
  echo "Enabling multilib repository..."
  sudo sed -i '/^#\[multilib\]/{N;s/#//g}' /etc/pacman.conf
  sudo pacman -Sy
fi

case "$CPU" in
INTEL)
  echo "Installing Intel microcode..."
  sudo pacman -S --noconfirm --needed "${CPU_INTEL[@]}"
  ;;
AMD)
  echo "Installing AMD microcode..."
  sudo pacman -S --noconfirm --needed "${CPU_AMD[@]}"
  ;;
*)
  echo "Specify CPU global variable (AMD or INTEL) in config.conf file."
  exit 1
  ;;
esac

case "$GPU" in
*INTEL*)
  echo "Installing Intel GPU drivers..."
  sudo pacman -S --noconfirm --needed "${GPU_INTEL[@]}"
  ;;
*AMD*)
  echo "Installing AMD GPU drivers..."
  sudo pacman -S --noconfirm --needed "${GPU_AMD[@]}"
  ;;
*NVIDIA*)
  echo "Installing NVIDIA GPU drivers..."
  sudo pacman -S --noconfirm --needed "${GPU_NVIDIA[@]}"
  ;;
*)
  echo "No GPU was specified. Skipping..."
  ;;
esac
