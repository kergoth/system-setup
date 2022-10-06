#!/bin/sh

if [ "$(id -u)" != "0" ]; then
    SUDO="sudo "
else
    SUDO=
fi

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
    ;;
*)
    if [ -e /etc/os-release ]; then
        OS="$(sed -n -e 's/^ID=//p' /etc/os-release | tr '[:upper:]' '[:lower:]')"
    fi
    ;;
esac

is_mac() {
    [ "$OS" = macos ]
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

apt_install_gh() {
    if ! [ -e /usr/share/keyrings/githubcli-archive-keyring.gpg ]; then
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
            sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    fi &&
        if ! [ -e /etc/apt/sources.list.d/github-cli.list ]; then
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
        fi &&
        sudo apt update &&
        sudo apt install gh -y
}

pkg_install() {
    msg "Installing $1"
    {
        pkg="$(map_pkg "$1")"
        if [ "$debian" -eq 1 ]; then
            if [ -z "$NO_SUDO" ] && apt-cache show "$pkg" >/dev/null 2>&1; then
                apt_install "$pkg"
                return $?
            fi

            case "$pkg" in
            gh)
                if [ -z "$NO_SUDO" ]; then
                    apt_install_gh
                    return $?
                fi
                ;;
            shfmt)
                GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest
                return $?
                ;;
            fzf)
                go install github.com/junegunn/fzf/...@latest
                return $?
                ;;
            choose-rust)
                cargo install choose
                return $?
                ;;
            bat | exa | fd-find | git-absorb | git-delta | ripgrep)
                cargo install "$pkg"
                return $?
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
            return $?
        fi
        brew install "$1"
    } || {
        ret=$?
        msg "Error installing $1"
        return $ret
    }
}

