#!/bin/bash

set -euo pipefail

configuration="${1:-$(uname -s | tr '[:upper:]' '[:lower:]')}"

cd "$(dirname "$0")"
nix --experimental-features 'nix-command flakes' run .\#homeConfigurations."$configuration".activationPackage
