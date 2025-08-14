{ lib, ... }: let
  baseDir = ./.;

  baseFiles =
    builtins.filter
      (name:
        lib.hasSuffix ".nix" name
        && !lib.hasPrefix "_" name
      )
      (builtins.attrNames (builtins.readDir baseDir));
in
{
  imports = map (name: baseDir + "/${name}") baseFiles;
}
