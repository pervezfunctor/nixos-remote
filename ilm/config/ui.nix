{ config, pkgs, ... }: {

  security.polkit.enable = true;

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;

  # @TODO: pick what you are using
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.swaylock.enableGnomeKeyring = true;
  # security.pam.services.sddm.enableGnomeKeyring = true; # if using SDDM

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-gtk  # For GTK environments
      # xdg-desktop-portal-kde  # Uncomment if using Plasma
      xdg-desktop-portal-wlr  # Uncomment if using Wayland compositor like Sway/Hyprland
    ];
    config.common.default = "*";
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";   # or "GNOME" / "KDE" etc.
    XDG_SESSION_TYPE = "wayland";  # or "x11"
  };

  programs.dconf.enable = true;

  # @TODO: This will be your hostname, so change this
  networking.hostName = "um580";

  # vscode server installation(when you ssh into this system with vscode)
  programs.nix-ld.enable = true;

  networking.networkmanager.enable = true;
  # networking.interfaces.enp1s0.useDHCP = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
