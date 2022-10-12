#!/bin/bash

set -euo pipefail

configuration="${1:-$(uname -s | tr '[:upper:]' '[:lower:]')}"

cd "$(dirname "$0")"
nix --experimental-features 'nix-command flakes' run .\#homeConfigurations."$configuration".activationPackage

if command -v nixwrap >/dev/null 2>&1; then
    nixwrap
fi
