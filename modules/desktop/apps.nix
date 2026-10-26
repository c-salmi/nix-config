{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.apps = {
    home-manager.sharedModules = [ hm.apps ];
  };

  flake.modules.homeManager.apps = { pkgs, ... }: {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
