{ pkgs, commons ? import ../commons.nix { inherit pkgs; } }:

rec {
  target = commons.gnu-target;

  toolchain = commons.stable commons.minimal {
    targets = [ target ];
  };

  isNightly = false;
}
