{
  writeShellScriptBin,
  qemu,
  image,
  OVMF,
}:

writeShellScriptBin "repart-image-qemu" ''
  set -euo pipefail

  DISK_IMAGE="demo-disk.raw"

  if [[ ! -f "$DISK_IMAGE" ]]; then
    cp ${image}/image.raw "$DISK_IMAGE"
    chmod +w "$DISK_IMAGE"
    ${qemu}/bin/qemu-img resize -f raw "$DISK_IMAGE" "+10G"
  fi

  ${qemu}/bin/qemu-system-x86_64 \
    -smp 4 \
    -m 2048 \
    --enable-kvm \
    -cpu host \
    -bios "${OVMF.fd}/FV/OVMF.fd" \
    -hda "$DISK_IMAGE" \
    -serial stdio \
    -display gtk
''
