{ pkgs, ... }: let
  themeSrc = pkgs.fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = "master";
    sha256 = "KJjs4BdQ03X4jcc/aAcjO0PwHaYUYBAb6UIIL5fFslY=";
  };

in {
  programs.firefox = {
    enable = true;

    profiles.default-release = {
      isDefault = true;
      id = 0;

      # Load GNOME theme CSS and apply our overrides
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '' + (import ./overrides.userChrome.nix);

      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "browser.tabs.drawInTitlebar" = true;
        "gnomeTheme.hideSingleTab" = false;
        "gnomeTheme.oledBlack" = false;
      };
    };
  };

  home.file = {
    # Place the theme in Firefox's chrome directory
    ".mozilla/firefox/default-release/chrome/firefox-gnome-theme" = {
      source = themeSrc;
    };

    # Override default desktop entry to improve GNOME integration
    ".local/share/applications/firefox.desktop".text = ''
      [Desktop Entry]
        Name=Firefox
        Exec=firefox %u
        Icon=firefox
        Type=Application
        Categories=GNOME;GTK;Network;WebBrowser;
        MimeType=x-scheme-handler/http;x-scheme-handler/https;
        StartupNotify=true
        Terminal=false
    '';
  };

  # Ensure Firefox is default for web content
  xdg.mimeApps.defaultApplications = {
    "text/html"              = [ "firefox.desktop" ];
    "text/xml"               = [ "firefox.desktop" ];
    "x-scheme-handler/http"  = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
