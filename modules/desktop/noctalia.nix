{ inputs, config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.noctalia = {
    home-manager.sharedModules = [
      inputs.noctalia.homeModules.default
      hm.noctalia
    ];
  };

  flake.modules.homeManager.noctalia = {
    programs.noctalia.enable = true;
  };
}
