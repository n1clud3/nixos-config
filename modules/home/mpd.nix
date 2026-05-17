# Music player and daemon

{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.mpd = {
    enable = lib.mkEnableOption "Enable mpd and a music player.";
    musicDir = lib.mkOption {
      type = lib.types.path;
      description = "Path to the music directory.";
    };
  };
  config = lib.mkIf config.mpd.enable {
    services.mpd = {
      enable = true;
      musicDirectory = config.mpd.musicDir;
    };

    home.packages = with pkgs; [
      euphonica
    ];
  };
}
