#!/bin/bash

set -euo pipefail

configuration="${1:-$(uname -s | tr '[:upper:]' '[:lower:]')}"

cd "$(dirname "$0")"
generation="$(home-manager generations | head -n 1 | cut -d" " -f7)"
nix --experimental-features 'nix-command flakes' run .\#homeConfigurations."$configuration".activationPackage

if command -v nixwrap >/dev/null 2>&1; then
    nixwrap
fi

new_generation="$(home-manager generations | head -n 1 | cut -d" " -f7)"
if [ "$new_generation" != "generation" ] && command -v nvd >/dev/null 2>&1; then
    nvd diff "$generation" "$new_generation"
fi
