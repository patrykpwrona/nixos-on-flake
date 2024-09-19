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
          ./common/packages.nix
          ./specific/dell/hardware-configuration.nix
          ./specific/dell/thinkpad-specific.nix
        ];
        specialArgs = { inherit pkgs-unstable;};
      };
      nixosConfigurations."thinkpad" = nixpkgs.lib.nixosSystem {
        modules = [
          ./common/packages.nix
          ./specific/thinkpad/hardware-configuration.nix
          ./specific/thinkpad/thinkpad-specific.nix
        ];
      };
      homeConfigurations."pw" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };

}


