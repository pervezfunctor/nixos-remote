{
  description = "NixOS VM configuration";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./vm.nix ];
    };
    nixosConfigurations.gnome-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./gnome-vm.nix ];
    };
  };
}
