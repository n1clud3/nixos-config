{ ... }:

{
  imports = [
    ./../../modules/home/n1hypr.nix
    ./../../modules/home/zeditor.nix
    ./../../modules/home/mpd.nix
  ];

  home.username = "niclude";
  home.homeDirectory = "/home/niclude";
  home.stateVersion = "25.11";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    EDITOR = "vim";
  };

  n1.hyprland.enable = true;
  n1.mpd.enable = true;
  n1.mpd.musicDir = "/mnt/shared/Music";

  home.shell.enableZshIntegration = true;

  nixpkgs.config.allowUnfree = true;

  n1.zeditor.enable = true;
  services.ollama.enable = true;
  programs.vesktop.enable = true;
  programs.obsidian.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "mykola.malovanyi1@gmail.com";
        name = "n1clude";
      };
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_github";
        identitiesOnly = true;
      };
    };
  };

  services.playerctld.enable = true;
}
