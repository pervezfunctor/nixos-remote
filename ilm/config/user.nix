{ config, pkgs, ... }: {
  users.users.me = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" ];
    initialPassword = "nixos";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIcXIDK5n+AIXExMo9nt1PRGcowyvyZUPvhBGRJRGMAl me@fedora"
    ];

  };
}
