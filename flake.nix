{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:RobbieBuxton/nixos-hardware/master";
    earth-view.url = "github:nicolas-goudry/earth-view";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-index-database, earth-view, ... }:
    let
      standard-modules = [
        nix-index-database.nixosModules.nix-index
        { programs.nix-index-database.comma.enable = true; }
        earth-view.nixosModules.earth-view
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
          nixos-hardware.nixosModules.lenovo-ideapad-5-chromebook
          ./chromebook/hardware-configuration.nix
        ] ++ standard-modules;
      };
    };
}
