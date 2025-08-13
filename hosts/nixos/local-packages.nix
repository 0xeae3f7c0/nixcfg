{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Host‑specific packages
  environment.systemPackages = with pkgs; [
    gamemode
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    # Include icon theme for better runtime integration
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [ adwaita-icon-theme ];
    };
  };

  # Run the gamemode daemon so games can activate it
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "on";
        renice       = -10;
      };
      cpu = {
        governor = "performance"; # Prevent frequency scaling dips
      };
    };
  };

  xdg.icons.fallbackCursorThemes = [ "Adwaita" ];
}
