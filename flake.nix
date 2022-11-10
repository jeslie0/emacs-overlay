{
  description = "A wrapper flake around the emacs-overlay, which fixes allows the nixpkgs input to be changed.";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, emacs-overlay, flake-utils }:
    {
      overlays = {
        default = final: prev: emacs-overlay.overlays.default final prev;
        emacs = final: prev: emacs-overlay.overlays.emacs final prev;
        packages = final: prev: emacs-overlay.overlays.package final prev;
      };
      overlay = self.overlays.default;

    } // flake-utils.lib.eachDefaultSystem (
      system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          packages = emacs-overlay.packages.${system};
        }
    );

}
