{ pkgs }:

let
  util-override = toolchain: profile: override: (profile toolchain).override override;
  st = pkgs.rust-bin.stable;
  bt = pkgs.rust-bin.beta;
  nt = pkgs.rust-bin.nightly;
in
rec {
  musl-target = "x86_64-unknown-linux-musl";
  gnu-target = "x86_64-unknown-linux-gnu";

  minimal = toolchain: toolchain.minimal;
  default = toolchain: toolchain.default;

  nightly-minimal = minimal nt;
  nightly-default = default nt;
  nightly =
    profile:
    override:
    (pkgs.rust-bin.selectLatestNightlyWith (toolchain: ((profile toolchain).override override)));

  beta-minimal = minimal bt;
  beta-default = default bt;
  beta = util-override bt;

  stable-minimal = minimal st;
  stable-default = default st;
  stable = util-override st;

  from-toolchain = pkgs.rust-bin.fromRustupToolchainFile;
}
