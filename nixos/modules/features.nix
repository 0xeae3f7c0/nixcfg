{ lib, ... }: {
  options.features.gpu.enableAmdVulkan = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable AMDVLK Vulkan driver for AMD GPUs.";
    example = true;
  };

  config.features.gpu.enableAmdVulkan = lib.mkDefault false;
}