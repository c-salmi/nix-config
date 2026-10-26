{ inputs, ... }:

{
  flake.modules.nixos.nix = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    # The nix-config commit a generation was built from (shown by nixos-version);
    # a "-dirty" suffix means it had uncommitted changes.
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
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
