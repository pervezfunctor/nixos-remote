{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "nvme"
    "rtsx_pci_sdmmc"
    "usb_storage"
    "sd_mod"
    "sr_mod"
    "virtio_pci"
    "virtio_blk"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  boot.initrd.kernelModules = [ "dm-snapshot" "cryptd" "dm_mod" ];
  boot.kernelModules = [ "kvm-intel" ]; # Or "kvm-amd" if your host is AMD
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/LUKS";

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

}
