let
  sources = import ./npins;
in
  {pkgs ? import sources.nixpkgs {}}: rec {
    packages.default = pkgs.callPackage ./package.nix {};

    # Intended for use in the programs.firefox.preferences NixOS module
    # Example of using arkenfox preferences as a base and overriding with user preference:
    # programs.firefox.preferences = arkenfox-nix.settings // {
    #   "privacy.clearOnShutdown.history" = false;
    # };
    settings = import packages.default;
  }
