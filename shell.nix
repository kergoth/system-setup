# This is needed on macOS currently due to home manager expecting GNU readlink
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = [ pkgs.buildPackages.coreutils ];
}
