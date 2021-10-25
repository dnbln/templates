{ pkgs
, lib ? pkgs.lib
, toolchain-name ? "stable"
, extraNativeBuildInputs ? [ ]
, extraBuildInputs ? [ ]
, preCargoSetup ? ""
, postCargoSetup ? ""
, uselld ? true
, enableNightlyOpts ? true
}:

let
  toolchain = (import ./toolchain.nix {
    inherit pkgs;
    toolchain = toolchain-name;
    action = "dev";
  });
  env-commons = (import ./env-commons.nix {
    inherit lib uselld enableNightlyOpts;
    target = toolchain.target;
    isNightly = toolchain.isNightly;
  });
in
pkgs.mkShell {
  nativeBuildInputs = [
    toolchain.toolchain
  ] ++ extraNativeBuildInputs
  ++ lib.optionals uselld [
    pkgs.clang_12
  ];

  buildInputs = [
    pkgs.nixpkgs-fmt
  ] ++ extraBuildInputs;

  shellHook = preCargoSetup + env-commons.setup + postCargoSetup;
}
