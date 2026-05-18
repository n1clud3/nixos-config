# NVidia + Intel integrated Hybrid GPU config
# Tested on Dell G15 5530

{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.n1.hybrid-gpu = {
    enable = lib.mkEnableOption "Enable support for hybrid GPU setups.";
    intelBusId = lib.mkOption {
      type = lib.types.strMatching "([[:print:]]+:[0-9]{1,3}(@[0-9]{1,10})?:[0-9]{1,2}:[0-9])?";
      description = "Bus ID of the Intel GPU.";
    };
    nvidiaBusId = lib.mkOption {
      type = lib.types.strMatching "([[:print:]]+:[0-9]{1,3}(@[0-9]{1,10})?:[0-9]{1,2}:[0-9])?";
      description = "Bus ID of the NVidia GPU.";
    };
  };

  config = lib.mkIf config.n1.hybrid-gpu.enable {
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];

    hardware.graphics = {
      enable = true;

      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        intel-media-driver
      ];
    };

    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement.enable = true;
      powerManagement.finegrained = true;

      open = true;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };

        intelBusId = config.n1.hybrid-gpu.intelBusId;
        nvidiaBusId = config.n1.hybrid-gpu.nvidiaBusId;
      };
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      libva
      libva-utils
    ];
  };
}
