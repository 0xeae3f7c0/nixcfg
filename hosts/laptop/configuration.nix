{ stateVersion, hostname, inputs, user, homeStateVersion, ... }: {
  imports = [
    ./hardware.nix
    ./local-packages.nix
    ../../nixos/default.nix

    # Home Manager integration
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    # Forward flake args into the Home Manager module evaluation
    extraSpecialArgs = {
      inherit inputs user homeStateVersion;
      spicetify-nix = inputs.spicetify-nix;
    };

    users.${user} = {
      imports = [
        ../../home-manager/home.nix
      ];
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';

  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}
