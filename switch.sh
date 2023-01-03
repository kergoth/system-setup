#!/bin/bash

usage() {
    echo >&2 "${0##*/} [-n] [CONFIGURATION]"
    exit 2
}

nix () {
    command nix --experimental-features 'nix-command flakes' "$@"
}

if ! command -v home-manager &>/dev/null; then
    hm () {
        nix run --no-write-lock-file github:nix-community/home-manager/ -- "$@"
    }
else
    hm () {
        home-manager "$@"
    }
fi

set -euo pipefail

dry_run=
while getopts nh opt; do
    case "$opt" in
        n)
            dry_run=1
            ;;
        \? | h)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))

if [ $# -eq 0 ]; then
    configuration=$(uname -s | tr '[:upper:]' '[:lower:]')
else
    configuration=$1
    shift
fi

cd "$(dirname "$0")"
./build.sh "$configuration"

generation="$(hm generations | head -n 1 | cut -d" " -f7)" || :
if [ -n "$generation" ]; then
    package=".#homeConfigurations.$configuration.activationPackage"
    new_generation="$(nix path-info "$package" 2>/dev/null)" || :

    if command -v nvd >/dev/null 2>&1; then
        if [ -n "$generation" ] && [ -n "$new_generation" ] && [ "$generation" != "$new_generation" ]; then
            nvd diff "$generation" "$new_generation"
        fi
    fi
fi

hm --flake ".#$configuration" switch ${dry_run:+-n}

if command -v nixwrap >/dev/null 2>&1; then
    nixwrap
fi
