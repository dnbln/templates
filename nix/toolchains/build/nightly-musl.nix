{ pkgs, commons ? import ../commons.nix { inherit pkgs; } }:

rec {
  target = commons.musl-target;

  toolchain = commons.nightly commons.minimal {
    targets = [ target ];
  };

  isNightly = true;
}
