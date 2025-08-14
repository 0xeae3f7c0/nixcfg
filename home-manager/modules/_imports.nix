{ lib, ... }: let
  baseDir = ./.;

  # Recursively find all _imports.nix files in subdirectories
  findImports = dir:
    let
      entries = builtins.readDir dir;
      names   = builtins.attrNames entries;
      files   = builtins.filter (n: lib.hasSuffix ".nix" n) names;
      dirs    = builtins.filter (n: entries.${n} == "directory") names;

      # skip top-level one to avoid self-import loop
      current = builtins.filter (n: n == "_imports.nix" && dir != baseDir) files;

      # recurse into subdirs
      nested = lib.flatten (map (d: findImports (dir + "/${d}")) dirs);
    in
      (map (f: dir + "/${f}") current) ++ nested;

  # Also include all top-level modules here, excluding _*.nix
  topModules =
    builtins.filter
      (n: lib.hasSuffix ".nix" n && !lib.hasPrefix "_" n)
      (builtins.attrNames (builtins.readDir baseDir));
in
{
  imports =
    (map (f: baseDir + "/${f}") topModules)
    ++ (findImports baseDir);
}
