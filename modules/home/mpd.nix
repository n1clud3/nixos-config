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
    lastfm = {
      enable = lib.mkEnableOption "Enable scrobbling?";
      username = lib.mkOption {
        type = lib.types.str;
        description = "Name of user for Last.fm";
      };

    };
  };
  config = lib.mkIf config.n1.mpd.enable {
    services.mpd = {
      enable = true;
      musicDirectory = config.n1.mpd.musicDir;

      extraConfig = ''
        audio_output {
          type     "pipewire"
          name     "PipeWire Output"
        }

        # Buffer tuning - helps with track transitions
        audio_buffer_size   "8192"
        buffer_before_play  "10%"

        # Quality of life
        restore_paused  "yes"
        auto_update     "yes"
        replaygain      "auto"
      '';
    };

    services.mpdscribble = {
      enable = config.n1.mpd.lastfm.enable;
      endpoints = {
        "last.fm" = {
          username = config.n1.mpd.lastfm.username;
          # echo -n "lastfmpassword" | md5sum | cut -d' ' -f1 > ~/.config/mpdscribble-pass
          passwordFile = "${config.home.homeDirectory}/.config/mpdscribble-pass";
        };
      };
    };

    home.packages = with pkgs; [
      euphonica
    ];
  };
}
