{
  description = "0xeae3f7c0: configuration";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-25.05"; };
    home-manager = { url = "github:nix-community/home-manager/release-25.05"; inputs.nixpkgs.follows = "nixpkgs"; };
    spicetify-nix = { url = "github:Gerg-L/spicetify-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    lanzaboote = { url = "github:nix-community/lanzaboote/v0.4.2"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, lanzaboote, ... }@inputs:
  let
    system = "x86_64-linux";
    user = "0xeae3f7c0";
    homeStateVersion = "25.05";

    hosts = [
      { hostname = "desktop"; stateVersion = "25.05"; }
      { hostname = "laptop";  stateVersion = "25.05"; }
    ];

    makeSystem = { hostname, stateVersion }: 
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostname user homeStateVersion stateVersion; };
        modules = [
          ./hosts/${hostname}/configuration.nix
        ]
        ++ (if hostname == "desktop" then [ inputs.lanzaboote.nixosModules.lanzaboote] else []);
      };
  in {
    nixosConfigurations =
      nixpkgs.lib.foldl'
        (configs: host:
          configs // {
            "${host.hostname}" = makeSystem {
              inherit (host) hostname stateVersion;
            };
          })
        {} hosts;
  };
}
