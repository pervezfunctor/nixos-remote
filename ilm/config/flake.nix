{
  description = "ILM NixOS configuration";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./ssh.nix ];
      };

      nixosConfigurations.gnome = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./ui.nix ./gnome.nix ];
      };

      nixosConfigurations.kde = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./ui.nix ./kde.nix ];
      };

      nixosConfigurations.gnome-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./ui.nix ./gnome.nix ./vm.nix ];
      };

      nixosConfigurations.kde-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./ui.nix ./kde.nix ./vm.nix ];
      };

      nixosConfigurations.sway = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./ui.nix ./sway.nix ];
      };

      nixosConfigurations.sway-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./ui.nix ./sway.nix ./vm.nix ];
      };

      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./vm.nix
          ./ssh.nix
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [ spice-vdagent ];
          })
        ];
      };
    };
}
