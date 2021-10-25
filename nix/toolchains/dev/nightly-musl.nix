{ pkgs, commons ? import ../commons.nix { inherit pkgs; } }:

rec {
  target = commons.musl-target;

  toolchain = commons.nightly commons.default {
    extensions = [ "rust-src" ];
    targets = [ target ];
  };

  isNightly = true;
}
