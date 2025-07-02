# configuration.nix (CORRECTED STRUCTURE)
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.kernelParams = [ 
    "ip=dhcp"
  ];

  networking.hostName = "ilm";
  networking.interfaces.enp1s0.useDHCP = true;  
  boot.initrd = { 
    availableKernelModules = [ "virtio_pci" "virtio_net" "virtio_scsi" "ahci" "sd_mod" ];
    network = {
      enable = true; 
      ssh = {
        enable = true;
        port = 2222;
        authorizedKeys = config.users.users.root.openssh.authorizedKeys.keys;
        hostKeys = [ "/etc/ssh/ssh_host_ed25519_key" ];
        shell = "/bin/cryptsetup-askpass";
      };
    };
  };

  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.pervez = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" "networkmanager" ];
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

  environment.systemPackages = with pkgs; [ 
    vim 
    git 
    wget
    bash
    curl
    coreutils
    git
    gnugrep
    openssh
    unzip
    xz
    glibc
    bat
    carapace
    curl
    delta
    emacs-nox
    eza
    fd
    fzf
    gcc
    gh
    htop
    just
    lazygit
    luarocks
    gnumake
    micro-with-wl-clipboard
    neovim
    nixfmt-classic
    nixd
    nixpkgs-fmt
    statix
    nushell
    ripgrep
    sd
    starship
    stow
    tmux
    trash-cli
    tree
    unzip
    wget
    zoxide
    zsh
  ];
  system.stateVersion = "25.05";
}

# ⚠️ Mount point '/boot' which backs the random seed file is world accessible, which is a security hole! ⚠️
# ⚠️ Random seed file '/boot/loader/.#bootctlrandom-seed9da23eb2cb97ee03' is world accessible, which is a security hole! ⚠️
