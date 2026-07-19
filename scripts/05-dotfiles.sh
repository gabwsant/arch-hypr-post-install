#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Clonning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

mkdir -p "$HOME/.config"

link_config() {
  local folder_name=$1
  if [ -d "$HOME/.config/$folder_name" ] && [ ! -L "$HOME/.config/$folder_name" ]; then
    mv "$HOME/.config/$folder_name" "$HOME/.config/${folder_name}_backup"
  fi
  ln -sfn "$DOTFILES_DIR/$folder_name" "$HOME/.config/$folder_name"
}

CONFIGS=("hypr" "waybar" "kitty" "rofi" "dunst" "btop" "zathura" "nvim" "mpv" "MangoHud")

for config in "${CONFIGS[@]}"; do
  if [ -d "$DOTFILES_DIR/$config" ]; then
    echo "Linking $config..."
    link_config "$config"
  fi
done
