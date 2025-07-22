{ config, pkgs, ... }: {
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    bash
    coreutils
    curl
    gawk
    gcc
    gh
    git
    glibc
    gnugrep
    gnumake
    htop
    micro-with-wl-clipboard
    nixd
    nixfmt-classic
    nushell
    statix
    shellcheck
    shfmt
    stow
    tmux
    trash-cli
    tree
    unzip
    vim
    wget
    xz
    zsh
    ripgrep
  ];
}
