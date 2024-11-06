#!/bin/bash

source ./logger.sh

BUILD_DIR=/tmp/build

set_build_dir() {
    if [ ! -d $BUILD_DIR ]; then
        mkdir -p $BUILD_DIR

        if [ $? -ne 0 ]; then
            log_error "Failed to create build directory."
            exit 1
        fi

        log_info "Build directory created."
    else
        log_info "Build directory already exists."
    fi

    cd $BUILD_DIR
}

# Function to install paru
install_paru() {
    set_build_dir()

    if [ ! -x "$(command -v paru)" ]; then
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

# Function to display the menu
show_menu() {
    clear
    echo "====================="
    echo "  Arch Toolbox Menu  "
    echo "====================="
    echo "1. Update System"
    echo "2. Install Feature"
    echo "3. Remove Feature"
    echo "4. System Information"
    echo "5. Exit"
    echo "====================="
    echo -n "Please enter your choice [1-5]: "
}

# Function to update the system
update_system() {
    sudo pacman -Syu
}

# Function to install a list of packages in packages.txt
install_packages() {
    sudo pacman -S --noconfirm - < packages.txt
}

# Function to display system information
system_info() {
    uname -a
    lscpu
    free -h
}

install_paru

# Main loop
while true; do
    show_menu
    read choice
    case $choice in
        1) update_system ;;
        2) install_package ;;
        3) remove_package ;;
        4) system_info ;;
        5) exit 0 ;;
        *) echo "Invalid choice, please try again." ;;
    esac
    echo -n "Press any key to continue..."
    read -n 1
done