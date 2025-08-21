{ config, lib, pkgs, ... }: {
  options.features.gpu.enableAmdVulkan = lib.mkOption {
    type = lib.types.bool;
    default = false;
    example = true;
    description = ''
      Enable the AMDVLK Vulkan driver for AMD GPUs.
      Installs both 64-bit and 32-bit packages and ensures the X server uses "amdgpu".
    '';
  };

  config = lib.mkIf config.features.gpu.enableAmdVulkan {
    hardware.graphics = {
      enable      = true;
      enable32Bit = true;
      extraPackages    = with pkgs; [ amdvlk ];
      extraPackages32  = with pkgs.driversi686Linux; [ amdvlk ];
    };

    services.xserver.videoDrivers = [ "amdgpu" ];
  };
}
