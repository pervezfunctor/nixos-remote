{ config, pkgs, ... }: {
  services.displayManager.gdm.enable = true;
  programs.sway.enable = true;
}
