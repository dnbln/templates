{ pkgs ? import <nixpkgs> { overlays = (import ./nix/overlays.nix); } }:

import ./nix/shell.nix {
  inherit pkgs;
  toolchain-name = "nightly-musl"; # valid values are "nightly", "nightly-musl", "stable", "stable-musl"
}
