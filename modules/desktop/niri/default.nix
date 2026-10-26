{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.niri = { pkgs, ... }: {
    programs.niri.enable = true;
    services.displayManager.ly.enable = true;
    environment.systemPackages = with pkgs; [
      alacritty
      fuzzel
      xwayland-satellite
    ];
    home-manager.sharedModules = [ hm.niri ];
  };

  # Out-of-store symlink, so config.kdl edits apply without a rebuild.
  flake.modules.homeManager.niri = { config, ... }: {
    xdg.configFile.niri = {
      source = config.lib.file.mkOutOfStoreSymlink
        "${config.home.homeDirectory}/nix-config/modules/desktop/niri";
      recursive = true;
    };
  };
}
