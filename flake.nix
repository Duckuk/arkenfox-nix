let
  sources = import ./npins;
  flake-utils = import sources.flake-utils;
in {
  description = "arkenfox/user.js as a Nix attribute set";

  outputs = {self}: (
    flake-utils.eachDefaultSystem
    (system:
      {
        # Use this to override nixpkgs if desired.
        # e.g `arkenfox-nix.loadModule {inherit pkgs;}`
        loadModule = import ./default.nix;
      }
      // (import ./default.nix {
        pkgs = import sources.nixpkgs {inherit system;};
        inherit system;
      }))
  );
}
