#!/bin/bash

set -ouex pipefail

### Bazzite + Zirconium Merge
### This keeps all Bazzite gaming/software and adds DMS/Niri from Zirconium

### Enable COPR repositories for DMS and Niri
dnf5 -y copr enable avengemedia/dms
dnf5 -y copr enable yalter/niri

### Install Niri + DMS (DankMaterialShell)
# DMS package includes quickshell and dependencies
dnf5 -y install \
	niri \
	dms \
	xwayland-satellite \
	xdg-desktop-portal-gnome

### Install additional Wayland tools (some may already be in Bazzite)
dnf5 -y install \
	mako \
	fuzzel \
	waybar \
	swayidle \
	swaylock \
	swaybg \
	grim \
	slurp \
	wl-clipboard \
	brightnessctl

### Install fonts (Maple Mono for terminals/DMS)
# Download and install Maple Mono font
MAPLE_VERSION="v7.0-beta36"
MAPLE_URL="https://github.com/subframe7536/maple-font/releases/download/${MAPLE_VERSION}"
curl -Lo /tmp/MapleMono.zip "${MAPLE_URL}/MapleMono-NF.zip"
curl -Lo /tmp/MapleMonoNF.zip "${MAPLE_URL}/MapleMono-NF-CN.zip"

mkdir -p /usr/share/fonts/maple-mono
unzip -q /tmp/MapleMono.zip -d /usr/share/fonts/maple-mono/
unzip -q /tmp/MapleMonoNF.zip -d /usr/share/fonts/maple-mono/
fc-cache -f

### Keep KDE Plasma (don't remove it - Bazzite users want it for gaming)
# Both KDE and Niri sessions will be available at login

### Enable services
systemctl enable podman.socket

### System-wide Niri configuration will be placed in system_files/
# User configs remain in ~/.config/niri/ as before
