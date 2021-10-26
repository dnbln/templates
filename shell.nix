{ pkgs ? import <nixpkgs> { overlays = (import ./nix/overlays.nix); } }:

import ./nix/shell.nix {
  inherit pkgs;

  # which toolchain?
  # valid values are "nightly", "nightly-musl", "stable", "stable-musl"
  # default: "nightly-musl"
  toolchain-name = "nightly-musl";

  # any extra nativeBuildInputs ?
  # default = []
  extraNativeBuildInputs = [];

  # any extra buildInputs ?
  # default = []
  extraBuildInputs = [
    # say you need openssl
    pkgs.openssl
  ];

  # some shell code to run right before setting up cargo's env variables
  # default = ""
  preCargoSetup = "";

  # some shell code to run right after setting up cargo's env variables
  # default = ""
  postCargoSetup = "";

  # set up cargo's environment variables?
  # default = true
  setupCargoEnv = true;

  # true = use lld
  # false = use default linker (ld)
  # 
  # Important: takes effect only if setupCargoEnv = true
  # 
  # default = true
  uselld = true;

  # Enable nightly optimizations?
  # If not using a nightly toolchain, this option is ignored.
  #
  # Important: takes effect only if setupCargoEnv = true
  #
  # default = true
  enableNightlyOpts = true;
}
