# flake.nix
{
  description = "A minimal NixOS configuration with remote unlock";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos-remote-unlock = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
