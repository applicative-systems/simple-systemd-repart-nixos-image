{ modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/image-based-appliance.nix")
    ./filesystems.nix
    ./image.nix
    ./desktop.nix
    ./size-reduction.nix
  ];

  boot.loader.grub.enable = false;

  services.getty.autologinUser = "root";
  users.users.root.initialPassword = "";

  system.stateVersion = "25.11";
}
