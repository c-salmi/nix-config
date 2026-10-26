{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.bash = {
    home-manager.sharedModules = [ hm.bash ];
  };

  flake.modules.homeManager.bash = {
    programs.bash = {
      enable = true;
      bashrcExtra = builtins.readFile ./bashrc;
      shellAliases = {
        btw = "echo I use nixos, btw";
        rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#nixos-btw";
      };
    };
  };
}
