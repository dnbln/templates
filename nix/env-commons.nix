{ target
, isNightly
, enableNightlyOpts
, uselld
, lib
, toolchain-utils ? import ./toolchains/utils.nix { inherit lib; }
}:

let
tt = toolchain-utils.targetTripleEnv target;
in
{
  setup = ''
    export CARGO_BUILD_TARGET="${target}"
  ''
  + (builtins.concatStringsSep "\n" (lib.optionals (isNightly && enableNightlyOpts) [
    ''export CARGO_TARGET_${tt}_LINKER="clang"''
    ''export CARGO_TARGET_${tt}_RUSTFLAGS="-Clink-arg=-fuse-ld=lld -Zshare-generics=y"''
  ]));
}
