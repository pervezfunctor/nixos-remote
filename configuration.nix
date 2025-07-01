# configuration.nix
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = false;
  };

  networking.hostName = "nixos-remote";
  networking.useDHCP = true;

  boot.initrd = {
    network.enable = true;
    network.ssh = {
      enable = true;
      # Use the same authorized keys as the main system's root user.
      # You can specify a different set of keys if you prefer.
      authorizedKeys = config.users.users.root.openssh.authorizedKeys.keys;
      # Reuse the host keys from the main system for consistency
      hostKeys = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    luks.devices."cryptroot" = {
      # The script will replace this placeholder with the actual LUKS partition UUID
      device = "/dev/disk/by-uuid/LUKS_PARTITION_UUID_PLACEHOLDER";
      # This tells NixOS that this device is unlocked early in the boot process.
      preLVM = true;
    };
  };

  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.pervez = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # For sudo access
    # After first boot, set the password with `sudo passwd pervez`
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcXIDK5n+AIXExMo9nt1PRGcowyvyZUPvhBGRJRGMAl pervez@fedora"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys =
    config.users.users.pervez.openssh.authorizedKeys.keys;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  environment.systemPackages = with pkgs; [ vim git wget zsh neovim curl tmux ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions,
  # are taken. It‘s perfectly fine and recommended to leave this value
  # chosen by the installer.
  system.stateVersion = "25.05"; # Did you read the comment?
}
