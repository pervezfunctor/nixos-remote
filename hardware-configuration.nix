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
    "virtio_blk"
  ];

  fileSystems."/" = {
    device = "/dev/disk-by-label/root";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  boot.initrd.kernelModules = [ "dm-snapshot" "cryptd" ];
  boot.kernelModules = [ "kvm-intel" ]; # Or "kvm-amd" if your host is AMD
  boot.extraModulePackages = [ ];
  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/LUKS";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

}
