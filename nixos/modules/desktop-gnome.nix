{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    desktopManager.gnome = {
      enable = true;

      # Ensure the override applies to Mutter’s schema
      extraGSettingsOverridePackages = [ pkgs.mutter ];

      # Enable fractional scaling and sharper XWayland app behaviour
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer','xwayland-native-scaling']
      '';
    };
  };
}