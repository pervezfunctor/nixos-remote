{ config, pkgs, ... }: {
  home.username = "me";
  home.homeDirectory = "/home/me";
  home.stateVersion = "25.11";

  programs.git = {
    enable = true;
    userName = "Pervez Iqbal";
    userEmail = "pervezfunctor@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.nushell.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };

  # home.file.".zshrc".source = ./shell/zshrc;
  # home.file.".config/nushell/config.nu".source = ./shell/nu-config.nu;

  home.packages = with pkgs; [
    bat
    delta
    eza
    fd
    fzf
    neovim
    nodejs
    ripgrep
    starship
    sd
    tealdeer
    nushell
    yazi
    zoxide
    zsh
  ];
}
