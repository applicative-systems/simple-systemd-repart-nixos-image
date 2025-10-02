let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };

  inherit (pkgs.nixos [ ./config/configuration.nix ]) image;
in
{
  inherit image;

  demo-script = pkgs.writeShellScript "repart-image-qemu" ''
    set -euo pipefail

    DISK_IMAGE="demo-disk.raw"

    if [[ ! -f "$DISK_IMAGE" ]]; then
      cp ${image}/image.raw "$DISK_IMAGE"
      chmod +w "$DISK_IMAGE"
      ${pkgs.qemu}/bin/qemu-img resize -f raw "$DISK_IMAGE" "+10G"
    fi

    ${pkgs.qemu}/bin/qemu-system-x86_64 \
      -smp 4 \
      -m 2048 \
      --enable-kvm \
      -cpu host \
      -bios "${pkgs.OVMF.fd}/FV/OVMF.fd" \
      -hda "$DISK_IMAGE" \
      -serial stdio \
      -display gtk
  '';
}
