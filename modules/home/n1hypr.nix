{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.n1.hyprland = {
    enable = lib.mkEnableOption "Enable n1clude's Hyprland DE.";
    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Path to the wallpaper for use with Hyprpaper.";
    };
  };
  config = lib.mkIf config.n1.hyprland.enable {
    #home.file = {
    #  ".config/hypr/hyprland.lua".source = ../../hyprland/hyprland.lua;
    #};
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      extraLuaFiles = {
        "00-vars" = ./hyprland/vars.lua;
        "autostart" = ./hyprland/autostart.lua;
        "general" = ./hyprland/general.lua;
        "input" = ./hyprland/input.lua;
        "looks" = ./hyprland/looks.lua;
        "bindings" = ./hyprland/binds.lua;
        "window-rules" = ./hyprland/window-rules.lua;
      };
    };

    home.packages = [
      pkgs.hyprshutdown
    ];

    programs.rofi.enable = true;
    programs.ghostty.enable = true;
    programs.btop.enable = true;
    programs.hyprshot.enable = true;
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };

      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "";
            path = config.n1.hyprland.wallpaper;
          }
        ];
      };
    };
  };
}
