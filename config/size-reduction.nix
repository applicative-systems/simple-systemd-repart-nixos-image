{
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/perlless.nix")
  ];

  system.forbiddenDependenciesRegexes = lib.mkForce [];

  services.speechd.enable = false;
  hardware.graphics.enable = false;
  services.pipewire.enable = false;
  services.libinput.enable = false;

  nixpkgs.overlays = [
    (final: prev: {
      iproute2 = prev.iproute2.overrideAttrs (old: {
        outputs = old.outputs ++ [ "scripts" ];
        postInstall = old.postInstall or "" + ''
          moveToOutput sbin/routel "$scripts"
        '';
      });

      # cheaply patch away these packages as the
      # NixOS modules don't make it easy for us
      xdg-utils = prev.bash;
      feh = prev.bash;
    })
  ];


  fonts.enableDefaultPackages = false;
  fonts.fontconfig.enable = false;
  fonts.packages = lib.mkForce [ pkgs.dejavu_fonts ];

  security.sudo.enable = false;
  networking.firewall.enable = false;
}
