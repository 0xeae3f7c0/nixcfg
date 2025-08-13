{ pkgs, ... }: {
  programs.gnome-shell.enable = true;

  home.packages =
    with pkgs; [
      dconf
    ]
    ++ (with gnomeExtensions; [
      app-hider
      appindicator
      bluetooth-battery-meter
      blur-my-shell
      just-perfection
      night-theme-switcher
      osd-volume-number
      reorder-workspaces
      rounded-window-corners-reborn
    ]);
}
