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

die() {
    msg="$1"
    # shellcheck disable=SC2059
    printf "$msg\n" "$@" >&2
    exit 1
}

sudorun() {
    command $SUDO "$@"
}
