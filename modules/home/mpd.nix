# Music player and daemon

{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.n1.mpd = {
    enable = lib.mkEnableOption "Enable mpd and a music player.";
    musicDir = lib.mkOption {
      type = lib.types.path;
      description = "Path to the music directory.";
    };
  };
  config = lib.mkIf config.n1.mpd.enable {
    services.mpd = {
      enable = true;
      musicDirectory = config.n1.mpd.musicDir;
    };

    home.packages = with pkgs; [
      euphonica
    ];
  };
}
