{
  description = "arkenfox/user.js as a Nix attribute set";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: (
    flake-utils.lib.eachDefaultSystemPassThrough
    (system: (import ./default.nix {
      inherit system;
      pkgs = import nixpkgs {inherit system;};
    }))
  );
}
