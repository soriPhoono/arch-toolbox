source ./logger.sh

set_dir() {
    if [ ! -d $1 ]; then
        mkdir -p $1

        if [ $? -ne 0 ]; then
            log_error "Failed to create directory at $1."
            exit 1
        fi

        log_info "Directory created at $1."
    else
        log_info "Directory $1 already exists."
    fi

    cd $1
}

is_installed() {
    return pacman -Qi $1 > /dev/null 2>&1
}