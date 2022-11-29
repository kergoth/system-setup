#!/bin/bash
#
nix () {
    command nix --experimental-features 'nix-command flakes' "$@"
}

set -euo pipefail

if [ $# -eq 0 ]; then
    configuration=$(uname -s | tr '[:upper:]' '[:lower:]')
else
    configuration=$1
    shift
fi

cd "$(dirname "$0")"
./build.sh "$configuration"
if ! command -v home-manager &>/dev/null; then
    hm () {
        nix run --no-write-lock-file github:nix-community/home-manager/ -- "$@"
    }
else
    hm () {
        home-manager "$@"
    }
fi
hm --flake ".#$configuration" switch

if command -v nixwrap >/dev/null 2>&1; then
    nixwrap
fi
