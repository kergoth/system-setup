#!/bin/sh

if [ "$(id -u)" != "0" ]; then
    SUDO="sudo "
else
    SUDO=
fi

is_mac() {
    # shellcheck disable=SC3028
    case "${OSTYPE:-}" in
        darwin*)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
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
        msg "Running sudo, you may be prompted for your password.s"
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
