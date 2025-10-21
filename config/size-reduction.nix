{
  lib,
  pkgs,
  config,
  ...
}:
{
#  hardware.graphics.enable = false;
#  services.speechd.enable = false;
#  services.pipewire.enable = false;
#  services.libinput.enable = false;
#
#  xdg.autostart.enable = lib.mkForce false;
#  xdg.menus.enable = lib.mkForce false;
#  xdg.mime.enable = lib.mkForce false;
#  xdg.terminal-exec.enable = false;
#
#  fonts.enableDefaultPackages = false;
#  fonts.packages = lib.mkForce [ pkgs.dejavu_fonts ];
#
#  services.xserver.desktopManager.session = lib.mkForce [
#    {
#      name = "none";
#      bgSupport = true; # if this bit is false we pull in a lot of deps
#      start = "";
#    }
#  ];
#
#  nixpkgs.overlays = [
#    (_final: prev: {
#      xdg-utils = prev.hello; # cheap fake xdg-utils that don't pull in Perl etc.
#      imlib2Full = prev.imlib2Full.override { jxlSupport = false; };
#    })
#  ];

}
