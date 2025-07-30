{ pkgs, ... }: {
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    alejandra
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
    nil
    nixd
    nixfmt
    nushell
    ripgrep
    shellcheck
    shfmt
    statix
    stow
    tmux
    trash-cli
    tree
    unzip
    vim
    wget
    xz
    zsh
  ];
}
