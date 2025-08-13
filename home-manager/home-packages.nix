{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Development
    vscode

    # Communication & Social
    vesktop
    zapzap

    # File Management & Sync
    megasync

    # Gaming / Streaming
    popcorntime
    showtime

    # Personal Tools
    keepassxc
    protonvpn-gui

    # Design & Media
    icon-library
    papers
    parabolic
    fragments
    mission-center
    ptyxis

    # Utilities
    github-desktop
  ];
}