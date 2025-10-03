{
  description = "Simple systemd-repart based NixOS appliance images";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.appliance = nixpkgs.lib.nixosSystem {
        modules = [
          ./config/configuration.nix
          { nixpkgs.hostPlatform = system; }
        ];
      };

      packages.${system} = {
        inherit (self.nixosConfigurations.appliance.config.system.build) image;
        default = self.packages.${system}.run-image;

        run-image = pkgs.callPackage ./run-image.nix {
          inherit (self.nixosConfigurations.appliance.config.system.build) image;
        };
      };
    };
}
