let
  sources = import ./npins;
in
  {pkgs ? import sources.nixpkgs {}}: rec {
    packages.default = pkgs.callPackage ./package.nix {};

    # Intended for use in the programs.firefox.preferences NixOS module
    settings = import packages.default;
  }
