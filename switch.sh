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

./scripts/hm-nvd "$configuration"

hm --flake ".#$configuration" switch ${dry_run:+-n}

if command -v nixwrap >/dev/null 2>&1; then
    nixwrap
fi
