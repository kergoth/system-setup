#!/usr/bin/env bash

NIXPKGS=${NIXPKGS:-https://nixos.org/channels/nixpkgs-unstable}
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-$HOME/.brew}
export HOMEBREW_PREFIX
PATH="$HOMEBREW_PREFIX/bin:$XDG_DATA_HOME/../bin:$PATH"

has() {
    command -v "$@" >/dev/null 2>&1
}

# shellcheck disable=SC3028,SC2034
case "${OSTYPE:-}" in
darwin*)
    OS=macos
    SYSTEM=darwin
    ;;
*)
    case "$(uname -r)" in
    *Microsoft | *microsoft*)
        OSTYPE=WSL
        ;;
    esac

    if [ -e /etc/os-release ]; then
        OS="$(sed -n -e 's/^ID=//p' /etc/os-release | tr '[:upper:]' '[:lower:]')"
    fi
    SYSTEM=$(uname -s | tr '[:upper:]' '[:lower:]')
    ;;
esac

is_mac() {
    [ "$OS" = macos ]
}

is_freebsd() {
    [ "$OS" = freebsd ]
}

if [ "$(id -u)" != "0" ]; then
    if is_freebsd; then
        SUDO="doas "
    else
        SUDO="sudo "
    fi
else
    SUDO=
fi

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
        if is_freebsd; then
            if has doas && [ -e /usr/local/etc/doas.conf ] && [ "$(doas -C /usr/local/etc/doas.conf pkg)" = permit ]; then
                return 0
            else
                die "Error: please run as root, or as a user that can run doas."
            fi
        fi

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

pacman() {
    sudorun pacman --noconfirm --needed "$@"
}

component_source() {
    local scriptdir=$1
    local scriptname=$2

    if [ -n "$SYSTEM" ] && [ -e "$scriptdir/components/$SYSTEM/$scriptname" ]; then
        msg "Sourcing $scriptdir/components/$SYSTEM/$scriptname"
        # shellcheck disable=SC1090
        . "$scriptdir/components/$SYSTEM/$scriptname"
    fi
    if [ "$SYSTEM" = linux ] && [ -n "$OS" ] && [ -e "$scriptdir/components/$OS/$scriptname" ]; then
        msg "Sourcing $scriptdir/components/$OS/$scriptname"
        # shellcheck disable=SC1090
        . "$scriptdir/components/$OS/$scriptname"
    fi
}
