#!/bin/sh

if [ "$(id -u)" != "0" ]; then
    SUDO="sudo "
else
    SUDO=
fi

has() {
    command -v "$@" >/dev/null 2>&1
}

# shellcheck disable=SC3028
case "${OSTYPE:-}" in
    darwin*)
        mac=1
        debian=0
        arch=0
        ;;
    *)
        mac=0
        if has apt-get; then
            debian=1
            arch=0
        elif has pacman; then
            debian=0
            arch=1
        fi
        ;;
esac

is_mac() {
    [ "$mac" -eq 1 ]
}

msg() {
    fmt="$1"
    # shellcheck disable=SC2059
    printf "$fmt\n" "$@" >&2
}

die() {
    msg "$@"
    exit 1
}

need_sudo() {
    if [ "$(id -u)" != "0" ]; then
        msg "Running sudo, you may be prompted for your password."
        if ! sudo -v; then
            die "Error: please run as root, or as a user that can run sudo."
        else
            # Keep-alive: update existing `sudo` time stamp until finished
            while true; do
                sudo -n true
                sleep 60
                kill -0 "$$" || exit
            done 2>/dev/null &
        fi
    fi
}

sudorun() {
    command $SUDO "$@"
}

pacman_install() {
    sudorun pacman -S --noconfirm --needed "$@"
}

apt_install() {
    sudorun apt-get -y install "$@"
}

map_pkg() {
    if [ -z "$NO_SUDO" ] && [ "$debian" -eq 1 ]; then
        case "$1" in
            ninja)
                echo ninja-build
                return
                ;;
            fd)
                echo fd-find
                return
                ;;
        esac
    fi
    echo "$1"
}

pkg_install() {
    pkg="$(map_pkg "$1")"
    if [ "$debian" -eq 1 ]; then
        case "$pkg" in
            gh | git-delta | shfmt)
                brew install "$pkg"
                ;;
            *)
                if [ -z "$NO_SUDO" ] && apt cache show "$pkg" >/dev/null 2>&1; then
                    apt_install "$pkg"
                else
                    brew install "$1"
                fi
                ;;
        esac
    elif [ "$arch" -eq 1 ]; then
        case "$pkg" in
            gh | pup)
                brew install "$pkg"
                ;;
            *)
                if [ -z "$NO_SUDO" ]; then
                    pacman_install "$pkg"
                else
                    brew install "$1"
                fi
                ;;
        esac
    else
        brew install "$1"
    fi
}
