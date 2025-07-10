{
  description = "ILM home-manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let system = "x86_64-linux"; # or "aarch64-linux"
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
