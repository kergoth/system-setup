#!/bin/bash

nix () {
    command nix --experimental-features 'nix-command flakes' "$@"
}

set -euo pipefail

configuration="${1:-$(uname -s | tr '[:upper:]' '[:lower:]')}"
package=".#homeConfigurations.$configuration.activationPackage"

cd "$(dirname "$0")"

if command -v home-manager >/dev/null 2>&1; then
    generation="$(home-manager generations | head -n 1 | cut -d" " -f7)"
else
    generation="$(nix path-info "$package" 2>/dev/null)" || :
fi
nix build --no-link "$package"
new_generation="$(nix path-info "$package" 2>/dev/null)" || :
PATH="$new_generation/home-path/bin:$PATH"

if command -v nvd >/dev/null 2>&1; then
    if [ -n "$generation" ] && [ -n "$new_generation" ] && [ "$generation" != "$new_generation" ]; then
        nvd diff "$generation" "$new_generation"
    fi
fi
