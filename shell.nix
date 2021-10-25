{ pkgs ? import <nixpkgs> { overlays = (import ./nix/overlays.nix); } }:

pkgs.mkShell {
  nativeBuildInputs = [
    (pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [ "rust-src" ];
      targets = [ "x86_64-unknown-linux-musl" ];
    }))
  ];

  buildInputs = [
    pkgs.nixpkgs-fmt
    pkgs.niv

    pkgs.clang_12
    pkgs.lld_12
  ];

  shellHook = ''
    export CC=clang
  '';
}
