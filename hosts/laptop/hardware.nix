{ lib, ... }: {
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" "coretemp" ];
    kernelParams = [ "applesmc.fan_control=1" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/ROOT";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/SWAP"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
