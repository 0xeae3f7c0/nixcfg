{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Audio & Media Tools
    decibels
    qbittorrent

    # Communication & Social
    vesktop
    zapzap

    # Design & Media
    icon-library
    papers
    parabolic
    ptyxis

    # Development
    vscode

    # File Management & Sync
    megasync

    # Gaming / Streaming
    popcorntime
    showtime

    # Office & Productivity
    onlyoffice-desktopeditors
    sticky-notes

    # Personal Tools
    keepassxc
    protonvpn-gui

    # Utilities
    github-desktop
    mission-center
  ];
}