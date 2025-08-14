{ lib, ... }: let
  moduleDir = ./modules;

  moduleFiles =
    builtins.filter
      (name:
        lib.hasSuffix ".nix" name
        && !lib.hasPrefix "_" name
      )
      (builtins.attrNames (builtins.readDir moduleDir));
in
{
  imports = map (name: moduleDir + "/${name}") moduleFiles;
}
