{ config, pkgs, ... }: {
  # TODO: This will be your hostname, so change this
  networking.hostName = "nixos-ilm";

  programs.nix-ld.enable = true; # vscode server installation
  networking.networkmanager.enable = true;
  # networking.interfaces.enp1s0.useDHCP = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
