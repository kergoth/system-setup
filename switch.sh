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

package=".#homeConfigurations.$configuration.activationPackage"

cd "$(dirname "$0")"
./build.sh
nix run "$package" -- "$@"

if command -v nixwrap >/dev/null 2>&1; then
    nixwrap
fi
