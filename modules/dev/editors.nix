{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.editors = {
    home-manager.sharedModules = [ hm.editors ];
  };

  flake.modules.homeManager.editors = { pkgs, ... }: {
    home.packages = with pkgs; [
      vscode
      unstable.code-cursor
    ];
  };
}
