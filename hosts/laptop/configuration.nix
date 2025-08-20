{ stateVersion, hostname, inputs, user, homeStateVersion, ... }: {
  imports = [
    ./hardware.nix
    ./local-packages.nix

    # Home Manager integration
    inputs.home-manager.nixosModules.home-manager

    # Model‑specific hardware configuration for MacBook Pro 11,1 (Retina 13" Late 2013)
    # Includes kernel params, drivers (Broadcom wl), and quirks tuned for this hardware
    inputs.nixos-hardware.nixosModules.apple-macbook-pro-11-1
  ] ++ (if builtins.pathExists ./secrets/secrets.nix then [ ./secrets/secrets.nix ] else []);

  home-manager = {
    # Forward flake args into the Home Manager module evaluation
    extraSpecialArgs = {
      inherit inputs user homeStateVersion hostname;
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

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-57-6.16"
    ];
  };

  environment.variables = {
    GSK_RENDERER = "ngl";
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';

  services.mbpfan = {
    enable = true;
    settings = {
      general = {
        low_temp  = 78; # °C — stay quiet under light load
        high_temp = 88; # °C — begin serious ramp‑up
        max_temp  = 94; # °C — trigger full speed before throttling

        polling_interval = 1;

        # Fan limits (typical for 13" Retina)
        min_fan_speed = 2000; # RPM — matches Apple’s idle baseline
        max_fan_speed = 6200; # RPM — close to hardware max
      };
    };
  };

  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}
