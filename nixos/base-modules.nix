{ inputs }: [
  ./_imports.nix
  inputs.home-manager.nixosModules.home-manager
  ./nixos/home-manager-config.nix
]
