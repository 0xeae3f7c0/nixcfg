{ stateVersion, hostname, inputs, user, homeStateVersion, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./local-packages.nix
    ../../nixos/modules

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

  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}
