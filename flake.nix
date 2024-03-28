{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      
        modules = [
          ./desktop/hardware-configuration.nix
          ./desktop/nvidia-configuration.nix
          ./common.nix
          ./cachix.nix
        ];
      };

      nixosConfigurations.chromebook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
      
        modules = [
          ./chromebook/hardware-configuration.nix
          ./common.nix
          ./cachix.nix
        ];
      };
    };
}
