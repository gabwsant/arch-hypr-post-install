#!/usr/bin/env bash

if ! command -v "$AUR_HELPER" &>/dev/null; then
  echo "Instalando o $AUR_HELPER..."
  sudo pacman -S --needed base-devel git --noconfirm

  mkdir -p /tmp/"$AUR_HELPER"
  git clone https://aur.archlinux.org/"$AUR_HELPER".git /tmp/"$AUR_HELPER"

  cd /tmp/"$AUR_HELPER" || exit
  makepkg -si --noconfirm
  cd - || exit
else
  echo "$AUR_HELPER já está instalado."
fi
