{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/image-based-appliance.nix")
    ./filesystems.nix
    ./image.nix
    #./size-reduction.nix
    ./kernel-without-modules.nix
  ];

  boot.loader.grub.enable = false;

  boot.kernelParams = [ "console=ttyS0,115200" "console=tty" ];


  services.getty.autologinUser = "root";
  users.users.root.initialPassword = "";

  system.stateVersion = "25.11";
}
