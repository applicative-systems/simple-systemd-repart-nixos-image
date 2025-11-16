{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/perlless.nix")
    (modulesPath + "/profiles/minimal.nix")
  ];

  nixpkgs.overlays = [
    (final: prev: {
      black = final.writeShellScriptBin "black" ''
        exit 0
      '';
      util-linux = prev.util-linux.override {
        systemdSupport = false;
        cryptsetupSupport = false;
        nlsSupport = false;
        ncursesSupport = false;
      };
      coreutils-full = final.coreutils;
      dbus = prev.dbus.override {
        x11Support = false;
      };
      wireplumber = prev.wireplumber.override {
        enableGI = false;
      };
      systemd = prev.systemd.override {
        withAcl = false;
        withAnalyze = false;
        withApparmor = false;
        withAudit = false;
        withCoredump = false;
        withDocumentation = false;
        withFido2 = false;
        withGcrypt = false;
        withHomed = false;
        withHostnamed = false;
        withHwdb = false;
        withImportd = false;
        withLibBPF = false;
        withLibarchive = false;
        withLibidn2 = false;
        withLocaled = false;
        withMachined = false;
        withNetworkd = false;
        withNss = false;
        withOomd = false;
        withPCRE2 = false;
        withPasswordQuality = false;
        withPolkit = false;
        withPortabled = false;
        withRemote = false;
        withResolved = false;
        withShellCompletions = false;
        withSysusers = false;
        withTimedated = false;
        withTimesyncd = false;
        withTpm2Tss = false;
        withUserDb = false;
        withVmspawn = false;
        # Needed
        withPam = false;
        withCompression = true;
        withLogind = false;
        withQrencode = true;
        withUkify = false;
        withEfi = true;
        withCryptsetup = true;
        withRepart = true;
        withSysupdate = false;
        withOpenSSL = false;
        withBootloader = true;
      };
    })
  ];

  fonts.enableDefaultPackages = false;
  fonts.fontconfig.enable = false;

  security.sudo.enable = false;
  networking.firewall.enable = false;

  networking.dhcpcd.enable = false;
  environment.etc."udev/hwdb.bin".enable = false;
  services.timesyncd.enable = false;
  systemd.oomd.enable = false;
  networking.wireless.enable = false;

  systemd.network.enable = false;
  networking.useNetworkd = false;
  services.resolved.enable = false;
  services.openssh.enable = lib.mkForce false;
  networking.useDHCP = false;

  # Complains about lastlog
  systemd.tmpfiles.packages = lib.mkForce [ ];

  # https://github.com/NixOS/nixpkgs/issues/404169
  security.pam.services.login.rules.session.lastlog.enable = lib.mkForce false;

  programs.nano.enable = false;
  security.polkit.enable = lib.mkForce false;
  programs.ssh.package = pkgs.runCommandNoCC "neutered" { } "mkdir -p $out";
  systemd.tpm2.enable = false;
  services.lvm.enable = false;
  boot.bcache.enable = false;
  powerManagement.enable = false;

  # Maybe in the end..
  # environment.systemPackages = lib.mkForce [ ];

  # Can save 1MB by disabling console
  # console.enable = false;

  boot.hardwareScan = false;

  boot.enableContainers = false;
  networking.resolvconf.enable = false;


  systemd.coredump.enable = false;
  systemd.repart.enable = false;
  system.switch.enable = false;
  nix.enable = false;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  environment.corePackages = lib.mkForce [];
  boot.initrd.systemd.suppressedUnits = [
    "systemd-logind.service"
    "systemd-user-sessions.service"
    "dbus-org.freedesktop.login1.service"
  ];
  systemd.suppressedSystemUnits = [
    "systemd-logind.service"
    "systemd-user-sessions.service"
    "dbus-org.freedesktop.login1.service"
  ];
  boot.initrd.systemd.suppressedStorePaths = [
    "${config.systemd.package}/example/systemd/system/systemd-logind.service"
    "${config.systemd.package}/example/systemd/system/systemd-user-sessions.service"
    "${config.systemd.package}/example/systemd/system/dbus-org.freedesktop.login1.service"
  ];
  boot.initrd.services.udev.packages = lib.mkForce [];
}
