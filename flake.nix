{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.myNixos = nixpkgs.lib.nixosSystem {
        inherit system;
      
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
}
