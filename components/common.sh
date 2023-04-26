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

pacman_install() {
    # shellcheck disable=SC2086
    for arg; do
        if ! pacman -Q "$arg" >/dev/null 2>&1; then
            echo "$arg"
        fi
    done | xargs $SUDO pacman --noconfirm --needed -S
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

NIXPKGS=${NIXPKGS:-https://nixos.org/channels/nixpkgs-unstable}

install_nix() {
    if [ "$OSTYPE" = WSL ]; then
        if ! has nix-env; then
            curl -L https://nixos.org/nix/install | sudorun sh -s -- --no-daemon
        fi
    elif [ "$OS" = arch ]; then
        if ! has nix-env; then
            pacman -S nix
        fi

        if ! grep -q "^nix-users:.*$USER" /etc/group; then
            sudorun sed -i -e "/^nix-users:/s/\$/ $USER/; /^nix-users:/s/: /:/;" /etc/group
            if ! grep -q "^nix-users:.*$USER" /etc/group; then
                echo >&2 "Failed to add user to the nix-users group, please do so manually, then re-login"
            else
                echo >&2 "User has been added to the nix-users group, please re-login"
            fi
        fi

        sudorun systemctl enable nix-daemon
        sudorun systemctl start nix-daemon
    else
        if ! has nix-env; then
            curl -L https://nixos.org/nix/install | sudorun sh -s -- --daemon
        fi
    fi

    setup_nix_shell

    if [ -n "$NIXPKGS" ]; then
        nix-channel --add "$NIXPKGS" nixpkgs
        nix-channel --update
    fi
}

setup_nix_shell() {
    # shellcheck disable=SC1090
    for i in /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ~/.nix-profile/etc/profile.d/nix-daemon.sh ~/.nix-profile/etc/profile.d/nix.sh; do
        if [ -e "$i" ]; then
            . "$i"
        fi
    done
}

setup_nix_shell
