{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/f677051b8dc0b5e2a9348941c99eea8c4b0ff28f";
  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay/8ff1524472abef7c86c9e9c221d8969911074b4a";
  inputs.flake-utils.url = "github:numtide/flake-utils";


  outputs = { self, nixpkgs, emacs-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages = emacs-overlay.packages.${system};
          overlay = emacs-overlay.overlay;
        }
    );

}
