#!/usr/bin/env bash

set -euo pipefail

out=$(nom build .#image --keep-going --print-out-paths)
outTL=$(nix build .#nixosConfigurations.appliance.config.system.build.toplevel --print-out-paths)

du -sh "$out"/*

echo "==============="

nix-store --query -R "$outTL" |
  xargs du -sm |
  sort -n |
  tail -n 10
