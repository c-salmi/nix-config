{ inputs, ... }:

{
  flake.modules.nixos.nix = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    # pkgs.unstable.<name> for packages that need to track nixos-unstable.
    nixpkgs.overlays = [
      (final: _: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        };
      })
    ];
  };
}
