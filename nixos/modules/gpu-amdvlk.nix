{ config, lib, pkgs, ... }: 

lib.mkIf config.features.gpu.enableAmdVulkan {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # Vulkan drivers for AMD GPUs
    extraPackages = with pkgs; [ amdvlk ];
    extraPackages32 = with pkgs.driversi686Linux; [ amdvlk ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
