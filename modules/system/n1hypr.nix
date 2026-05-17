# To be used with home/n1hypr module.

{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.n1hypr.enable = lib.mkEnableOption "Enable system options for the home n1hypr module.";
  config = lib.mkIf config.n1hypr.enable {
    programs.thunar.enable = true;
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      brightnessctl
      pwvucontrol
    ];
  };
}
