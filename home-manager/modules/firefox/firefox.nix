{ config, pkgs, lib, inputs ? {}, ... }:

let
  system = pkgs.system;
  nightlyProfileName = "nightly-profile";

  # Is the flake input provided, and does it have a build for this system?
  hasNightlyInput = inputs ? firefox-nightly;
  hasNightlyForSystem =
    hasNightlyInput && builtins.hasAttr system inputs.firefox-nightly.packages;

  themeSrc = pkgs.fetchFromGitHub {
    owner = "rafaelmardojai";
    repo = "firefox-gnome-theme";
    rev = "v141";
    sha256 = "9veVYpPCwKNjIK5gOigl5nEUN6tmrSHXUv4bVZkRuOE=";
  };
in
{
  programs.firefox = {
    enable = true;

    # Firefox profile
    profiles = {
      default-release = {
        isDefault = true;
        id = 0;

        userChrome = ''
          @import "firefox-gnome-theme/userChrome.css";
        '' + builtins.readFile ./overrides.userChrome.css;

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
    }
    # Conditionally add the Nightly profile
    // lib.optionalAttrs hasNightlyForSystem {
      ${nightlyProfileName} = {
        id = 1;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.tabs.drawInTitlebar" = true;
        };
      };
    };
  };

  # Theme files for the stable profile
  home.file = {
    ".mozilla/firefox/default-release/chrome/firefox-gnome-theme".source = themeSrc;
  }
  # Conditionally add the Nightly launcher so it always uses its own profile
  // lib.optionalAttrs hasNightlyForSystem {
    ".local/share/applications/firefox-nightly.desktop".text = ''
      [Desktop Entry]
      Name=Firefox Nightly
      Exec=firefox-nightly --no-remote --P ${nightlyProfileName} %u
      Icon=firefox-nightly
      Type=Application
      Categories=Network;WebBrowser;
      MimeType=text/html;text/xml;
      StartupNotify=true
      Terminal=false
    '';
  };

  # Default browser bindings
  xdg.mimeApps.defaultApplications = {
    "text/html"              = [ "firefox.desktop" ];
    "text/xml"               = [ "firefox.desktop" ];
    "x-scheme-handler/http"  = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
