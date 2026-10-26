{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  # Pi is installed with npm into ~/.local (see AGENTS.md), not from Nixpkgs.
  flake.modules.nixos.node-pi = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.nodejs_24 ];
    home-manager.sharedModules = [ hm.node-pi ];
  };

  flake.modules.homeManager.node-pi = {
    home.sessionPath = [ "$HOME/.local/bin" ];
  };
}
