let
  sources = import ./npins;
in
  {pkgs ? import sources.nixpkgs {}}: rec {
    package = pkgs.callPackage ./package.nix {};
    firefox-settings = import package;
  }
