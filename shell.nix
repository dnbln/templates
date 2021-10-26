{ utils ? import ./utils.nix
, pkgs ? import <nixpkgs> {
    overlays = [
      (utils.importRepo { user = "oxalica"; repo = "rust-overlay"; branch = "master"; })
    ];
  }
}:

let
  thor = utils.importRepo { user = "dblanovschi"; repo = "thor"; } { inherit pkgs; };
in
with thor.toolchainCommons;
thor.mkRustShell {
  # which toolchain?
  # valid values are "nightly", "nightly-musl", "stable", "stable-musl"
  # but you can build your own, with `{toolchain = nightly; target = targets.musl;}`
  # for example (same thing; `nightly` and `targets` come from thor.toolchainCommons)
  #
  # default: "nightly-musl"
  toolchain = "nightly-musl";

  # any extra nativeBuildInputs ?
  # default = []
  extraNativeBuildInputs = [ ];

  # any extra buildInputs ?
  # default = []
  extraBuildInputs = [
    pkgs.nixpkgs-fmt
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
