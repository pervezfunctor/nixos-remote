{
  description = "ILM home-manager flake";

  inputs = {
    inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let system = "x86_64-linux";
    in {
      homeConfigurations.me = home-manager.lib.homeManagerConfiguration {
        inherit system;

        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        username = "me";
        homeDirectory = "/home/me";

        configuration = import ./home.nix;
      };
    };
}
