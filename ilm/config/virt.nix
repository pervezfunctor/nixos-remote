{ config, pkgs, ... }: {
  virtualisation.docker.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
    qemu.kvm.enable = true;
  };

  services.incus = {
    enable = true;
    settings = { core.https_address = ":8443"; };
  };

  users.users.me.extraGroups =
    [ "kvm" "libvirt" "incus" "incus-admin" "docker" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    libvirt
    qemu
    dnsmasq
    docker-compose
    incus
    incus-client
  ];
}
