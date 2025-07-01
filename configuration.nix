# configuration.nix (CORRECTED STRUCTURE)
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fileSystems."/" = {
    device = "/dev/mapper/nixos-root";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };
  swapDevices = [{ device = "/dev/mapper/nixos-swap"; }];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = false;
  };

  boot.initrd.network.enable = true;

  boot.initrd.network.ssh = {
    enable = true;
    authorizedKeys = config.users.users.root.openssh.authorizedKeys.keys;
    hostKeys = [ "/etc/ssh/ssh_host_ed25519_key" ];
  };

  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/vda2";
    preLVM = true;
  };

  networking.hostName = "nixos-remote";
  networking.useDHCP = true;
  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.pervez = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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
  system.stateVersion = "25.05";
}
