{ pkgs, hostname, lib, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = lib.mkDefault (hostname != "desktop");
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };
}
