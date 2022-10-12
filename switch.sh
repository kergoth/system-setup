#!/bin/bash
#
nix () {
    command nix --experimental-features 'nix-command flakes' "$@"
}

set -euo pipefail

configuration="${1:-$(uname -s | tr '[:upper:]' '[:lower:]')}"
package=".#homeConfigurations.$configuration.activationPackage"

cd "$(dirname "$0")"
./build.sh "$@"
new_generation="$(nix path-info "$package" 2>/dev/null)" || :
"$new_generation/activate"

if command -v nixwrap >/dev/null 2>&1; then
    nixwrap
fi
