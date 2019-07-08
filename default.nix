{ }:

with import <nixpkgs> {};
with buildRustCrateHelpers;

let
  cratesIO = callPackage ./crates-io.nix {};
  Cargo = import ./Cargo.nix {
    inherit lib buildPlatform buildRustCrate buildRustCrateHelpers;
    inherit cratesIO fetchgit;
  };
  snoopy = (Cargo.snoopy {}).override {
    crateOverrides = defaultCrateOverrides // {
      snoopy = attrs: {
        buildInputs = [
          openssl libpcap
        ];
      };
    };
  };
in
  snoopy
