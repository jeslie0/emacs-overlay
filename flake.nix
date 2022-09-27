{
  description = "A wrapper flake around the emacs-overlay, which fixes allows the nixpkgs input to be changed.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/f677051b8dc0b5e2a9348941c99eea8c4b0ff28f";
    emacs-overlay.url = "github:nix-community/emacs-overlay/8ff1524472abef7c86c9e9c221d8969911074b4a";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, emacs-overlay, flake-utils }:
    {
      overlays.default = final: prev: emacs-overlay.overlay final prev;
    } // flake-utils.lib.eachDefaultSystem (
      system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages = emacs-overlay.packages.${system};
        }
    );

}
