{ config, pkgs, modulesPath, ... }: {
  imports = [ "${modulesPath}/virtualisation/qemu-vm.nix" ];

  virtualisation.memorySize = 16384;
  virtualisation.qemu.options = [
    "-device" "virtio-vga-gl"
    "-display" "gtk,gl=on,zoom-to-fit=off"
  ];

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;
  boot.initrd.enable = true;

  networking.hostName = "vm-host";
  #networking.useDHCP = true;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "vm";

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "modesetting" ];
  };

  users.users.vm = {
    isNormalUser = true;
    password = "qwerty";
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [ vim git htop ];

  system.stateVersion = "25.05";
}
