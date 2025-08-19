{ lib, ... }: {
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E2E6-D347";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/20f2cb71-6711-4053-b07d-42e08eb2b960";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/c3fea9f3-9088-4b9e-85a8-584959516f93"; }
  ];

  nixpkgs.hostPlatform.system = "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
}
