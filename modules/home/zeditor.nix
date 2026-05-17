# Zed editor configuration

{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.zeditor.enable = lib.mkEnableOption "Enable Zed editor.";

  config = lib.mkIf config.zeditor.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "github-theme"
      ];
      extraPackages = [
        pkgs.nixd
        pkgs.nil
      ];
      userSettings = {
        ui_font_size = 16;
        buffer_font_size = 16;
        cli_default_open_behavior = "existing_window";

        project_panel = {
          dock = "left";
        };

        agent = {
          dock = "right";
          sidebar_side = "right";
          default_profile = "ask";
          default_model = {
            provider = "ollama";
            model = "qwen3.5:4b";
            enable_thinking = false;
          };
        };

        edit_predictions = {
          provider = "ollama";
          mode = "subtle";
          ollama = {
            model = "qwen2.5-coder:1.5b";
            api_url = "http://127.0.0.1:11434";
          };
        };

        theme = {
          mode = "system";
          light = "GitHub Light";
          dark = "GitHub Dark";
        };
      };
    };
  };
}
