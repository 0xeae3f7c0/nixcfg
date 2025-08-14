{
  # TODO: Replace with actual hardware.nix

  boot.initrd.availableKernelModules = [
    "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"
    "sata_nv" "sata_via" "sata_sil24"
  ];

  boot.kernelModules = [ "wl" ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
