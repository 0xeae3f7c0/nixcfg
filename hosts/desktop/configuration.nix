{ pkgs, lib, stateVersion, hostname, inputs, user, homeStateVersion, ... }: {
  imports = [
    ./hardware.nix
    ./local-packages.nix

    # Home Manager integration
    inputs.home-manager.nixosModules.home-manager
  ] ++ (if builtins.pathExists ./secrets/secrets.nix then [ ./secrets/secrets.nix ] else []);

  home-manager = {
    extraSpecialArgs = {
      inherit inputs user homeStateVersion hostname;
      spicetify-nix = inputs.spicetify-nix;
    };

    users.${user} = {
      imports = [ ../../home-manager/home.nix ];
    };
  };

  boot = {
    loader.systemd-boot.enable = lib.mkForce false;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15s
  '';

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.sbctl
  ];

  networking.hostName = hostname;
  system.stateVersion = stateVersion;
}
