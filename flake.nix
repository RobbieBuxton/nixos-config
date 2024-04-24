{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-index-database, ... }:
    let
      standard-modules = [
        nix-index-database.nixosModules.nix-index
        { programs.nix-index-database.comma.enable = true; }
        ./common.nix
        ./cachix.nix
      ];
    in 
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      
        modules = [
          ./desktop/hardware-configuration.nix
          ./desktop/nvidia-configuration.nix
        ] ++ standard-modules;
      };

      nixosConfigurations.chromebook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      
        modules = [
          ./chromebook/hardware-configuration.nix
        ] ++ standard-modules;
      };
    };
}
