#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"
nix --experimental-features 'nix-command flakes'  flake update "$@"
