#!/bin/bash

source ./util.sh
source ./logger.sh

# Function to install paru
install_paru() {
    set_dir "/tmp/build"

    if ! is_installed git; then
        pacman -S --noconfirm git > /dev/null 2>&1

        if [ $? -ne 0 ]; then
            log_error "Failed to install git."
            exit 1
        fi
    fi

    if ! is_installed paru; then
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si

        if [ $? -ne 0 ]; then
            log_error "Failed to install paru."
            exit 1
        fi

        log_info "paru installed successfully."
    else
        log_info "paru is already installed."
    fi
}

# Function to configure chaotic-aur
configure_chaotic_aur() {
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    copy_system_file "/etc/pacman.conf"
}