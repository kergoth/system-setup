#!/usr/bin/env bash

nix () {
    command nix --experimental-features 'nix-command flakes' "$@"
}

set -euo pipefail

configuration="${1:-$(uname -s | tr '[:upper:]' '[:lower:]')}"
package=".#homeConfigurations.$configuration.activationPackage"

cd "$(dirname "$0")"

nix build --no-link "$package"
