# hardware-configuration.nix
# Do not modify this file by hand -- the install script will populate it.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/nixos-root";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EFI_PARTITION_UUID_PLACEHOLDER";
    fsType = "vfat";
  };

  swapDevices = [{ device = "/dev/mapper/nixos-swap"; }];

  # Enables booting from an EFI system partition.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
