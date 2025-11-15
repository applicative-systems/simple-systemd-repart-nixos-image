{ pkgs, lib, ... }:
{
  boot.kernelPackages = pkgs.linuxPackagesFor ((pkgs.linuxKernel.manualConfig rec {
      inherit (pkgs.linux_testing) version src;
      modDirVersion = lib.versions.pad 3 version;
      configfile = ./kernelconfig;
      allowImportFromDerivation = false;
    }).overrideAttrs (_: {
#      postInstall = ''
#        mkdir -p $out/lib/modules/"$version"
#        touch  $out/lib/modules/"$version"/modules.order
#        touch  $out/lib/modules/"$version"/modules.builtin
#        rm $out/System.map
#      '';
    }));

#  boot.initrd.availableKernelModules = lib.mkForce [ ];
#  boot.kernelModules = lib.mkForce [ ];
#  boot.initrd.kernelModules = lib.mkForce [ ];
}
