{ hostname, ... }: {
  home.sessionVariables = if hostname == "desktop" then {
    AMD_VULKAN_ICD = "RADV";
  } else {};
}
