{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.cli-tools = {
    home-manager.sharedModules = [ hm.cli-tools ];
  };

  flake.modules.homeManager.cli-tools = { pkgs, ... }: {
    home.packages = with pkgs; [
      htop
      lm_sensors
    ];
  };
}
