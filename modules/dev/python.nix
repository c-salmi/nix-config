{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.python = {
    home-manager.sharedModules = [ hm.python ];
  };

  flake.modules.homeManager.python = { pkgs, ... }: {
    home.packages = [ pkgs.uv ];
  };
}
