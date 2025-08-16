{
  description = "0xeae3f7c0: configuration";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-25.05"; };
    home-manager = { url = "github:nix-community/home-manager/release-25.05"; inputs.nixpkgs.follows = "nixpkgs"; };
    spicetify-nix = { url = "github:Gerg-L/spicetify-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    lanzaboote = { url = "github:nix-community/lanzaboote/v0.4.2"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, lanzaboote, nixos-hardware, ... }@inputs:
  let
    system = "x86_64-linux";
    hostMeta = import ./hosts/metadata.nix;

    makeSystem = name: meta:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = meta // { inputs = { inherit home-manager spicetify-nix lanzaboote nixos-hardware; }; };
        modules =
          [ ./nixos/_imports.nix ./hosts/${name}/configuration.nix ]
          ++ (if name == "desktop" then [ lanzaboote.nixosModules.lanzaboote ] else []);
      };
  in {
    nixosConfigurations = nixpkgs.lib.mapAttrs makeSystem hostMeta;
  };
}