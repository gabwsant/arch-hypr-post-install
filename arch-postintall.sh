#!/usr/bin/env bash

set -e

# Output colors
GREEN="\e[32m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"

echo -e "${BLUE}Starting post-installation script...${ENDCOLOR}"

sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

source ./config.conf

chmod +x ./scripts/*.sh

echo -e "${GREEN}[1/4] Configuring system...${ENDCOLOR}"
./scripts/01-system.sh

echo -e "${GREEN}[2/4] Installing AUR Helper...${ENDCOLOR}"
./scripts/02-aur.sh

echo -e "${GREEN}[3/4] Installing Hyprland ecosystem packages...${ENDCOLOR}"
./scripts/03-packages.sh

echo -e "${GREEN}[4/4] Applying dotfiles...${ENDCOLOR}"
./scripts/04-dotfiles.sh

echo -e "${BLUE}Post-installation completed! Please reboot the system.${ENDCOLOR}"
