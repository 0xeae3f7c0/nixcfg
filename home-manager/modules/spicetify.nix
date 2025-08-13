{ pkgs, spicetify-nix, ... }: let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [ spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      adblock
      hidePodcasts
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      newReleases
    ];

    enabledSnippets =
      with spicePkgs.snippets;
      [
        autoHideFriends
        modernScrollbar
        hideNowPlayingViewButton
        hideFriendActivityButton
        hideMiniPlayerButton
      ]
      ++ [
        ''
          /* Hide homepage filter buttons: All, Music, Podcasts, Audiobooks */
            [aria-label="All"],
            [aria-label="Music"],
            [aria-label="Podcasts"],
            [aria-label="Audiobooks"] {
              display: none !important;
            }
        ''
      ];
  };
}
