{
  description = "NixOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs : 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations."dell" = nixpkgs.lib.nixosSystem {
        modules = [
          ./common/bash.nix
          ./common/gaming.nix
          ./common/network.nix
          ./common/packages.nix
          ./common/system.nix
          ./common/users.nix
          ./specific/dell/hardware-configuration.nix
          ./specific/dell/dell.nix
        ];
        specialArgs = { inherit pkgs-unstable;};
      };
      nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
        modules = [
          ./common/bash.nix
          ./common/gaming.nix
          ./common/network.nix
          ./common/packages.nix
          ./common/system.nix
          ./common/users.nix
          ./specific/thinkpad/hardware-configuration.nix
          ./specific/thinkpad/thinkpad.nix
        ];
      };
      homeConfigurations."pw" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./common/home.nix
        ];
      };
    };

}


