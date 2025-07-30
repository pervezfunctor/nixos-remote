{
  description = "ILM NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    { nixpkgs, agenix, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./ssh.nix
        ];
      };

      nixosConfigurations.gnome = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./ui.nix
          ./gnome.nix
        ];
      };

      nixosConfigurations.kde = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./ui.nix
          ./kde.nix
        ];
      };

      nixosConfigurations.gnome-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./ui.nix
          ./gnome.nix
          ./vm.nix
        ];
      };

      nixosConfigurations.kde-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./ui.nix
          ./kde.nix
          ./vm.nix
        ];
      };

      nixosConfigurations.sway = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./ui.nix
          ./sway.nix
        ];
      };

      nixosConfigurations.um580 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/um580/hardware-configuration.nix
          ./hosts/um580/fs.nix
          ./configuration.nix
          ./ui.nix
          ./sway.nix
          agenix.nixosModules.default
        ];
      };

      nixosConfigurations."7945hx" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/7945hx/hardware-configuration.nix
          ./hosts/7945hx/fs.nix
          ./configuration.nix
          ./ui.nix
          ./gnome.nix
          agenix.nixosModules.default
        ];
      };

      nixosConfigurations.sway-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./ui.nix
          ./sway.nix
          ./vm.nix
        ];
      };

      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./vm.nix
          ./ssh.nix
          (
            { pkgs, ... }:
            {
              environment.systemPackages = with pkgs; [ spice-vdagent ];
            }
          )
        ];
      };
    };
}
