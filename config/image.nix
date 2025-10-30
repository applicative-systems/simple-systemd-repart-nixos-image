{
  modulesPath,
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [
    (modulesPath + "/image/repart.nix")
  ];

  image.repart =
    let
      inherit (pkgs.stdenv.hostPlatform) efiArch;
    in
    {
      name = "image";

      partitions = {
        esp = {
          contents = {
            "/EFI/BOOT/BOOT${lib.toUpper efiArch}.EFI".source =
              "${pkgs.systemd}/lib/systemd/boot/efi/systemd-boot${efiArch}.efi";

            "/EFI/Linux/${config.system.boot.loader.ukiFile}".source =
              "${config.system.build.uki}/${config.system.boot.loader.ukiFile}";
          };
          repartConfig = {
            Format = "vfat";
            Label = "boot";
            SizeMinBytes = "200M";
            Type = "esp";
          };
        };
        nix-store = {
          storePaths = [ config.system.build.toplevel ];
          nixStorePrefix = "/";
          repartConfig = {
            Format = "squashfs";
            Label = "nix-store";
            Minimize = "guess";
            ReadOnly = "yes";
            Type = "linux-generic";
          };
        };
      };
    };

  boot.initrd.systemd.repart.enable = true;
  boot.initrd.systemd.repart.device = "/dev/sda";
  services.systemd-repart.before = [
    "sysroot-etc.mount"
    "sysroot-nix-store.mount"
    "sysroot-var.mount"
  ];

  systemd.repart.partitions = {
    home = {
      Format = "ext4";
      Label = "home";
      Type = "home";
      Weight = 2000;
    };
    var = {
      Format = "ext4";
      Label = "var";
      Type = "var";
      Weight = 1000;
    };
  };
}
