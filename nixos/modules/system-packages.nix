{ pkgs, ... }: {
  services.flatpak.enable = true;

  # Core, system‑wide packages and dev tools
  environment.systemPackages = with pkgs; [
    # Appearance & Theming
    adwaita-icon-theme
    adw-gtk3
    gnome-shell-extensions
    gnome-tweaks

    # Applications
    gnome-software

    # Development Tools
    git
    nil
    nixfmt-rfc-style

    # Security & Encryption
    gnupg
    pinentry-gnome3
    sbctl

    # Utilities
    nautilus-open-any-terminal
    unzip
  ];

  environment.gnome.excludePackages = [ pkgs.gnome-console ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ptyxis";
  };

  # Ensure Flathub repo is available
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    after    = [ "network-online.target" ];
    requires = [ "network-online.target" ];
    path     = [ pkgs.flatpak ];

    script = ''
      flatpak remote-add --if-not-exists flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };
}
