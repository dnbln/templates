{ pkgs, commons ? import ../commons.nix { inherit pkgs; } }:

rec {
  target = commons.musl-target;

  toolchain = commons.stable commons.minimal {
    targets = [ target ];
  };

  isNightly = false;
}
