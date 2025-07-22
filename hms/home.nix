{ config, pkgs, ... }: {
  home.username = "me";
  home.homeDirectory = "/home/me";
  home.stateVersion = "25.11";

  programs.git = {
    enable = true;
    userName = "Pervez Iqbal";
    userEmail = "pervezfunctor@gmail.com";
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = { "gtk-overlay-scrolling" = false; };
    gtk4.extraConfig = { "gtk-overlay-scrolling" = false; };
  };

  home.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh"; # adjust UID
  };

  home.file.".xprofile".text = ''
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
  '';

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
    sway.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.bash.enable = true;
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
