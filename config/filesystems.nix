{
  fileSystems = {
    "/" = {
      fsType = "tmpfs";
      options = [ "size=100m" ];
    };
    "/boot" = {
      device = "/dev/disk/by-partlabel/boot";
      fsType = "vfat";
    };
    "/nix/store" = {
      device = "/dev/disk/by-partlabel/nix-store";
      fsType = "squashfs";
    };
    "/home" = {
      device = "/dev/disk/by-partlabel/home";
      fsType = "ext4";
    };
    "/var" = {
      device = "/dev/disk/by-partlabel/var";
      fsType = "ext4";
    };
  };
}
