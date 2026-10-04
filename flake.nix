let
  sources = import ./npins;
  flake-utils = import sources.flake-utils;
in {
  description = "arkenfox/user.js as a Nix attribute set";

  outputs = {self}: (
    flake-utils.eachDefaultSystem
    (system: {
      module = import ./default.nix;
    })
  );
}
