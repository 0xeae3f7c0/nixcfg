{ homeStateVersion, user, ... }: {
  imports = [
    ./modules/_imports.nix
    ./home-packages.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}