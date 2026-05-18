{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.n1hypr = {
    enable = lib.mkEnableOption "Enable n1clude's Hyprland DE.";
  };
  config = lib.mkIf config.n1hypr.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang";
      settings = {
        "$mod" = "SUPER";
        monitor = [
          "eDP-1, 1920x1080@360, 0x0, 1"
        ];
        bind = [
          "$mod, T, exec, ghostty" # terminal
          "$mod, R, exec, rofi -show drun" # menu
          "$mod, B, exec, firefox" # browser
          "$mod, E, exec, thunar" # file manager
          "$mod, F, fullscreen"
          "$mod, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
          "ALT, F4, killactive" # Alt+F4 functionality from Windows

          # Monocle layout controls
          "$mod, right, layoutmsg, cyclenext"
          "$mod, left, layoutmsg, cycleprev"
        ];
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];
        general = {
          gaps_in = 2;
          gaps_out = 5;

          border_size = 2;

          allow_tearing = true;

          layout = "monocle";
        };
        input = {
          kb_layout = "us,sk,ua";
          kb_variant = ",qwerty,";
          kb_options = "grp:win_space_toggle";
        };
        animations.enabled = false;
        windowrule = [
          "match:class hl_linux, immediate yes"
          "match:class hl2_linux, immediate yes"
        ];
      };
    };

    programs.rofi.enable = true;
    programs.ghostty.enable = true;
    programs.btop.enable = true;

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
  };
}
