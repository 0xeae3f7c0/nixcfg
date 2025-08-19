{ lib, hostname, ... }: {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall.enable = true;
    useDHCP = lib.mkDefault true;
    interfaces.wlp10s0.useDHCP = lib.mkIf (hostname == "desktop") true;
  };

  hardware.enableRedistributableFirmware = lib.mkIf (hostname == "desktop") true;
}
