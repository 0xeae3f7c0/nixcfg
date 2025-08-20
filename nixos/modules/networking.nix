{ lib, hostname, ... }: {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall.enable = true;
    useDHCP = lib.mkDefault true;

    interfaces = lib.mkIf (hostname == "desktop") {
      wlp10s0.useDHCP = true;
    };
  };

  hardware = lib.mkIf (hostname == "desktop") {
    enableRedistributableFirmware = true;
  };
}
