{ pkgs, ... }:
{
  environment.sessionVariables = {
    # Force Electron to use Wayland + fix fractional scaling
    NIXOS_OZONE_WL = "1";
    ELECTRON_ENABLE_SCALE_FACTOR = "true";
    GDK_SCALE = ""; # Optional: Let GNOME handle scale
    GDK_DPI_SCALE = ""; # Optional
  };

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vscode
    ghostty
    ptyxis
  ];
}
