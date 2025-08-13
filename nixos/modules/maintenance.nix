{
  # Enable automatic system upgrades without rebooting
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  # Garbage-collect Nix store weekly, keeping only the last 7 days
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
