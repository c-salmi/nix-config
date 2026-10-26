{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.tmux = {
    home-manager.sharedModules = [ hm.tmux ];
  };

  flake.modules.homeManager.tmux = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      tmux
      tmuxp
    ];
    # Out-of-store symlink, so tmux.conf edits apply without a rebuild.
    xdg.configFile.tmux = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nix-config/modules/shell/tmux";
      recursive = true;
    };
  };
}
