{ pkgs, commons ? import ../commons.nix { inherit pkgs; } }:

rec {
  target = commons.gnu-target;

  toolchain = commons.nightly commons.default {
    extensions = [ "rust-src" ];
    targets = [ target ];
  };

  isNightly = true;
}
