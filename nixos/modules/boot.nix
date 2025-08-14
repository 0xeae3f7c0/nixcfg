{ pkgs, hostname, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = hostname != "desktop";
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };
}
