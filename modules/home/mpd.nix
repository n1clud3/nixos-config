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

    home.packages = with pkgs; [
      euphonica
    ];
  };
}
