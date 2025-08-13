{ pkgs, ... }: {
  home.sessionVariables.AMD_VULKAN_ICD = "RADV";

  home.packages = with pkgs; [
    # Game launchers / runtimes
    lutris
    protonplus

    # Overlays & HUDs
    mangohud
    mangojuice

    # Compositor for gaming
    gamescope
  ];
}
